//
//  ZGBrightManger.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/1/6.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGBrightManger.h"

#import <AVFoundation/AVFoundation.h>
#import <ImageIO/ImageIO.h>

@interface ZGBrightManger ()< AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic,copy) void (^completeBlock)(float brightness);

@end

@implementation ZGBrightManger

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    static ZGBrightManger *_brightM_;
    dispatch_once(&onceToken, ^{
        _brightM_ = [[ZGBrightManger alloc] init];
    });
    
    return _brightM_;
}

- (void)getBrightnessWithCompleteBlock:(void (^)(float))completeBlock
{
    self.completeBlock = completeBlock;
    
    [self lightSensitive];
}
#pragma mark- 光感
- (void)lightSensitive {
    
    // 1.获取硬件设备
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
//    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDevice *device = nil;
    
    // 获取前置摄像头
    for (AVCaptureDevice *dev in devices) {
        if (dev.position == AVCaptureDevicePositionFront) {
            device = dev;
        }
    }

    
    // 2.创建输入流
    AVCaptureDeviceInput *input = [[AVCaptureDeviceInput alloc]initWithDevice:device error:nil];
    
    //根据设备输出获得连接
//    AVCaptureConnection *connection = [input connectionWithMediaType:AVMediaTypeVideo];
    
    
//    // 前置摄像头翻转
//    AVCaptureDevicePosition currentPosition = [[input device] position];
//    if (currentPosition == AVCaptureDevicePositionUnspecified || currentPosition == AVCaptureDevicePositionFront) {
//        connection.videoMirrored = YES;
//    } else {
//        connection.videoMirrored = NO;
//    }
    
    // 3.创建设备输出流
    AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init];
    [output setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
    
    
    // AVCaptureSession属性
    self.session = [[AVCaptureSession alloc]init];
    // 设置为高质量采集率
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    // 添加会话输入和输出
    if ([self.session canAddInput:input]) {
        [self.session addInput:input];
    }
    if ([self.session canAddOutput:output]) {
        [self.session addOutput:output];
    }
    
    // 9.启动会话
    [self.session startRunning];
    
}

#pragma mark- AVCaptureVideoDataOutputSampleBufferDelegate的方法
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    
    // 切记关掉，否则一直在拍摄中
//    [self.session stopRunning];
    
    CFDictionaryRef metadataDict = CMCopyDictionaryOfAttachments(NULL,sampleBuffer, kCMAttachmentMode_ShouldPropagate);
    NSDictionary *metadata = [[NSMutableDictionary alloc] initWithDictionary:(__bridge NSDictionary*)metadataDict];
    CFRelease(metadataDict);
    NSDictionary *exifMetadata = [[metadata objectForKey:(NSString *)kCGImagePropertyExifDictionary] mutableCopy];
    float brightnessValue = [[exifMetadata objectForKey:(NSString *)kCGImagePropertyExifBrightnessValue] floatValue];
    
    NSLog(@"%f",brightnessValue);

    
    if (self.completeBlock) {
        self.completeBlock(brightnessValue);
        self.completeBlock = nil;
    }
   
    // 根据brightnessValue的值来打开和关闭闪光灯
//    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//    BOOL result = [device hasTorch];// 判断设备是否有闪光灯
//    if ((brightnessValue < 0) && result) {// 打    开闪光灯
//
//        [device lockForConfiguration:nil];
//
//        [device setTorchMode: AVCaptureTorchModeOn];//开
//
//        [device unlockForConfiguration];
//
//    }else if((brightnessValue > 0) && result) {// 关闭闪光灯
//
//        [device lockForConfiguration:nil];
//        [device setTorchMode: AVCaptureTorchModeOff];//关
//        [device unlockForConfiguration];
//
//    }
    
}

@end
