//
//  ZGCategoryObject.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/12/28.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import "ZGCategoryObject.h"

@implementation ZGCategoryObject

+ (void)initialize
{
    NSLog(@"ZGCategoryObject initialize");
}

- (void)log
{
    NSLog(@"ZGCategoryObject 本类方法");
}

- (void)eat
{
    NSLog(@"ZGCategoryObject eat");
}

@end
