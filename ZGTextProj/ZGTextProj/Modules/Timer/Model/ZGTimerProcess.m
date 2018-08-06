//
//  ZGBlockTimer.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/8/6.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGTimerProcess.h"

@interface ZGTimerProcess ()

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;

@end

@implementation ZGTimerProcess

+ (instancetype)timerProcessWithTarget:(id)target selector:(SEL)selector
{
    ZGTimerProcess *timerProcess = [[ZGTimerProcess alloc] init];
    timerProcess.target = target;
    timerProcess.selector = selector;
    return timerProcess;
}

- (void)ProcessTimer
{
    if (self.target && [self.target respondsToSelector:self.selector]) {
        [self.target performSelector:self.selector];
    }
}

@end
