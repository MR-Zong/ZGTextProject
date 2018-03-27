//
//  ZGHolidayManager.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/9/10.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZGHolidayManager : NSObject

+ (instancetype)shareHolidayManager;

- (NSString *)getLunarHoliDayWithDay:(NSInteger)day month:(NSInteger)month date:(NSDate *)date;
- (NSString *)getWorldHolidayWithDay:(NSInteger)day month:(NSInteger)month;
- (NSString *)getLunarSpecialDayWithDay:(int)iDay month:(int)iMonth year:(int)iYear;


@end
