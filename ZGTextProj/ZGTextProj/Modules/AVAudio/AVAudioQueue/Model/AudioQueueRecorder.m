//
//  AudioQueueRecorder.m
//  ZGTextProj
//
//  Created by ali on 2019/1/2.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "AudioQueueRecorder.h"

#define AudioQueue_Buffer_Size 3 // 输出音频队列缓冲个数

#define kDefaultBufferDurationSeconds 0.03//调整这个值使得录音的缓冲区大小为960,实际会小于或等于960,需要处理小于960的情况
#define kDefaultSampleRate 16000   //定义采样率为16000

static BOOL isRecording = NO;

@interface AudioQueueRecorder (){
    AudioQueueRef _audioQueue; // 输出音频播放队列
    AudioStreamBasicDescription _recordFormat; // 音频参数
    AudioQueueBufferRef _audioBuffers[AudioQueue_Buffer_Size]; // 输出音频缓存
    uint32_t bufferByteSize; // 缓存区大小
}

@end

@implementation AudioQueueRecorder

- (instancetype)init
{
    if (self = [super init]) {
        
        // 重置数据
        memset(&_recordFormat, 0, sizeof(_recordFormat));
        
        _recordFormat.mSampleRate = kDefaultSampleRate;
        _recordFormat.mChannelsPerFrame = 1;
        _recordFormat.mFormatID = kAudioFormatLinearPCM;
        _recordFormat.mFormatFlags = kLinearPCMFormatFlagIsSignedInteger | kLinearPCMFormatFlagIsPacked;
        _recordFormat.mBitsPerChannel = 16;
        _recordFormat.mBytesPerFrame = (_recordFormat.mBitsPerChannel / 8) * _recordFormat.mChannelsPerFrame;
        _recordFormat.mBytesPerPacket = _recordFormat.mBytesPerFrame;
        _recordFormat.mFramesPerPacket = 1;
        
        // 初始化音频输入队列
        AudioQueueNewInput(&_recordFormat, inputBufferHandler, (__bridge void *)(self), NULL, NULL, 0, &_audioQueue);
        
        // 计算 估算的缓存区大小
        DeriveBufferSize(_audioQueue, _recordFormat, kDefaultBufferDurationSeconds, &bufferByteSize);
        
        NSLog(@"缓存区大小%d",bufferByteSize);
        
        // 创建缓冲区
        for (int i=0; i< AudioQueue_Buffer_Size; i++) {
            AudioQueueAllocateBuffer(_audioQueue, bufferByteSize, &_audioBuffers[i]);
            AudioQueueEnqueueBuffer(_audioQueue, _audioBuffers[i], 0, NULL);
        }
        
    }
    return self;
}

void inputBufferHandler(void *inUserData, AudioQueueRef inAQ, AudioQueueBufferRef inBuffer, const AudioTimeStamp *inStartTime,UInt32 inNumPackets, const AudioStreamPacketDescription *inPacketDesc)
{
    if (inNumPackets > 0) {
        AudioQueueRecorder *recorder = (__bridge AudioQueueRecorder*)inUserData;
        [recorder processAudioBuffer:inBuffer withQueue:inAQ];
    }
    if (isRecording) {
        AudioQueueEnqueueBuffer(inAQ, inBuffer, 0, NULL);
    }
}

// 处理数据，通过代理返回pcm实时数据流
- (void)processAudioBuffer:(AudioQueueBufferRef )audioQueueBufferRef withQueue:(AudioQueueRef )audioQueueRef
{
    NSMutableData * dataM = [NSMutableData dataWithBytes:audioQueueBufferRef->mAudioData length:audioQueueBufferRef->mAudioDataByteSize];
    
    if (dataM.length < bufferByteSize) { //处理长度小于bufferByteSize的情况,此处是补00
        Byte byte[] = {0x00};
        NSData * zeroData = [[NSData alloc] initWithBytes:byte length:1];
        for (NSUInteger i = dataM.length; i < bufferByteSize; i++) {
            [dataM appendData:zeroData];
        }
    }
    
    if(self.delegate&&[self.delegate respondsToSelector:@selector(audioQueueRecorder:pcmData:)]){
        [self.delegate audioQueueRecorder:self pcmData:dataM];
    }
}

#pragma mark -
-(void)startRecording
{
    // 开始录音
    AudioQueueStart(_audioQueue, NULL);
    isRecording = YES;
}

-(void)stopRecording
{
    if (isRecording)
    {
        isRecording = NO;
        //停止录音队列和移除缓冲区,以及关闭session，这里无需考虑成功与否
        AudioQueueStop(_audioQueue, true);
        //移除缓冲区,true代表立即结束录制，false代表将缓冲区处理完再结束
        AudioQueueDispose(_audioQueue, true);
    }
    NSLog(@"停止录音");
}


// 计算 估算的缓存区大小
void DeriveBufferSize (AudioQueueRef                audioQueue,
                       AudioStreamBasicDescription  ASBDescription,
                       Float64                      seconds,
                       UInt32                       *outBufferSize)
{
    static const int maxBufferSize = 0x50000;                 // 5
    
    int maxPacketSize = ASBDescription.mBytesPerPacket;       // 6
    if (maxPacketSize == 0) {                                 // 7
        UInt32 maxVBRPacketSize = sizeof(maxPacketSize);
        AudioQueueGetProperty (
                               audioQueue,
                               kAudioQueueProperty_MaximumOutputPacketSize,
                               // in Mac OS X v10.5, instead use
                               //   kAudioConverterPropertyMaximumOutputPacketSize
                               &maxPacketSize,
                               &maxVBRPacketSize
                               );
    }
    Float64 numBytesForTime = ASBDescription.mSampleRate * maxPacketSize * seconds; // 8
    *outBufferSize = (UInt32)(numBytesForTime < maxBufferSize ?
                              numBytesForTime : maxBufferSize);                     // 9
}

@end
