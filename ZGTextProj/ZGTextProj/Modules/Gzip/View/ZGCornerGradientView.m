//
//  ZGCornerGradientView.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2019/2/24.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGCornerGradientView.h"

@implementation ZGCornerGradientView

- (void)drawRect:(CGRect)rect {
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
   
    

    /* path*/
    
    //    CGContextSetRGBStrokeColor(context,1,0,0,1);
    UIColor *strokeColor = [UIColor redColor];
    if (self.borderColor) {
        strokeColor = self.borderColor;
    }
    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
    CGSize  rectSize = self.bounds.size;
    //    NSLog(@"rectSize.width %f, rectSize.height %f",rectSize.width,rectSize.height);
    
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
    
    
    
//    CGContextMoveToPoint(context,p_top_left.x,p_top_left.y);
//    // top_right corner
//    CGContextAddArcToPoint(context, p_top_right.x, p_top_right.y, p_right_top.x, p_right_top.y, self.cornerRadius_topRight);
//
//
//    // right line
//    //    CGContextAddLineToPoint(context, p_right_bottom.x, p_right_bottom.y);
//    // bottom_right corner
//    CGContextAddArcToPoint(context, p_right_bottom.x, p_right_bottom.y, p_bottom_right.x, p_bottom_right.y, self.cornerRadius_bottomRight);
//
//    // bottom line
//    //    CGContextAddLineToPoint(context, p_right_bottom.x, p_right_bottom.y);
//    // bottom_left corner
//    CGContextAddArcToPoint(context, p_bottom_left.x, p_bottom_left.y, p_left_bottom.x, p_left_bottom.y, self.cornerRadius_bottomLeft);
//
//    // left line
//    //    CGContextAddLineToPoint(context, p_right_bottom.x, p_right_bottom.y);
//    // top_left corner
//    CGContextAddArcToPoint(context, p_left_top.x, p_left_top.y, p_top_left.x, p_top_left.y, self.cornerRadius_topLeft);
    
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, p_top_left.x
                      , p_top_left.y);
    // top_right corner
    CGPathAddArcToPoint(path, NULL, p_top_right.x, p_top_right.y, p_right_top.x, p_right_top.y, self.cornerRadius_topRight);
    
    // right line
    //    CGContextAddLineToPoint(context, p_right_bottom.x, p_right_bottom.y);
    // bottom_right corner
    CGPathAddArcToPoint(path, NULL, p_right_bottom.x, p_right_bottom.y, p_bottom_right.x, p_bottom_right.y, self.cornerRadius_bottomRight);
    
    
    // bottom line
    //    CGContextAddLineToPoint(context, p_right_bottom.x, p_right_bottom.y);
    // bottom_left corner
    CGPathAddArcToPoint(path, NULL, p_bottom_left.x, p_bottom_left.y, p_left_bottom.x, p_left_bottom.y, self.cornerRadius_bottomLeft);
    
    // left line
    //    CGContextAddLineToPoint(context, p_right_bottom.x, p_right_bottom.y);
    // top_left corner
    CGPathAddArcToPoint(path, NULL, p_left_top.x, p_left_top.y, p_top_left.x, p_top_left.y, self.cornerRadius_topLeft);
    
    
    
    CGContextAddPath(context, path);
    
    UIColor *bgColor = [UIColor blackColor];
    CGContextSetFillColorWithColor(context, bgColor.CGColor);
    CGContextDrawPath(context, kCGPathEOFillStroke);
    
    CGContextClip(context);
    // 封闭矩形
//    CGContextClosePath(context);
    
    
    CGPathRelease(path);
    
    
    
    
    // gradient
////        CGContextRef context = UIGraphicsGetCurrentContext();
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGFloat locations[] = { 0.0, 1.0 };
//
//    NSArray *colors = @[(__bridge id) [UIColor redColor].CGColor, (__bridge id) [UIColor greenColor].CGColor];
//
//    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
//
//    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(100, 100), 0);
//
//    CGColorSpaceRelease(colorSpace);
//    CGGradientRelease(gradient);

    
    
    //        CGContextClip(context);
    //    CGContextStrokePath(context);
}
@end
