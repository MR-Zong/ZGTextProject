//
//  ZGPropertyAssociation.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2019/7/6.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGPropertyAssociation.h"

@implementation ZGPropertyAssociation
{
    NSString *_name;
    double _setupSeekTime;
}

- (instancetype)init
{
    if (self = [super init]) {
        _name = @"zong";
        _setupSeekTime = 8.8;
    }
    return self;
}
@end

