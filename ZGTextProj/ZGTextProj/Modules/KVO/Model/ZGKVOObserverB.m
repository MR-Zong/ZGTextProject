//
//  ZGKVOObserverB.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/2/1.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGKVOObserverB.h"
#import "ZGKVODataModel.h"

@interface ZGKVOObserverB ()

@property (nonatomic, strong) ZGKVODataModel *dataModel;
@end

@implementation ZGKVOObserverB

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
     NSLog(@"BBB t =  %@",[NSThread currentThread]);
    NSLog(@"BBB old value: %@   new value: %@\n",change[NSKeyValueChangeOldKey],change[NSKeyValueChangeNewKey]);
}

@end
