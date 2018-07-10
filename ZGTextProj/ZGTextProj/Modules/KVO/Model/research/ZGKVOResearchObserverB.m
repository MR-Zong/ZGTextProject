//
//  ZGKVOResearchObserverB.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/7/9.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGKVOResearchObserverB.h"

@implementation ZGKVOResearchObserverB

- (void)dealloc
{
    [self.target removeObserver:self forKeyPath:@"name"];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"rsB");
}

@end
