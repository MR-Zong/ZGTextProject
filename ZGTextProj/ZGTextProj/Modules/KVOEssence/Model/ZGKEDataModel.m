//
//  ZGKEDataModel.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/2/2.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGKEDataModel.h"

@interface ZGKEDataModel ()

@property (nonatomic, assign) NSInteger count;

@end

@implementation ZGKEDataModel

- (void)changeValue
{
    self.count = 2;
}

@end
