//
//  ZGKVOOObserverB.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/7/10.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGKVOOObserverB.h"

@implementation ZGKVOOObserverB

- (void)dealloc
{
    [self.target removeObserver:self forKeyPath:@"name"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"oB");
}

@end
