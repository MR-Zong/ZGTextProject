//
//  ZGKVOCBaseOberver.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/7/10.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZGKVOCDataModel.h"

FOUNDATION_EXTERN void *ZGKVOCBaseOberverContext;

@interface ZGKVOCBaseOberver : NSObject

@property (nonatomic, weak) ZGKVOCDataModel *target;

- (instancetype)initWithTarget:(ZGKVOCDataModel *)target;

- (void)changName;

@end
