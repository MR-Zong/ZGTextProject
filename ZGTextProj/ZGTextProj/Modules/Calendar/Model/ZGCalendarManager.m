//
//  ZGCalendarManager.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/9/8.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import "ZGCalendarManager.h"
#import "ZGDayModel.h"
#import "ZGChineseDate.h"
#import "ZGHolidayManager.h"

/**
 components.weekday 1 星期天 2 星期一 3 星期二 4 兴趣三 5 星期四 6 星期五 7 星期六
 **/

@interface ZGCalendarManager ()

@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic, strong) NSCalendar *chineseCalendar;

@property (nonatomic, strong) NSArray *chineseYears;
@property (nonatomic, strong) NSArray *chineseMonths;
@property (nonatomic, strong) NSArray *chineseDays;

@end


@implementation ZGCalendarManager

+ (instancetype)shareCalendarManager
{
    static dispatch_once_t onceToken;
    static ZGCalendarManager *_calendarManager_ = nil;
    dispatch_once(&onceToken, ^{
        _calendarManager_ = [[ZGCalendarManager alloc] init];
    });
    
    return _calendarManager_;
}

#pragma mark -
- (NSMutableArray *)daysArrayWithDate:(NSDate *)date
{
    NSMutableArray *daysArray = [NSMutableArray array];
    [daysArray addObjectsFromArray:[self createDayModelArrayPreviousMonthWithDate:date]];
    [daysArray addObjectsFromArray:[self createDayModelArrayCurrentMonthWithDate:date]];
    [daysArray addObjectsFromArray:[self createDayModelArrayNextMonthWithDate:date]];
    return daysArray;
}


#pragma mark -
- (NSUInteger)numberOfDaysInCurrentMonthWithDate:(NSDate *)date
{
    return [self.calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
}

/**
 
 *  根据时间获取第一天周几
 
 *
 
 *  @param dateStr 时间
 
 *
 
 *  @return 周几
 
 */

- (NSDate*)getMonthBeginAndEndWith:(NSDate *)date
{
    
    double interval = 0;
    
    NSDate *beginDate = nil;
    
    NSDate *endDate = nil;
    
//    [calendar setFirstWeekday:0];//设定周一为周首日
    
    BOOL ok = [self.calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:date];
    
    if (ok) {
        
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
        
    }else {
        
        return nil;
        
    }
    
    return beginDate;
    
}


- (NSUInteger)weeklyOrdinalityWithDate:(NSDate *)date
{
    return [self.calendar ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:date];
}

- (NSUInteger)numberOfWeeksInCurrentMonth
{
    NSUInteger weekday = [self weeklyOrdinalityWithDate:[self getMonthBeginAndEndWith:[NSDate date]]];
    
    NSUInteger days = [self numberOfDaysInCurrentMonthWithDate:[NSDate date]];
    NSUInteger weeks = 0;
    
    if (weekday > 1) {
        weeks += 1, days -= (7 - weekday + 1);
    }
    
    weeks += days / 7;
    weeks += (days % 7 > 0) ? 1 : 0;
    
    return weeks;
}

#pragma mark - util
//- (NSDate *)dateWithDay:(NSInteger)day month:(NSInteger)month year:(NSInteger)year
//{
//    NSDateComponents *components = [[NSDateComponents alloc] init];
//    components.year = year;
//    components.month = month;
//    components.day = day;
//    NSDate *date = [self.calendar dateFromComponents:components];
//    return date;
//}

- (NSInteger)weekDayFormatFrom:(NSInteger)weekDayOriginal
{
    NSInteger weekDay = 0;
    if (weekDayOriginal == 1) {
        weekDay = 7;
    }else {
        weekDay = weekDayOriginal - 1;
    }
    
    return weekDay;
}

- (BOOL)isDateInToday:(NSDate *)date
{
    return [self.calendar isDateInToday:date];
}

#pragma mark - method to calculate days in previous, current and the next month.
/** previousMonth
 */

- (NSInteger)calculateDaysInPreviousMonthWithDate:(NSDate *)date
{
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:0];
    
    [adcomps setMonth:-1];
    
    [adcomps setDay:0];
    
    NSDate *preDate = [self.calendar dateByAddingComponents:adcomps toDate:date options:0];
    
    return [self numberOfDaysInCurrentMonthWithDate:preDate];
}

- (NSMutableArray *)createDayModelArrayPreviousMonthWithDate:(NSDate *)date
{
    NSDate *firstDate = [self getMonthBeginAndEndWith:date];
    
    // dayModelArray
    NSMutableArray *dayModelArray = [NSMutableArray array];
    NSCalendarUnit dayInfoUnits  =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    // NSDateComponents封装了日期的组件,年月日时分秒等(个人感觉像是平时用的model模型)
    NSDateComponents *components = [self.calendar components: dayInfoUnits fromDate:firstDate];
    
//    NSLog(@"%zd,%zd,%zd,%zd",components.year,components.month,components.day,components.weekday);
    
    // 如果当前月第一天是星期天 就不用前个月数据了
    if (components.weekday == 1) {
        return nil;
    }
    
    NSInteger weekday = [self weekDayFormatFrom:components.weekday];
    
    NSInteger daysPreMonth = [self calculateDaysInPreviousMonthWithDate:date];
    
    // components 改为上个月的
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:0];
    
    [adcomps setMonth:-1];
    
    [adcomps setDay:0];
    
    NSDate *preMonthDate = [self.calendar dateByAddingComponents:adcomps toDate:firstDate options:0];

    components = [self.calendar components: dayInfoUnits fromDate:preMonthDate];
    
    NSInteger month = components.month;
    NSInteger year = components.year;
    NSInteger day = daysPreMonth;

    for (int i=(int)weekday -1; i>=0; i--) {
        
        ZGDayModel *dayModel = [ZGDayModel dayModelWithDay:day-i month:month year:year monthType:ZGDayModelMonthTypePrevious];
        
        [dayModelArray addObject:dayModel];
    }
    
    return dayModelArray;

}

/** currentMonth
 */
- (NSInteger)calculateDaysInCurrentMonthWithDate:(NSDate *)date
{
    return [self numberOfDaysInCurrentMonthWithDate:date];
}

- (NSMutableArray *)createDayModelArrayCurrentMonthWithDate:(NSDate *)date
{
    // dayModelArray
    NSMutableArray *dayModelArray = [NSMutableArray array];
    NSCalendarUnit dayInfoUnits  =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    // NSDateComponents封装了日期的组件,年月日时分秒等(个人感觉像是平时用的model模型)
    NSDateComponents *components = [self.calendar components: dayInfoUnits fromDate:date];
    
    NSInteger daysCurMonth = [self numberOfDaysInCurrentMonthWithDate:date];
    
    NSInteger month = components.month;
    NSInteger year = components.year;

    for (int i=1; i<=daysCurMonth; i++) {
        
        ZGDayModel *dayModel = [ZGDayModel dayModelWithDay:i month:month year:year monthType:ZGDayModelMonthTypeCurrent];
        [dayModelArray addObject:dayModel];
        
    }
    
    return dayModelArray;
    
}

/** nextMonth
 */
//- (NSInteger)calculateDaysInNextMonthWithDate:(NSDate *)date
//{
//    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
//    
//    [adcomps setYear:0];
//    
//    [adcomps setMonth:-1];
//    
//    [adcomps setDay:0];
//    
//    NSDate *nextDate = [self.calendar dateByAddingComponents:adcomps toDate:date options:0];
//    
//    return [self numberOfDaysInCurrentMonthWithDate:nextDate];
//}

- (NSMutableArray *)createDayModelArrayNextMonthWithDate:(NSDate *)date
{
    NSDate *firstDate = [self getMonthBeginAndEndWith:date];
    
    // dayModelArray
    NSMutableArray *dayModelArray = [NSMutableArray array];
    NSCalendarUnit dayInfoUnits  =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    // NSDateComponents封装了日期的组件,年月日时分秒等(个人感觉像是平时用的model模型)
    NSDateComponents *components = [self.calendar components: dayInfoUnits fromDate:firstDate];
    
    NSInteger weekday = [self weekDayFormatFrom:components.weekday];
    
    NSInteger daysCurMonth = [self calculateDaysInCurrentMonthWithDate:date];
    
    
    NSInteger daysInNextMonth = 7 - ((daysCurMonth - (7-weekday)) % 7);
    
    
    // components 改为下个月的
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:0];
    
    [adcomps setMonth:+1];
    
    [adcomps setDay:0];
    
    NSDate *nextMonthDate = [self.calendar dateByAddingComponents:adcomps toDate:firstDate options:0];
    
    components = [self.calendar components: dayInfoUnits fromDate:nextMonthDate];

    
    NSInteger month = components.month;
    NSInteger year = components.year;
    
    for (int i=1; i<=daysInNextMonth; i++) {
        
        ZGDayModel *dayModel = [ZGDayModel dayModelWithDay:i month:month year:year monthType:ZGDayModelMonthTypeNext];
        [dayModelArray addObject:dayModel];
    }
    
    return dayModelArray;
    
}

#pragma mark -
- (ZGChineseDate *)getChineseCalendarWithDate:(NSDate *)date
{
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents *localeComp = [self.chineseCalendar components:unitFlags fromDate:date];
    
//    NSLog(@"%zd,%zd,%zd",localeComp.year,localeComp.month,localeComp.day);
    
    NSString *y_str = [self.chineseYears objectAtIndex:localeComp.year];
    NSString *m_str = [self.chineseMonths objectAtIndex:localeComp.month];
    NSString *d_str = [self.chineseDays objectAtIndex:localeComp.day];
    
    ZGChineseDate *chineseDate = [ZGChineseDate dateWithYear:y_str month:m_str day:d_str components:localeComp];
    
    return chineseDate;
}


#pragma mark - getter
- (NSCalendar *)getCalendarWithCalendarIdentifier:(NSCalendarIdentifier)calendarIdentifier
{
    if (calendarIdentifier == NSCalendarIdentifierGregorian) {
        return self.calendar;
    }else if (calendarIdentifier == NSCalendarIdentifierChinese) {
        return self.chineseCalendar;
    }
    
    return nil;
}

- (NSCalendar *)calendar
{
    if (!_calendar) {
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
        NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
        [_calendar setTimeZone: timeZone];

    }
    return _calendar;
}

- (NSCalendar *)chineseCalendar
{
    if (!_chineseCalendar) {
        _chineseCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
        
        _chineseYears = [NSArray arrayWithObjects:@"",
                                 @"甲子", @"乙丑", @"丙寅", @"丁卯",  @"戊辰",  @"己巳",  @"庚午",  @"辛未",  @"壬申",  @"癸酉",
                                 @"甲戌",   @"乙亥",  @"丙子",  @"丁丑", @"戊寅",   @"己卯",  @"庚辰",  @"辛己",  @"壬午",  @"癸未",
                                 @"甲申",   @"乙酉",  @"丙戌",  @"丁亥",  @"戊子",  @"己丑",  @"庚寅",  @"辛卯",  @"壬辰",  @"癸巳",
                                 @"甲午",   @"乙未",  @"丙申",  @"丁酉",  @"戊戌",  @"己亥",  @"庚子",  @"辛丑",  @"壬寅",  @"癸丑",
                                 @"甲辰",   @"乙巳",  @"丙午",  @"丁未",  @"戊申",  @"己酉",  @"庚戌",  @"辛亥",  @"壬子",  @"癸丑",
                                 @"甲寅",   @"乙卯",  @"丙辰",  @"丁巳",  @"戊午",  @"己未",  @"庚申",  @"辛酉",  @"壬戌",  @"癸亥", nil];
        
         _chineseMonths=[NSArray arrayWithObjects:@"",
                                @"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",
                                @"九月", @"十月", @"冬月", @"腊月", nil];
        
        
        _chineseDays=[NSArray arrayWithObjects:@"",
                              @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
                              @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                              @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十",  nil];
    }
    return _chineseCalendar;
}


@end
