//
//  ZGBrightManger.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/1/6.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZGBrightManger : NSObject

+ (instancetype)shareInstance;

- (void)getBrightnessWithCompleteBlock:(void(^)(float brightness))completeBlock;

@end
