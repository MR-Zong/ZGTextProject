//
//  ZGWeakMutableDictionary.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/8/19.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZGWeakMutableDictionary : NSObject

+ (instancetype)dictionary;
- (void)setObject:(id)object forKey:(NSString *)key;
- (id)objectForKey:(NSString *)key;

@end
