//
//  ZGCornerView.m
//  ZGTextProj
//
//  Created by ali on 2019/2/25.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGCornerView.h"

@implementation ZGCornerView

- (void)cornerWithRect:(CGRect)rect
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
    [self cornerWithRect:self.bounds];
}
@end
