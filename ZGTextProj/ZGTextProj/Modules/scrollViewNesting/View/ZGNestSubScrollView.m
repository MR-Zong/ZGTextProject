//
//  ZGNestSubScrollView.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/6/26.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGNestSubScrollView.h"

@implementation ZGNestSubScrollView

///允许同时识别多个手势
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    NSLog(@"ffffTable gggggg ");
//    return YES;
//}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"sholdBegin %@",gestureRecognizer);
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint v = [pan velocityInView:pan.view];
        NSLog(@"v.x %f",v.x);
        if (v.x > 0) {
            ;
        }
    }
    
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan");
}


@end
