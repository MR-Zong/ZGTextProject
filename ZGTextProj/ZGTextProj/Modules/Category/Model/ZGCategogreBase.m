//
//  ZGCategogreBase.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2020/5/31.
//  Copyright © 2020 XuZonggen. All rights reserved.
//

#import "ZGCategogreBase.h"

@implementation ZGCategogreBase

+ (void)initialize
{
    NSLog(@"ZGCategogreBase initialize");
}

- (instancetype)init
{
    NSLog(@"ZGCategogreBase init");
    return [super init];
}

- (void)eat
{
    NSLog(@"ZGCategogreBase eat");
}

@end
