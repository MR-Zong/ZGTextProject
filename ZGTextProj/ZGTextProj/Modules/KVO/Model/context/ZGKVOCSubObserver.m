//
//  ZGKVOCSubObserver.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/7/10.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGKVOCSubObserver.h"

@implementation ZGKVOCSubObserver

- (void)dealloc
{
    [self.target removeObserver:self forKeyPath:@"name"];
}

- (instancetype)initWithTarget:(ZGKVOCDataModel *)target;
{
    if (self = [super initWithTarget:target])
    {
        //注册监听器
        [self.target addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:ZGKVOCSubObserverContext];
    }
    return self;
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"Sub");
    if (context == ZGKVOCSubObserverContext) {
        NSLog(@"process Sub");
    }
}

- (void)changName
{
    self.target.name = @"sub";
}

@end
