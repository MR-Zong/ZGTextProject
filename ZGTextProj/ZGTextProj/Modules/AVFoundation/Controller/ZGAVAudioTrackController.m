//
//  ZGAVAudioTrackController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/1/2.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGAVAudioTrackController.h"
#import <AVFoundation/AVFoundation.h>

@interface ZGAVAudioTrackController ()

@property (nonatomic,strong) UIButton *btn;

@end

@implementation ZGAVAudioTrackController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"AVFoundation";
    
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame = CGRectMake(100, 100, 100, 100);
    _btn.backgroundColor = [UIColor redColor];
    [_btn setTitle:@"提取音频" forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(getAudio:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
    
    
    
}


- (void)getAudio:(UIButton *)btn {
    
    // 创建源视频的Asset
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"videoWithAudio" ofType:@".mp4"];
    if (videoPath.length == 0) {
        NSLog(@"没有找到资源文件");
        return;
    }
    NSURL *videoUrl = [NSURL fileURLWithPath:videoPath];
    AVAsset *videoAsset = [AVAsset assetWithURL:videoUrl];
    
    NSArray *trackArray = [videoAsset tracksWithMediaType:AVMediaTypeAudio];
    if (trackArray.count == 0) {
        
        NSLog(@"没有音轨");
        return;
    }

    
        // 1 - Create AVMutableComposition object. This object will hold your AVMutableCompositionTrack instances.
        //创建一个AVMutableComposition实例
        AVMutableComposition *mixComposition = [[AVMutableComposition alloc] init];
        
        // 2 - Video track
        //创建一个轨道,类型是AVMediaTypeAudio
        AVMutableCompositionTrack *firstTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
    
            [firstTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, videoAsset.duration)
                                ofTrack:trackArray.firstObject atTime:kCMTimeZero error:nil];

        
        //获取firstAsset中的音频,插入轨道
//        [firstTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, firstAsset.duration)
//                            ofTrack:[[firstAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0] atTime:kCMTimeZero error:nil];
    
        //获取secondAsset中的音频,插入轨道
//        [firstTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, secondAsset.duration)
//                            ofTrack:[[secondAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0] atTime:firstAsset.duration error:nil];
    
        // 4 - Get path
        //创建输出路径
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:
                                 [NSString stringWithFormat:@"audio.m4a"]];
        NSURL *url = [NSURL fileURLWithPath:myPathDocs];
        NSLog(@"%@",url);
        
        // 5 - Create exporter
        //创建输出对象
    // AVAssetExportPresetHighestQuality
    // AVAssetExportPresetAppleM4A
    // AVAssetExportPresetPassthrough
        AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset:mixComposition
                                                                          presetName:AVAssetExportPresetPassthrough];
//    [AVAssetExportSession determineCompatibilityOfExportPreset:<#(nonnull NSString *)#> withAsset:<#(nonnull AVAsset *)#> outputFileType:<#(nullable AVFileType)#> completionHandler:<#^(BOOL compatible)handler#>];

    [exporter determineCompatibleFileTypesWithCompletionHandler:^(NSArray<AVFileType> * _Nonnull compatibleFileTypes) {
        [compatibleFileTypes enumerateObjectsUsingBlock:^(AVFileType  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"AVFileType: %@",obj);
        }];
    }];
    exporter.outputURL=url;
        // AVFileTypeAppleM4A
        // AVFileTypeMPEGLayer3
        exporter.outputFileType = AVFileTypeAppleM4A;
        //        @"com.apple.quicktime-movie";
        exporter.shouldOptimizeForNetworkUse = YES;
        
        [exporter exportAsynchronouslyWithCompletionHandler:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self exportDidFinish:exporter];
            });
        }];
    
    
}

-(void)exportDidFinish:(AVAssetExportSession*)session {
    NSLog(@"%ld",session.status);
    if (session.status == AVAssetExportSessionStatusCompleted) {
        NSURL *outputURL = session.outputURL;
        
        NSLog(@"%@",outputURL);
        
    }
}


@end
