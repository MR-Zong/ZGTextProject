//
//  ZGKVOCBaseOberver.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/7/10.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGKVOCBaseOberver.h"

void *ZGKVOCBaseOberverContext = &ZGKVOCBaseOberverContext;

@implementation ZGKVOCBaseOberver

- (void)dealloc
{
    // 移除监听
    if ([self isMemberOfClass:[ZGKVOCBaseOberver class]]) {
        [self.target removeObserver:self forKeyPath:@"name"];
    }
}


- (instancetype)initWithTarget:(ZGKVOCDataModel *)target
{
    if (self = [super init])
    {
        _target = target;
        
        //注册监听器
        if ([self isMemberOfClass:[ZGKVOCBaseOberver class]]) {
            
            [_target addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:ZGKVOCBaseOberverContext];
        }
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"Base");
    NSLog(@"baseContext %p",ZGKVOCBaseOberverContext);
    NSLog(@"baseContext value %lx",*(NSUInteger *)ZGKVOCBaseOberverContext);
    if (context == ZGKVOCBaseOberverContext) {
        NSLog(@"process Base");
    }
}

- (void)changName
{
    self.target.name = @"base";
}

@end
