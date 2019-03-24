//
//  ZGPCopyModel.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2019/3/24.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGPCopyModel.h"

@implementation ZGPCopyModelPy

- (id)copyWithZone:(NSZone *)zone
{
    ZGPCopyModelPy *model = [[[self class] allocWithZone:zone] init];
    model.name = self.name;
    //未公开的成员
//    model->_nickName = _nickName;
    return model;
}

@end

@implementation ZGPCopyModel

@end
