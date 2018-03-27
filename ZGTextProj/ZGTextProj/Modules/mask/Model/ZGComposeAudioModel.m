//
//  ZGComposeAudioModel.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/8/4.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import "ZGComposeAudioModel.h"
#import <AVFoundation/AVFoundation.h>

@implementation ZGComposeAudioModel


+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    static ZGComposeAudioModel *_composeAudioModel_ = nil;
    dispatch_once(&onceToken, ^{
        _composeAudioModel_ = [[ZGComposeAudioModel alloc] init];
    });
    
    return _composeAudioModel_;
}

/// 合并音频文件
/// @param sourceURLs 需要合并的多个音频文件
/// @param toURL      合并后音频文件的存放地址
/// 注意:导出的文件是:m4a格式的.

+ (void) sourceURLs:(NSArray *) sourceURLs composeToURL:(NSURL *) toURL completed:(void (^)(NSError *error)) completed{
    
    NSAssert(sourceURLs.count > 1,@"源文件不足两个无需合并");
    
    //  1. 创建`AVMutableComposition `,用于合并所有的音视频文件
    AVMutableComposition* mixComposition = [AVMutableComposition composition];
    
    
    //  2. 给`AVMutableComposition` 添加一个新音频的轨道,并返回音频轨道
    AVMutableCompositionTrack *compositionAudioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
    //  3. 循环添加需要的音频资源
    
    //  3.1 音频插入的开始时间,用于记录每次添加音频文件的开始时间
    CMTime beginTime = kCMTimeZero;
    //  3.2 用于记录错误的对象
    NSError *error = nil;
    //  3.3 循环添加音频资源
    for (NSURL *sourceURL in sourceURLs) {
        //      3.3.1 音频文件资源
        AVURLAsset  *audioAsset = [[AVURLAsset alloc]initWithURL:sourceURL options:nil];
        //      3.3.2 需要合并的音频文件的播放的时间区间
        CMTimeRange audio_timeRange = CMTimeRangeMake(kCMTimeZero, audioAsset.duration);
        //      3.3.3 添加音频文件
        //      参数说明:
        //      insertTimeRange:源录音文件的的区间
        //      ofTrack:插入音频的内容
        //      atTime:源音频插入到目标文件开始时间
        //      error: 插入失败记录错误
        //      返回:YES表示插入成功,`NO`表示插入失败
        BOOL success = [compositionAudioTrack insertTimeRange:audio_timeRange ofTrack:[[audioAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0] atTime:beginTime error:&error];
        //      3.3.4 如果插入失败,打印插入失败信息
        if (!success) {
            NSLog(@"插入音频失败: %@",error);
            completed(error);
            return;
        }
        //     3.3.5  记录下次音频文件插入的开始时间
        beginTime = CMTimeAdd(beginTime, audioAsset.duration);
    }
    
    //  4. 导出合并的音频文件
    //  4.0 创建一个导入M4A格式的音频的导出对象
    AVAssetExportSession* assetExport = [[AVAssetExportSession alloc] initWithAsset:mixComposition presetName:AVAssetExportPresetAppleM4A];
    //  4.2 设置导入音视频的URL
    assetExport.outputURL = toURL;
    //  导出音视频的文件格式
    assetExport.outputFileType = @"com.apple.m4a-audio";
    //  4.3 导入出
    [assetExport exportAsynchronouslyWithCompletionHandler:^{
        //      4.5 分发到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            completed(assetExport.error);
        });
    }];   
}

@end
