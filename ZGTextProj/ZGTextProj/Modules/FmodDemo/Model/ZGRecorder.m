//
//  ZGRecorder.m
//  AudioProgress
//
//  Created by ali on 2019/1/16.
//  Copyright © 2019 赵成峰. All rights reserved.
//

#import "ZGRecorder.h"
#import <AVFoundation/AVFoundation.h>

@interface ZGRecorder () <AVAudioRecorderDelegate>

/**
 *  录音器
 */

@property (nonatomic, strong) AVAudioRecorder *recoder;

/**
 *  定时刷新器
 */
@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation ZGRecorder

+ (void)configAVAudioSession
{
    NSError *error = nil;
    AVAudioSession *audioSesion = [AVAudioSession sharedInstance];
//    BOOL success = [audioSession overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:&error];
//    if(!success)
//    {
//        NSLog(@"error doing outputaudioportoverride - %@", [error localizedDescription]);
//    }
    
    [audioSesion setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker error:&error];

    if (error) {
        NSLog(@"录音配置错误:%@",error);
        NSAssert(0, @"录音配置错误");
        return;
    }
    [audioSesion setActive:YES error:&error];
    if (error) {
        NSLog(@"active Error:%@",error);
        NSAssert(0, @"active Error");
        return;
    }
}

#pragma mark - 懒加载
- (CADisplayLink *)displayLink {
    if (_displayLink == nil) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(meteringRecorder)];
    }
    return _displayLink;
}

- (instancetype)initWithResultPath:(NSString *)resultPath
{
    if (self = [super init]) {
        
        // 设置录音文件存储路径
        NSString*path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];

        NSString *fileName = [NSString stringWithFormat: @"%.0f.%@", [NSDate timeIntervalSinceReferenceDate] * 1000.0, @"wav"];
        NSString *recordedTmpFile = [path stringByAppendingPathComponent:fileName];
        
        if (resultPath.length > 0) {
            recordedTmpFile = resultPath;
        }
        NSURL *url = [NSURL fileURLWithPath:recordedTmpFile];
        
        // 设置录音格式信息
        //16kHZ,单通道，16位，wav
        NSMutableDictionary*settingsDict = [NSMutableDictionary dictionary];
        
        // 音频格式
        settingsDict[AVFormatIDKey] =@(kAudioFormatLinearPCM);
        
        // 音频采样率
        settingsDict[AVSampleRateKey] =@(16000.0);
        
        // 音频通道数
        settingsDict[AVNumberOfChannelsKey] =@(2);
        
        // 线性音频的位深度
        settingsDict[AVLinearPCMBitDepthKey] =@(16);
        
        
        // 初始化录音器
        self.recoder = [[AVAudioRecorder alloc] initWithURL:url settings:settingsDict
                                                      error:nil];
//        float peakP = [self.recoder peakPowerForChannel:1];
//        float peakP2 = [self.recoder peakPowerForChannel:2];
//        NSLog(@"peakP %f peakP2 %f",peakP,peakP2);
        
        // 设置代理
        self.recoder.delegate = self;
        
        // 允许监听录音分贝
        self.recoder.meteringEnabled= YES;
        [self.recoder prepareToRecord];
    }
    return self;
}


/**
 *  开始录音
 */
- (void)start {
    // 准备录音(会生成一个无效的目标文件准备开始录音)
    if([self.recoder prepareToRecord]) {
        // 开始录音
        [self.recoder record];
        
        // 实时监听分贝改变(根据分贝可以判断是否需要录音)
        [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)meteringRecorder {
    // 刷新录音接收分贝
    [self.recoder updateMeters];
    
    // 输出平均分贝
    NSLog(@"%f", [self.recoder averagePowerForChannel:1]);
    
    
    
//    float   level;                // The linear 0.0 .. 1.0 value we need.
//    float   minDecibels = -80.0f; // Or use -60dB, which I measured in a silent room.
//    float   decibels    = [recorder averagePowerForChannel:0];
//
//    if (decibels < minDecibels)
//    {
//        level = 0.0f;
//    }
//    else if (decibels >= 0.0f)
//    {
//        level = 1.0f;
//    }
//    else
//    {
//        float   root            = 2.0f;
//        float   minAmp          = powf(10.0f, 0.05f * minDecibels);
//        float   inverseAmpRange = 1.0f / (1.0f - minAmp);
//        float   amp             = powf(10.0f, 0.05f * decibels);
//        float   adjAmp          = (amp - minAmp) * inverseAmpRange;
//
//        level = powf(adjAmp, 1.0f / root);
//    }
//
//    /* level 范围[0 ~ 1], 转为[0 ~120] 之间 */
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [_textLabel setText:[NSString stringWithFormat:@"%f", level*120]];
//    });

}

/**
 *  停止录音
 */
- (void)stop {
    // 停止录音
    [self.displayLink invalidate];
    [self.recoder stop];
}

#pragma mark - AVAudioRecorder代理方法
- (void)audioRecorderBeginInterruption:(AVAudioRecorder *)recorder {
    NSLog(@"开始被打断");
    [self.displayLink invalidate];
}
@end

