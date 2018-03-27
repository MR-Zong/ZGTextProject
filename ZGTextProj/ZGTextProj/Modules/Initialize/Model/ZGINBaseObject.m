//
//  ZGINBaseObject.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/3/13.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGINBaseObject.h"

@implementation ZGINBaseObject

+ (void)initialize
{
    NSLog(@"父类");
}

- (void)eat
{
    NSLog(@"ZGINBaseObject -- eat");
}
@end
