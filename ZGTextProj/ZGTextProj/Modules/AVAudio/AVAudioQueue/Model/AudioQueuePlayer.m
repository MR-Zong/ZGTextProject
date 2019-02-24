//
//  AudioQueuePlayer.m
//  ZGTextProj
//
//  Created by ali on 2019/1/2.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "AudioQueuePlayer.h"
#import <AVFoundation/AVFoundation.h>

#define AudioQueue_Buffer_Size 3 // 输出音频队列缓冲个数
#define kDefaultSampleRate 16000   //定义采样率为16000
#define MIN_SIZE_PER_FRAME 1920   //每个包的大小,室内机要求为960,具体看下面的配置信息


@interface AudioQueuePlayer (){
    AudioQueueRef _audioQueue; // 音频播放队列
    AudioStreamBasicDescription _audioDescription;
    AudioQueueBufferRef _audioQueueBuffers[AudioQueue_Buffer_Size]; // //音频缓存
    BOOL _audioQueueBufferUsed[AudioQueue_Buffer_Size]; // 音频缓存是否使用中
    NSLock *_sysnLock;
    NSMutableData *_tempData;
    OSStatus _osState;
    Byte *_pcmDataBuffer; // pcm的读文件数据区
    BOOL _started;
}

@end

@implementation AudioQueuePlayer

#pragma mark - 提前设置AVAudioSessionCategoryMultiRoute 播放和录音
+ (void)setupAudioSession
{
    NSError *error = nil;
    //只想要播放:AVAudioSessionCategoryPlayback
    //只想要录音:AVAudioSessionCategoryRecord
    //想要"播放和录音"同时进行 必须设置为:AVAudioSessionCategoryMultiRoute 而不是AVAudioSessionCategoryPlayAndRecord(设置这个不好使)
    BOOL ret = [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryMultiRoute error:&error];
    if (!ret) {
        NSLog(@"设置声音环境失败");
        return;
    }
    //启用audio session
    ret = [[AVAudioSession sharedInstance] setActive:YES error:&error];
    if (!ret)
    {
        NSLog(@"启动失败");
        return;
    }
}

- (instancetype)init
{
    if (self = [super init]) {
        _sysnLock = [[NSLock alloc] init];
        
        _pcmDataBuffer = malloc(MIN_SIZE_PER_FRAME);
        // 设置音频参数 具体的信息需要问后台
        _audioDescription.mSampleRate = kDefaultSampleRate;
        _audioDescription.mFormatID = kAudioFormatLinearPCM;
        _audioDescription.mFormatFlags =  kLinearPCMFormatFlagIsSignedInteger | kAudioFormatFlagIsPacked;
        // 单声道
        _audioDescription.mChannelsPerFrame = 1;
        //每一个packet一侦数据,每个数据包下的桢数，即每个数据包里面有多少桢
        _audioDescription.mFramesPerPacket = 1;
        //每个采样点16bit量化 语音每采样点占用位数
        _audioDescription.mBitsPerChannel = 16;
        _audioDescription.mBytesPerFrame = (_audioDescription.mBitsPerChannel / 8) * _audioDescription.mChannelsPerFrame;
        //每个数据包的bytes总数，每桢的bytes数*每个数据包的桢数
        _audioDescription.mBytesPerPacket = _audioDescription.mBytesPerFrame * _audioDescription.mFramesPerPacket;
        
        // 使用player内部的线程播放 新建输出
         OSStatus status = AudioQueueNewOutput(&_audioDescription, AudioPlayerAQoutputCallback, (__bridge void * _Nullable)(self), NULL, NULL, 0, &_audioQueue);
        if (status != noErr)
        {
            _audioQueue = NULL;
//            return;
        }
        
        // 设置音量
        AudioQueueSetParameter(_audioQueue, kAudioQueueParam_Volume, 1.0);
        
        // 初始化需要的缓冲区
        for (int i = 0; i < AudioQueue_Buffer_Size; i++) {
            _audioQueueBufferUsed[i] = NO;
            _osState = AudioQueueAllocateBuffer(_audioQueue, MIN_SIZE_PER_FRAME, &_audioQueueBuffers[i]);
        }
        
//        _osState = AudioQueueStart(_audioQueue, NULL);
//        if (_osState != noErr) {
//            NSLog(@"AudioQueueStart Error");
//        }

    }
    return self;
}


static void AudioPlayerAQoutputCallback(void* inUserData,AudioQueueRef audioQueueRef, AudioQueueBufferRef audioQueueBufferRef) {
    
     NSLog(@"AudioPlayerAQoutputCallback currentThread %@",[NSThread currentThread]);
    AudioQueuePlayer* audio = (__bridge AudioQueuePlayer*)inUserData;
    
    [audio resetBufferState:audioQueueRef and:audioQueueBufferRef];
}

- (void)resetBufferState:(AudioQueueRef)audioQueueRef and:(AudioQueueBufferRef)audioQueueBufferRef {
    // 防止空数据让audioqueue后续都不播放,为了安全防护一下
    if (_tempData.length == 0) {
        audioQueueBufferRef->mAudioDataByteSize = 1;
        Byte* byte = audioQueueBufferRef->mAudioData;
        byte = 0;
        AudioQueueEnqueueBuffer(audioQueueRef, audioQueueBufferRef, 0, NULL);
    }
    
    for (int i = 0; i < AudioQueue_Buffer_Size; i++) {
        // 将这个buffer设为未使用
        if (audioQueueBufferRef == _audioQueueBuffers[i]) {
            _audioQueueBufferUsed[i] = NO;
        }
    }
}

// 得到空闲的缓冲区
- (AudioQueueBufferRef)getNotUsedBuffer
{
    for (int i = 0; i < AudioQueue_Buffer_Size; i++) {
        if (NO == _audioQueueBufferUsed[i]) {
            _audioQueueBufferUsed[i] = YES;
            return _audioQueueBuffers[i];
        }
    }
    return NULL;
}

#pragma mark -
-(void)playWithData:(NSData *)data
{
    if ([data length] > MIN_SIZE_PER_FRAME)
    {
        return;
    }
//    [_sysnLock lock];
    NSLog(@"currentThread %@",[NSThread currentThread]);
    NSLog(@"paly data");
    _tempData = [NSMutableData new];
    [_tempData appendData: data];
    NSUInteger len = _tempData.length;
    [_tempData getBytes:_pcmDataBuffer length: len];
    
    AudioQueueBufferRef audioQueueBuffer = NULL;
    //获取可用buffer
    while (true) {
        [NSThread sleepForTimeInterval:0.0005];
        audioQueueBuffer = [self getNotUsedBuffer];
        if (audioQueueBuffer != NULL) {
            break;
        }
    }
    audioQueueBuffer -> mAudioDataByteSize =  (unsigned int)len;
    // 把bytes的头地址开始的len字节给mAudioData,向第i个缓冲器
    memcpy(audioQueueBuffer -> mAudioData, _pcmDataBuffer, len);
    //将第i个缓冲器放到队列中,剩下的都交给系统了
   OSStatus status = AudioQueueEnqueueBuffer(_audioQueue, audioQueueBuffer, 0, NULL);
    
    if (status == noErr)
    {
        if (!_started && ![self start])
        {
//            return NO;
        }
    }
//    [_sysnLock unlock];
}

- (BOOL)start
{
    OSStatus status = AudioQueueStart(_audioQueue, NULL);
    _started = status == noErr;
    if (status == noErr) {
        NSLog(@"start success");
    }
    return _started;
}

- (void)stop
{
    NSLog(@"Audio Player Stop");
    
    _started = NO;
    AudioQueueFlush(_audioQueue);
    AudioQueueReset(_audioQueue);
    AudioQueueStop(_audioQueue,TRUE);
}


- (void)cleanUp
{
    if(_audioQueue)
    {
        NSLog(@"Release AudioQueueNewOutput");
        
        [self stop];
        for(int i=0; i < AudioQueue_Buffer_Size; i++)
        {
            AudioQueueFreeBuffer(_audioQueue, _audioQueueBuffers[i]);
            _audioQueueBuffers[i] = nil;
        }
        _audioQueue = nil;
    }
}

@end
