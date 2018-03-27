//
//  ZGMonthModel.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/9/9.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZGMonthModel : NSObject

+ (instancetype)monthModelWithYear:(NSInteger)year month:(NSInteger)month date:(NSDate *)date;

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;

/**
 * 缓存计算结果
 */
@property (nonatomic, strong) NSMutableArray *daysArray;

@end
