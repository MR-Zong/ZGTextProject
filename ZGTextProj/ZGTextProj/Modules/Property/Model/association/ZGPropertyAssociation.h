//
//  ZGPropertyAssociation.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2019/7/6.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 测试 property 与 实例变量的关联
@interface ZGPropertyAssociation : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, readonly) NSTimeInterval setupSeekTime;
@end


NS_ASSUME_NONNULL_END
