//
//  ZGBlockPeople.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/1/3.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZGBlockPeople : NSObject

- (void)setupSayBlock:(void(^)(NSString *str))sayBlock;
- (void)say;

@end
