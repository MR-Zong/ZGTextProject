//
//  ZGNFObserverB.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/2/1.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGNFObserverB.h"

@implementation ZGNFObserverB


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    if (self = [super init]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveZongNotification:) name:@"zongNotification" object:nil];
    }
    return self;
}

- (void)didReceiveZongNotification:(NSNotification *)note
{
//    NSLog(@"B准备进入 睡眠");
//    [NSThread sleepForTimeInterval:5.0];
//    NSLog(@"B 已经唤醒");
    NSLog(@"B t =  %@",[NSThread currentThread]);
}

@end
