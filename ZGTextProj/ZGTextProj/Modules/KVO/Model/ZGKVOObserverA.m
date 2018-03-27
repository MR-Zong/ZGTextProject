//
//  ZGKVOObserverA.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/2/1.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGKVOObserverA.h"
#import "ZGKVODataModel.h"

@interface ZGKVOObserverA ()

@property (nonatomic, strong) ZGKVODataModel *dataModel;
@end

@implementation ZGKVOObserverA

- (void)dealloc
{
    [self.dataModel removeObserver:self forKeyPath:@"count"];
}

- (void)kvoObject:(ZGKVODataModel *)dataModel
{
    [dataModel addObserver:self forKeyPath:@"count" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"A准备进入 睡眠");
    [NSThread sleepForTimeInterval:5.0];
    NSLog(@"A 已经唤醒");
    NSLog(@"A t =  %@",[NSThread currentThread]);
    
    NSLog(@"AAA old value: %@   new value: %@\n",change[NSKeyValueChangeOldKey],change[NSKeyValueChangeNewKey]);
}

@end
