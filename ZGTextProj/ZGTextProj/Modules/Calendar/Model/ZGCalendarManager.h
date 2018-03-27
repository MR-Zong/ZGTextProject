//
//  ZGCalendarManager.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/9/8.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZGChineseDate;

@interface ZGCalendarManager : NSObject

+ (instancetype)shareCalendarManager;

- (NSCalendar *)getCalendarWithCalendarIdentifier:(NSCalendarIdentifier)calendarIdentifier;

- (BOOL)isDateInToday:(NSDate *)date;
- (NSMutableArray *)daysArrayWithDate:(NSDate *)date;
- (ZGChineseDate *)getChineseCalendarWithDate:(NSDate *)date;

@end
