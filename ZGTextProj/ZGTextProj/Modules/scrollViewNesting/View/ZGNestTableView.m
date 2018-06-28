//
//  ZGNestTableView.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/6/27.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGNestTableView.h"

@implementation ZGNestTableView

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"gestureRecognizer %@",gestureRecognizer);
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
    NSLog(@"nestTable touchesBegan");
    [super touchesBegan:touches withEvent:event];
}


@end
