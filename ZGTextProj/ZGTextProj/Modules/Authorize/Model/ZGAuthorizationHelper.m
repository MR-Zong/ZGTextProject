//
//  ZGAuthorizationHelper.m
//  Vaka
//
//  Created by ali on 2018/11/9.
//  Copyright © 2018 com.alibaba-inc. All rights reserved.
//

#import "ZGAuthorizationHelper.h"
#import <AVFoundation/AVFoundation.h>
#import <PhotosUI/PhotosUI.h>

@implementation ZGAuthorizationHelper

+ (void)cameraAuthorizationWithController:(UIViewController *)viewController
{
    
    void(^noAuthorizationBlock)(void) = ^(void){
        NSString *aleartMsg = @"请在\"设置 - 隐私 - 相机\"选项中，允许多客访问您的相机";
        
        UIAlertController *av = [UIAlertController alertControllerWithTitle:nil message:aleartMsg preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *aac = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication]canOpenURL:url]) {
                
                [[UIApplication sharedApplication]openURL:url];
            }
        }];
        [av addAction:aac];
        [viewController presentViewController:av animated:YES completion:nil];
    };
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        noAuthorizationBlock();
    }else {
        
        //获取访问相机权限时，弹窗的点击事件获取
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                NSLog(@"允许了");
            } else {
                NSLog(@"被拒绝了");
                noAuthorizationBlock();
            }
        }];
    }
    
}


+ (void)microPhoneAuthorizationWithController:(UIViewController *)viewController
{
    void(^noAuthorizationBlock)(void) = ^(void){
        NSString *aleartMsg = @"请在\"设置 - 隐私 - 麦克风\"选项中，允许多客访问您的麦克风";
        
        UIAlertController *av = [UIAlertController alertControllerWithTitle:nil message:aleartMsg preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *aac = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication]canOpenURL:url]) {
                
                [[UIApplication sharedApplication]openURL:url];
            }
        }];
        [av addAction:aac];
        [viewController presentViewController:av animated:YES completion:nil];
    };
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        noAuthorizationBlock();
    }else {
        
        //获取访问相机权限时，弹窗的点击事件获取
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
            if (granted) {
                NSLog(@"允许了");
            } else {
                NSLog(@"被拒绝了");
                noAuthorizationBlock();
            }
        }];
    }
    
}


+ (void)albumAuthorizationWithController:(UIViewController *)viewController
{
    void(^noAuthorizationBlock)(void) = ^(void){
        NSString *aleartMsg = @"请在\"设置 - 隐私 - 相册\"选项中，允许多客访问您的相册";
        
        UIAlertController *av = [UIAlertController alertControllerWithTitle:nil message:aleartMsg preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *aac = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication]canOpenURL:url]) {
                
                [[UIApplication sharedApplication]openURL:url];
            }
        }];
        [av addAction:aac];
        [viewController presentViewController:av animated:YES completion:nil];
    };
    
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    if(authStatus == PHAuthorizationStatusRestricted || authStatus == PHAuthorizationStatusDenied){
        noAuthorizationBlock();
    }else {
        
        //获取访问相机权限时，弹窗的点击事件获取
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
             noAuthorizationBlock();
        }];
    }
    
}

+ (void)camera_microPhone_albumAuthorizationWithController:(UIViewController *)viewController discardBlock:(nonnull void (^)(void))discardBlock
{
    
    __block BOOL cameraAuth = NO;
    __block BOOL microPhoneAuth = NO;
    __block BOOL PhotoAuth = NO;

    __block BOOL cameraComplete = NO;
    __block BOOL microPhoneComplete = NO;
    __block BOOL PhotoComplete = NO;

    void(^noAuthorizationBlock)(NSString *deviceAuthorization) = ^(NSString *deviceAuthorization){
        NSString *aleartMsg = [NSString stringWithFormat:@"请在\"设置 - 隐私 - %@\"选项中，允许多客访问您的%@",deviceAuthorization,deviceAuthorization];
        
        UIAlertController *av = [UIAlertController alertControllerWithTitle:nil message:aleartMsg preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *aac = [UIAlertAction actionWithTitle:@"Setting" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication]canOpenURL:url]) {
                
                [[UIApplication sharedApplication]openURL:url];
            }
        }];
        
        UIAlertAction *aac_discard = [UIAlertAction actionWithTitle:@"Discard" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (discardBlock) {
                discardBlock();
            }
        }];
        [av addAction:aac_discard];
        [av addAction:aac];
        [viewController presentViewController:av animated:YES completion:nil];
    };
    
    void(^completetBlock)(void) = ^(void){
        NSLog(@"cameraComplete %zd. microPhoneComplete %zd. PhotoComplete %zd. ",cameraComplete,microPhoneComplete,PhotoComplete);
        if (cameraComplete && microPhoneComplete && PhotoComplete) {
            
            if (!cameraAuth) {
                noAuthorizationBlock(@"相机");
            }else if (!microPhoneAuth) {
                noAuthorizationBlock(@"麦克风");
            }else if (!PhotoAuth) {
                noAuthorizationBlock(@"相册");
            }
        }
    };
    
    // 相机
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        cameraAuth = NO;
        cameraComplete = YES;
    }else {
        
        //获取访问相机权限时，弹窗的点击事件获取
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                NSLog(@"允许了");
                cameraAuth = YES;
            } else {
                NSLog(@"被拒绝了");
                cameraAuth = NO;
            }
            
            cameraComplete = YES;
            completetBlock();
        }];
    }
    
    
    // 麦克风
    AVAuthorizationStatus microPhone_authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    
    if(microPhone_authStatus == AVAuthorizationStatusRestricted || microPhone_authStatus == AVAuthorizationStatusDenied){
        microPhoneAuth = NO;
        microPhoneComplete = YES;
    }else {
        
        //获取访问相机权限时，弹窗的点击事件获取
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
            if (granted) {
                NSLog(@"允许了");
                microPhoneAuth = YES;
            } else {
                NSLog(@"被拒绝了");
                microPhoneAuth = NO;
            }
            microPhoneComplete = YES;
            completetBlock();
        }];
    }
    
    // 相册
    PHAuthorizationStatus photo_authStatus = [PHPhotoLibrary authorizationStatus];
    if(photo_authStatus == PHAuthorizationStatusRestricted || photo_authStatus == PHAuthorizationStatusDenied){
        PhotoAuth = NO;
         PhotoComplete = YES;
    }else {
        
        //获取访问相机权限时，弹窗的点击事件获取
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized ) {
                PhotoAuth = YES;
            }else if(status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
                PhotoAuth = NO;
            }
            PhotoComplete = YES;
            completetBlock();
        }];
    }
    
    completetBlock();
    
    
}

@end
