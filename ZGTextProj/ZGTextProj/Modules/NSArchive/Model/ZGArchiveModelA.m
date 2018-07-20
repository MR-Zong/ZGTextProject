//
//  ZGArchiveModelA.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/7/20.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGArchiveModelA.h"

@implementation ZGArchiveModelA

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _name = [aDecoder decodeObjectForKey:@"ddd"];
        _age = [aDecoder decodeIntegerForKey:@"age"];
        _sex = [aDecoder decodeObjectForKey:@"sex"];
        _isMan = [aDecoder decodeBoolForKey:@"isMan"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_name forKey:@"ddd"];
    [aCoder encodeInteger:_age forKey:@"age"];
    [aCoder encodeObject:_sex forKey:@"sex"];
    [aCoder encodeBool:_isMan forKey:@"isMan"];
}

@end
