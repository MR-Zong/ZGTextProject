//
//  ZGDayModel.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/9/9.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import "ZGDayModel.h"
#import "ZGCalendarManager.h"
#import "ZGHolidayManager.h"

@implementation ZGDayModel

+ (instancetype)dayModelWithDay:(NSInteger)day month:(NSInteger)month year:(NSInteger)year monthType:(ZGDayModelMonthType)monthType
{
    ZGDayModel *dayModel = [[ZGDayModel alloc] init];
    dayModel.date = [self dateWithDay:day month:month year:year];
    dayModel.day = day;
    dayModel.monthType = monthType;
    dayModel.chineseDate = [[ZGCalendarManager shareCalendarManager] getChineseCalendarWithDate:dayModel.date];
    dayModel.isToday = [[ZGCalendarManager shareCalendarManager] isDateInToday:dayModel.date];
    dayModel.lunarHoliday = [[ZGHolidayManager shareHolidayManager] getLunarHoliDayWithDay:dayModel.chineseDate.dayI month:dayModel.chineseDate.monthI date:dayModel.date];
    dayModel.worldHoliday = [[ZGHolidayManager shareHolidayManager] getWorldHolidayWithDay:day month:month];
    dayModel.lunarSpecialDay = [[ZGHolidayManager shareHolidayManager] getLunarSpecialDayWithDay:(int)day month:(int)month year:(int)year];
    
    return dayModel;

}


+ (NSDate *)dateWithDay:(NSInteger)day month:(NSInteger)month year:(NSInteger)year
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = year;
    components.month = month;
    components.day = day;
    NSDate *date = [[[ZGCalendarManager shareCalendarManager] getCalendarWithCalendarIdentifier:NSCalendarIdentifierGregorian] dateFromComponents:components];
    return date;
}


@end
