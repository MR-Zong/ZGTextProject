//
//  ZGAuthorizationHelper.h
//  Vaka
//
//  Created by ali on 2018/11/9.
//  Copyright © 2018 com.alibaba-inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZGAuthorizationHelper : NSObject

/**
 * 验证相机权限
 */
+ (void)cameraAuthorizationWithController:(UIViewController *)viewController;


/**
 * 验证麦克风权限
 */
+ (void)microPhoneAuthorizationWithController:(UIViewController *)viewController;


/**
 * 验证相册权限
 */
+ (void)albumAuthorizationWithController:(UIViewController *)viewController;

/**
 * 验证相机，麦克风 ，相册权限
 */
+ (void)camera_microPhone_albumAuthorizationWithController:(UIViewController *)viewController discardBlock:(void(^)(void))discardBlock;

@end

NS_ASSUME_NONNULL_END
