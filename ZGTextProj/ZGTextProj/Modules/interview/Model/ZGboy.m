//
//  ZGboy.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/8/7.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import "ZGboy.h"

@implementation ZGboy

- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"%@", NSStringFromClass([self class]));
        NSLog(@"%@", NSStringFromClass([super class]));
    }
    return self;
}

@end
