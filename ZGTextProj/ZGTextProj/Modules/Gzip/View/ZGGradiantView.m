//
//  ZGGradiantView.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2019/2/24.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGGradiantView.h"

@implementation ZGGradiantView

- (void)maskWithRect:(CGRect)rect
{
    // path
    CGSize  rectSize = rect.size;
    
    // 确定8个点，每条边有两个点 从左上点，顺时针
    CGPoint p_top_left = CGPointMake(self.cornerRadius_topLeft, 0);
    // 由于CGContextAddArcToPoint特性，这里必须是刚好右上角的点
    CGPoint p_top_right = CGPointMake(rectSize.width, 0);
    
    CGPoint p_right_top = CGPointMake(rectSize.width, self.cornerRadius_topRight);
    // 由于CGContextAddArcToPoint特性，这里必须是刚好右下角的点
    CGPoint p_right_bottom = CGPointMake(rectSize.width, rectSize.height);
    
    CGPoint p_bottom_right = CGPointMake(rectSize.width - self.cornerRadius_bottomRight, rectSize.height);
    // 由于CGContextAddArcToPoint特性，这里必须是刚好左下角的点
    CGPoint p_bottom_left = CGPointMake(0, rectSize.height);
    
    CGPoint p_left_bottom = CGPointMake(0, rectSize.height - self.cornerRadius_bottomLeft);
    // 由于CGContextAddArcToPoint特性，这里必须是刚好左上角的点
    CGPoint p_left_top = CGPointMake(0, 0);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, p_top_left.x
                      , p_top_left.y);
    CGPathAddArcToPoint(path, NULL, p_top_right.x, p_top_right.y, p_right_top.x, p_right_top.y, self.cornerRadius_topRight);
    CGPathAddArcToPoint(path, NULL, p_right_bottom.x, p_right_bottom.y, p_bottom_right.x, p_bottom_right.y, self.cornerRadius_bottomRight);
    CGPathAddArcToPoint(path, NULL, p_bottom_left.x, p_bottom_left.y, p_left_bottom.x, p_left_bottom.y, self.cornerRadius_bottomLeft);
    CGPathAddArcToPoint(path, NULL, p_left_top.x, p_left_top.y, p_top_left.x, p_top_left.y, self.cornerRadius_topLeft);
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    [shapeLayer setPath:path];
    self.layer.mask = shapeLayer;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self maskWithRect:self.bounds];
}


- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };

    NSArray *colors = @[(__bridge id) [UIColor redColor].CGColor, (__bridge id) [UIColor greenColor].CGColor];

    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);

    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(100, 100), 0);

    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
    
    
    // 2
    
    // 创建Quartz上下文
//    CGContextRef context = UIGraphicsGetCurrentContext();
//
//    // 创建色彩空间对象
//    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
//
//    // 创建起点颜色
//    CGColorRef beginColor = CGColorCreate(colorSpaceRef, (CGFloat[]){0.01f, 0.99f, 0.01f, 1.0f});
//
//    // 创建终点颜色
//    CGColorRef endColor = CGColorCreate(colorSpaceRef, (CGFloat[]){0.99f, 0.99f, 0.01f, 1.0f});
//
//    // 创建颜色数组
//    CFArrayRef colorArray = CFArrayCreate(kCFAllocatorDefault, (const void*[]){beginColor, endColor}, 2, nil);
//
//    // 创建渐变对象
//    CGGradientRef gradientRef = CGGradientCreateWithColors(colorSpaceRef, colorArray, (CGFloat[]){
//        0.0f,       // 对应起点颜色位置
//        1.0f        // 对应终点颜色位置
//    });
//
//    // 释放颜色数组
//    CFRelease(colorArray);
//
//    // 释放起点和终点颜色
//    CGColorRelease(beginColor);
//    CGColorRelease(endColor);
//
//    // 释放色彩空间
//    CGColorSpaceRelease(colorSpaceRef);
//
//    CGContextDrawLinearGradient(context, gradientRef, CGPointMake(0.0f, 0.0f), CGPointMake(100.0f, 100.0f), 0);
//
//    // 释放渐变对象
//    CGGradientRelease(gradientRef);
}


@end
