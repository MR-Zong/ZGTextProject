//
//  ZGWeakSelfManager.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/1/18.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGWeakSelfManager.h"

@interface ZGWeakSelfManager ()


@end


@implementation ZGWeakSelfManager

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    static ZGWeakSelfManager *_weakSelfM_;
    dispatch_once(&onceToken, ^{
        _weakSelfM_ = [[ZGWeakSelfManager alloc] init];
        [_weakSelfM_ doSomeThing];
    });
    return _weakSelfM_;
}


- (void)doSomeThing
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"name == %@",self.name);
    });
}


@end
