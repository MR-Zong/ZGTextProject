//
//  ZGPEteModelA.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/8/11.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGPEteModelA.h"

@interface ZGPEteModelA ()

@property (nonatomic, strong) NSString *name;

@end

/**
 * 证明 在类定义.m 模块，匿名分类 可以多个
 * 但要在类实现之前，否则编译器报错
 */
@interface ZGPEteModelA ()

@property (nonatomic, strong) NSString *phone;

@end

@implementation ZGPEteModelA

- (instancetype)init
{
    if (self = [super init]) {
        _name = @"zong";
        _phone = @"159";
    }
    return self;
}

- (void)print
{
    NSLog(@"name %@, phone %@",self.name,self.phone);
}

@end


