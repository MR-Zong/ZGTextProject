//
//  ZGPSHIModelA.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/8/11.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZGPSHIModelA : NSObject

+ (instancetype)shareInstance;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
//@property (assign) id name;
@property id name;

@end