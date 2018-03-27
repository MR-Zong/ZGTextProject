//
//  ZGBlockPeople.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/1/3.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGBlockPeople.h"

@interface ZGBlockPeople ()
{
    void (^_sayBlock)(NSString *);
}


@end

@implementation ZGBlockPeople

- (void)setupSayBlock:(void (^)(NSString *))sayBlock
{
    _sayBlock = sayBlock;
}

- (void)say
{
    if (_sayBlock) {
        _sayBlock(@"block  循环引用 问题解决 测试");
        _sayBlock = nil;
    }
}

@end
