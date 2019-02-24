//
//  ZGAVAudioClipController.m
//  ZGTextProj
//
//  Created by ali on 2018/10/15.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGAVAudioClipController.h"
#import <AVFoundation/AVFoundation.h>

@interface ZGAVAudioClipController ()

@end

@implementation ZGAVAudioClipController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    /**
     * 裁剪音频，其实视频也是这样裁剪
     */
    [self audioClip];
}

- (void)audioClip
{
    //AVURLAsset是AVAsset的子类,AVAsset类专门用于获取多媒体的相关信息,包括获取多媒体的画面、声音等信息.而AVURLAsset子类的作用则是根据NSURL来初始化AVAsset对象.
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"audioClipTest2" ofType:@"mp3"];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"testZong" ofType:@"wav"];

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *resultPath =  [documentsDirectory stringByAppendingPathComponent:
//                             [NSString stringWithFormat:@"audioClipOk2.m4a"]];
    NSString *resultPath =  [documentsDirectory stringByAppendingPathComponent:
                             [NSString stringWithFormat:@"result.wav"]];
    NSLog(@"resultPath %@",resultPath);
    AVURLAsset *videoAsset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:filePath]];
    //音频输出会话
    //AVAssetExportPresetAppleM4A: This export option will produce an audio-only .m4a file with appropriate iTunes gapless playback data(输出音频,并且是.m4a格式)
    AVAssetExportSession *exportSession = [AVAssetExportSession exportSessionWithAsset:videoAsset presetName:AVAssetExportPresetAppleM4A];
    //设置输出路径 / 文件类型 / 截取时间段
    exportSession.outputURL = [NSURL fileURLWithPath:resultPath];
    exportSession.outputFileType = AVFileTypeAppleM4A;
    exportSession.timeRange = CMTimeRangeFromTimeToTime(CMTimeMake(0, 1), CMTimeMake(5, 1));
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        //exporeSession.status
    }];
}


@end
