//
//  ZGProxy.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/3/29.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZGProxy : NSProxy

+ (instancetype)proxyWithTarget:(id)target;

@end
