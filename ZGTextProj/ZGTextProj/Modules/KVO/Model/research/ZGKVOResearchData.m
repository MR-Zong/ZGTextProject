//
//  ZGKVOResearchData.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/7/9.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGKVOResearchData.h"

@implementation ZGKVOResearchData

+ (NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key
{
    if ([key isEqualToString:@"name"]) {
        return [NSSet setWithObject:@"address"];
    }
    
//    NSSet *keyPathSet = [super keyPathsForValuesAffectingValueForKey:key];
//    for (NSString *keyPath in keyPathSet) {
//        NSLog(@"keyPath %@",keyPath);
//    }
    return [super keyPathsForValuesAffectingValueForKey:key];
}

@end
