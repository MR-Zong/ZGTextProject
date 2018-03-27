//
//  ZGDayModel.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/9/9.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZGChineseDate.h"

typedef NS_ENUM(NSInteger,ZGDayModelMonthType){
    ZGDayModelMonthTypeCurrent,
    ZGDayModelMonthTypePrevious,
    ZGDayModelMonthTypeNext,
};

@interface ZGDayModel : NSObject

+ (instancetype)dayModelWithDay:(NSInteger)day month:(NSInteger)month year:(NSInteger)year monthType:(ZGDayModelMonthType)monthType;

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) ZGDayModelMonthType monthType;
@property (nonatomic, strong) ZGChineseDate *chineseDate;
@property (nonatomic, assign) BOOL isToday;
@property (nonatomic, strong) NSString *lunarHoliday;
@property (nonatomic, strong) NSString *worldHoliday;
@property (nonatomic, strong) NSString *lunarSpecialDay;

@end
