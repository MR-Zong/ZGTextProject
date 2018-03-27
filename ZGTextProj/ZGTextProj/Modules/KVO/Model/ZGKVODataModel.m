//
//  ZGKVODataModel.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/2/1.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGKVODataModel.h"

@interface ZGKVODataModel ()

@property (nonatomic, assign) NSInteger count;

@end

@implementation ZGKVODataModel

- (instancetype)init
{
    if (self = [super init]) {
        _count = 1;
    }
    return self;
}

- (void)changeValue
{
    // 直接访问实例变量 不会触发KVO
//    _count = 3;
    
    // 通过set 方法 就可以触发KVO
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        NSLog(@"changeValue t =  %@",[NSThread currentThread]);
        self.count = 2;

    });
}

#pragma mark - 重写KVO set方法
// 重写set 方法对KVO 没有影响
- (void)setCount:(NSInteger)count
{
    _count = count;
}

@end
