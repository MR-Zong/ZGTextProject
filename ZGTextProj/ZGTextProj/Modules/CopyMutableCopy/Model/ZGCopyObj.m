//
//  ZGCopyObj.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/8/25.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import "ZGCopyObj.h"

@implementation ZGCopySubObj

@end


@implementation ZGCopyObj


- (id)copyWithZone:(NSZone *)zone
{
//    ZGCopyObj *obj = [[ZGCopyObj alloc] init];
//    obj.subObj = self.subObj;
//    obj.name = self.name;
    
    ZGCopyObj *obj = [[ZGCopyObj allocWithZone:zone] init];
    return obj;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    NSLog(@"mutableCopy");
    return nil;
}

@end
