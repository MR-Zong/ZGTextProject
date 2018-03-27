//
//  ZGImagesToVideoManager.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/8/4.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import "ZGImagesToVideoManager.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NSUInteger const fps = 1;

@implementation ZGImageFrameModel

- (void)setFrameDuration:(CGFloat)frameDuration
{
    _frameDuration = frameDuration;
    
    _keepPresentFrames = ceil(frameDuration) / fps;
}


+ (instancetype)imageFrameWithImage:(UIImage *)image frameDuration:(CGFloat)frameDuration
{
    ZGImageFrameModel *frame = [[ZGImageFrameModel alloc] init];
    frame.img = image;
    frame.frameDuration = frameDuration;
    return frame;
}

@end




#pragma mark -
@implementation ZGImagesToVideoManager

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    static ZGImagesToVideoManager *_imagesToVideoManager_ = nil;
    dispatch_once(&onceToken, ^{
        _imagesToVideoManager_ = [[ZGImagesToVideoManager alloc] init];
    });
    
    return _imagesToVideoManager_;
}



- (NSString *)compressionWithImagesArray:(NSArray<ZGImageFrameModel *>*)imagesArray
{
    //设置mov路径
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *moviePath =[[paths objectAtIndex:0]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mov",@"test"]];
//    self.theVideoPath=moviePath;
    
    //定义视频的大小320 480 倍数
    CGSize size =CGSizeMake(320,480);
    
    //        [selfwriteImages:imageArr ToMovieAtPath:moviePath withSize:sizeinDuration:4 byFPS:30];//第2中方法
    
    NSError *error =nil;
    //    转成UTF-8编码
    unlink([moviePath UTF8String]);
    NSLog(@"path->%@",moviePath);
    //     iphone提供了AVFoundation库来方便的操作多媒体设备，AVAssetWriter这个类可以方便的将图像和音频写成一个完整的视频文件
    AVAssetWriter *videoWriter = [[AVAssetWriter alloc] initWithURL:[NSURL fileURLWithPath:moviePath] fileType:AVFileTypeQuickTimeMovie error:&error];
    
    NSParameterAssert(videoWriter);
    if(error)
    {
        NSLog(@"error =%@", [error localizedDescription]);
    }
    //mov的格式设置 编码格式 宽度 高度
    NSDictionary *videoSettings =[NSDictionary dictionaryWithObjectsAndKeys:AVVideoCodecH264,AVVideoCodecKey,
                                  [NSNumber numberWithInt:size.width],AVVideoWidthKey,
                                  [NSNumber numberWithInt:size.height],AVVideoHeightKey,nil];
    
    AVAssetWriterInput *writerInput =[AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo outputSettings:videoSettings];
    
    NSDictionary*sourcePixelBufferAttributesDictionary =[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:kCVPixelFormatType_32ARGB],kCVPixelBufferPixelFormatTypeKey,nil];
    //    AVAssetWriterInputPixelBufferAdaptor提供CVPixelBufferPool实例,
    //    可以使用分配像素缓冲区写入输出文件。使用提供的像素为缓冲池分配通常
    //    是更有效的比添加像素缓冲区分配使用一个单独的池
    AVAssetWriterInputPixelBufferAdaptor *adaptor =[AVAssetWriterInputPixelBufferAdaptor assetWriterInputPixelBufferAdaptorWithAssetWriterInput:writerInput sourcePixelBufferAttributes:sourcePixelBufferAttributesDictionary];
    
    NSParameterAssert(writerInput);
    NSParameterAssert([videoWriter canAddInput:writerInput]);
    
    if ([videoWriter canAddInput:writerInput])
    {
        NSLog(@"11111");
    }
    else
    {
        NSLog(@"22222");
    }
    
    [videoWriter addInput:writerInput];
    
    [videoWriter startWriting];
    [videoWriter startSessionAtSourceTime:kCMTimeZero];
    
    //合成多张图片为一个视频文件
    dispatch_queue_t dispatchQueue =dispatch_queue_create("mediaInputQueue",NULL);
    int __block frameIndex =0;
    int __block imageIndex = 0;
//    int videoDuration = 0;
//    int totalFrame = videoDuration * fps;
    int totalFrames = 0;
    for (ZGImageFrameModel *imgFrame in imagesArray) {
        totalFrames += imgFrame.keepPresentFrames;
    }
    
    ZGImageFrameModel *imgFrame = imagesArray[0];
    NSUInteger __block tmpKeepPresentFrames = imgFrame.keepPresentFrames;
    
    [writerInput requestMediaDataWhenReadyOnQueue:dispatchQueue usingBlock:^{
        
        while([writerInput isReadyForMoreMediaData])
        {
            if(frameIndex >= totalFrames)
            {
                [writerInput markAsFinished];
                //                [videoWriter finishWriting];
                [videoWriter finishWritingWithCompletionHandler:^{
                    ;
                }];
                break;
            }
            
            if (tmpKeepPresentFrames == 0) {
                imageIndex++;
                ZGImageFrameModel *imgFrame = imagesArray[imageIndex];
                tmpKeepPresentFrames = imgFrame.keepPresentFrames;
            }
            
            if (imageIndex >= imagesArray.count) {
                imageIndex = (int)imagesArray.count -1;
            }
            NSLog(@"frame %zd",frameIndex);
            NSLog(@"idx==%d",imageIndex);
            CVPixelBufferRef buffer =NULL;
            
            ZGImageFrameModel *frame = [imagesArray objectAtIndex:imageIndex];
            UIImage *img = frame.img;
            buffer = (CVPixelBufferRef)[self pixelBufferFromCGImage:img.CGImage size:size];
            
            if (buffer)
            {
                if(![adaptor appendPixelBuffer:buffer withPresentationTime:CMTimeMake(frameIndex,fps)])//设置每秒钟播放图片的个数
                {
                    NSLog(@"FAIL");
                }
                else
                {
                    NSLog(@"OK");
                }
                
                CFRelease(buffer);
            }
            
            frameIndex++;
            tmpKeepPresentFrames--;
            
        } // end while
    }];
    
    return moviePath;
    
}

- (CVPixelBufferRef)pixelBufferFromCGImage:(CGImageRef)image size:(CGSize)size
{
    NSDictionary *options =[NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithBool:YES],kCVPixelBufferCGImageCompatibilityKey,
                            [NSNumber numberWithBool:YES],kCVPixelBufferCGBitmapContextCompatibilityKey,nil];
    CVPixelBufferRef pxbuffer =NULL;
    CVReturn status =CVPixelBufferCreate(kCFAllocatorDefault,size.width,size.height,kCVPixelFormatType_32ARGB,(__bridge CFDictionaryRef) options,&pxbuffer);
    
    NSParameterAssert(status ==kCVReturnSuccess && pxbuffer !=NULL);
    
    CVPixelBufferLockBaseAddress(pxbuffer,0);
    
    void *pxdata =CVPixelBufferGetBaseAddress(pxbuffer);
    NSParameterAssert(pxdata !=NULL);
    CGColorSpaceRef rgbColorSpace=CGColorSpaceCreateDeviceRGB();
    //    当你调用这个函数的时候，Quartz创建一个位图绘制环境，也就是位图上下文。当你向上下文中绘制信息时，Quartz把你要绘制的信息作为位图数据绘制到指定的内存块。一个新的位图上下文的像素格式由三个参数决定：每个组件的位数，颜色空间，alpha选项
    CGContextRef context =CGBitmapContextCreate(pxdata,size.width,size.height,8,4*size.width,rgbColorSpace,kCGImageAlphaPremultipliedFirst);
    NSParameterAssert(context);
    
    //使用CGContextDrawImage绘制图片  这里设置不正确的话 会导致视频颠倒
    //    当通过CGContextDrawImage绘制图片到一个context中时，如果传入的是UIImage的CGImageRef，因为UIKit和CG坐标系y轴相反，所以图片绘制将会上下颠倒
    CGContextDrawImage(context,CGRectMake(0,0,CGImageGetWidth(image),CGImageGetHeight(image)), image);
    // 释放色彩空间
    CGColorSpaceRelease(rgbColorSpace);
    // 释放context
    CGContextRelease(context);
    // 解锁pixel buffer
    CVPixelBufferUnlockBaseAddress(pxbuffer,0);
    
    return pxbuffer;
}

@end
