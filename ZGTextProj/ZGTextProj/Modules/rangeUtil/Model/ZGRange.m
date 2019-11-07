//
//  ZGCacheItem.m
//  ZGTextProj
//
//  Created by XuZongGen on 2019/11/6.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGRange.h"

@implementation ZGRange

+ (instancetype)rangeWithStart:(int)start length:(int64_t)length
{
    ZGRange *range = [ZGRange new];
    range.start = start;
    range.length = length;
    return range;
}

+ (instancetype)rangeWithString:(NSString *)string
{
    ZGRange *range = [ZGRange new];
    NSArray *ary = [string componentsSeparatedByString:@","];
    range.start = [ary.firstObject intValue];
    range.length = [ary.lastObject intValue];
    return range;
}

- (int64_t)end
{
    return self.start + self.length;
}

- (NSString *)toString
{
    return [NSString stringWithFormat:@"%lld,%lld",self.start,self.length];
}

- (void)compareRange:(ZGRange *)range completeBlock:(void (^)(ZGRangeCompareType, int64_t))completeBlock
{
    ZGRangeCompareType type = ZGRangeCompareTypeNoOverlapLess;
    int64_t overlapLength = 0;
    
    // range 从左往右移
     if (range.end < self.start) {
         type = ZGRangeCompareTypeNoOverlapLess;
         overlapLength = 0;
         
     }else if (range.start < self.start && range.end >= self.start && range.end < self.end) {
         type = ZGRangeCompareTypeOverlapLeft;
         overlapLength = range.end - self.start;
         
     }else if (range.start == self.start && range.length == self.length) {
         type = ZGRangeCompareTypeEqual;
         overlapLength = range.length;
         
     }else if (range.start >= self.start && range.end <= self.end) {
         type = ZGRangeCompareTypeContain;
         overlapLength = range.length;
         
     }else if (range.start < self.start && range.end > self.end) {
         type = ZGRangeCompareTypeBeContain;
         overlapLength = self.length;
         
     }else if (range.start <= self.end && range.start > self.start && range.end > self.end ) {
         type = ZGRangeCompareTypeOverlapRight;
         overlapLength = self.end - range.start;
         
     }else if (range.start > self.end ) {
         type = ZGRangeCompareTypeNoOverlapGreater;
         overlapLength = 0;
     }
    
    
    if (completeBlock) {
        completeBlock(type, overlapLength);
    }
}

@end
