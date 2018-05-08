//
//  ZGIFUBaseObject.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/4/26.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGIFUBaseObject.h"

@implementation ZGIFUBaseObject

- (instancetype)init
{
    if (self = [super init]) {
        
        NSLog(@"%@",self);
        
        _age = 10;
//        self.age = 10;
    }
    return self;
}

@end
