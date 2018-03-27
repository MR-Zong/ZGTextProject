//
//  ZGKEObserverA.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/2/2.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGKEObserverA.h"
#import "ZGKEDataModel.h"

@interface ZGKEObserverA ()

@property (nonatomic, strong) ZGKEDataModel *dataModel;
@end

@implementation ZGKEObserverA

- (void)dealloc
{
    [self.dataModel removeObserver:self forKeyPath:@"count"];
}

- (void)kvoTarget:(ZGKEDataModel *)dataModel
{
    self.dataModel = dataModel;
    [dataModel addObserver:self forKeyPath:@"count" options:NSKeyValueObservingOptionNew context:nil];;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"AAA old value: %@   new value: %@\n",change[NSKeyValueChangeOldKey],change[NSKeyValueChangeNewKey]);
}

@end
