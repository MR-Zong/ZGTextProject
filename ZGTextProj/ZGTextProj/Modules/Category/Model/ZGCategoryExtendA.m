//
//  ZGCategoryExtendA.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/7/22.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGCategoryExtendA.h"

@interface ZGCategoryExtendA ()

@property (nonatomic, assign) NSInteger age;

@end


@implementation ZGCategoryExtendA

- (instancetype)init
{
    if (self = [super init]) {
        _age = 10;
    }
    
    return self;
}

- (void)print
{
    NSLog(@"age %zd",self.age);
}
@end
