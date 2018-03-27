//
//  ZGNFObserverA.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/2/1.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGNFObserverA.h"

@implementation ZGNFObserverA

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
    NSLog(@"A准备进入 睡眠");
    [NSThread sleepForTimeInterval:5.0];
    NSLog(@"A 已经唤醒");
    NSLog(@"A t =  %@",[NSThread currentThread]);
}

@end
