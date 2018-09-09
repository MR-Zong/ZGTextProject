//
//  UIImage+ZGExtension.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/6/16.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZGExtension)

/**
 * 用颜色生成图片
 */
+ (instancetype)imageWithColor:(UIColor *)color;

/**
 * 获取 中间透明的图
 */
+ (UIImage *)imageUsePathWithColor:(UIColor *)color rect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius;
+ (UIImage *)imageWithColor:(UIColor *)color rect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius;


@end
