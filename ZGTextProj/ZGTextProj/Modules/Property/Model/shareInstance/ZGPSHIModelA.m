//
//  ZGPSHIModelA.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/8/11.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGPSHIModelA.h"

@interface ZGPSHIModelA ()
- (instancetype)init;
@end

@implementation ZGPSHIModelA

+ (instancetype)shareInstance
{
    static ZGPSHIModelA *_pSHIModelAShareInstance_;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _pSHIModelAShareInstance_ = [[ZGPSHIModelA alloc] initPrivate];
    });
    return _pSHIModelAShareInstance_;
}

- (instancetype)initPrivate
{
    if (self = [super init]) {
        ;
    }
    return self;
}

@end
