//
//  UIView+ZGExtension.m
//  Sleep
//
//  Created by 徐宗根 on 2018/6/14.
//  Copyright © 2018年 Kugou. All rights reserved.
//

#import "UIView+ZGExtension.h"

@implementation UIView (ZGExtension)

- (void)roundingCorners:(UIRectCorner)roundingCorner cornerSize:(CGSize)cornerSize
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:roundingCorner cornerRadii:cornerSize];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

@end
