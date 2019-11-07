//
//  ZGCacheItem.h
//  ZGTextProj
//
//  Created by XuZongGen on 2019/11/6.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,ZGRangeCompareType) {
    ZGRangeCompareTypeNoOverlapLess, // 不重叠，而且比自己更小
    ZGRangeCompareTypeOverlapLeft, // 和自己左部有重叠
    ZGRangeCompareTypeEqual, // 相等
    ZGRangeCompareTypeContain, // 自己包含它
    ZGRangeCompareTypeBeContain, // 它包含自己（被包含）
    ZGRangeCompareTypeOverlapRight, // 和自己右部有重叠
    ZGRangeCompareTypeNoOverlapGreater, // 不重叠,而且比自己更大
};


@interface ZGRange : NSObject

+ (instancetype)rangeWithStart:(int)start length:(int64_t)length;
+ (instancetype)rangeWithString:(NSString *)string;
@property (nonatomic, assign) int64_t start;
@property (nonatomic, assign) int64_t length;
- (int64_t)end;
- (NSString *)toString;

- (void)compareRange:(ZGRange *)range completeBlock:(void (^)(ZGRangeCompareType type,int64_t overlapLength))completeBlock;

@end

NS_ASSUME_NONNULL_END
