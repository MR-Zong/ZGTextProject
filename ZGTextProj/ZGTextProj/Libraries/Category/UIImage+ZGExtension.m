//
//  UIImage+ZGExtension.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/6/16.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "UIImage+ZGExtension.h"

@implementation UIImage (ZGExtension)

+ (instancetype)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color rect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius
{
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    
    CGContextClearRect(context,rect);
    
    // 透明圆
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    UIBezierPath *clipPath = [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius] bezierPathByReversingPath];
    [path appendPath:clipPath];
    
    CGContextAddPath(context, path.CGPath);
    CGContextFillPath(context);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
