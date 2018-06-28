//
//  ZGCellOpCell.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/6/28.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGCellOpCell.h"

@implementation ZGCellOpCell

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer{
    
    
    
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        
        CGPoint velocityPoint = [gestureRecognizer velocityInView:self];
        
        if (fabsf(velocityPoint.x) > 100) {
            
            return YES;
            
        }else
            
            return NO;
        
    }else
        
        return NO;
    
}

@end
