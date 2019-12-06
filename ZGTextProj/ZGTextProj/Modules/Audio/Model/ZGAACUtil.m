//
//  ZGAACUtil.m
//  ZGTextProj
//
//  Created by XuZongGen on 2019/12/6.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGAACUtil.h"
#import <AVFoundation/AVFoundation.h>

@implementation ZGAACUtil

+ (double)fileDurationWithFilePath:(NSString *)filePath
{

    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    
    AVURLAsset *asset = [AVURLAsset assetWithURL:fileURL];
    CMTime   time = [asset duration];
    int seconds = ceil(time.value/time.timescale);
    NSLog(@"seconds %i",seconds);

    return seconds;
}


@end
