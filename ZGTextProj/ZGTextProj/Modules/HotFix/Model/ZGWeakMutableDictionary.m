//
//  ZGWeakMutableDictionary.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/8/19.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGWeakMutableDictionary.h"

@interface ZGWeakMutableDictionary ()

@property (nonatomic, strong) NSMapTable *weakDictionary;

@end

@implementation ZGWeakMutableDictionary

+ (instancetype)dictionary
{
    ZGWeakMutableDictionary *weakDic = [[ZGWeakMutableDictionary alloc] init];
    return weakDic;
}


- (instancetype)init
{
    if (self = [super init]) {
        _weakDictionary = [NSMapTable strongToWeakObjectsMapTable];
    }
    return self;
}

- (void)setObject:(id)object forKey:(NSString *)key
{
    if (object == nil || key == nil)
    {
        NSLog(@"object & key should not be nil.");
        return;
    }
    
    if ([self.weakDictionary objectForKey:key] == nil)
    {
        [self.weakDictionary setObject:object forKey:key];
    }
}

- (id)objectForKey:(NSString *)key
{
    return [self.weakDictionary objectForKey:key];
}


@end
