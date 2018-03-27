//
//  ZGMonthModel.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/9/9.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import "ZGMonthModel.h"
#import "ZGCalendarManager.h"

@implementation ZGMonthModel

+ (instancetype)monthModelWithYear:(NSInteger)year month:(NSInteger)month date:(NSDate *)date
{
    ZGMonthModel *model =[[ZGMonthModel alloc] init];
    model.year = year;
    model.month = month;
    model.date = date;
    return model;
}


- (NSMutableArray *)daysArray
{
    if (!_daysArray) {
        _daysArray = [[ZGCalendarManager shareCalendarManager] daysArrayWithDate:self.date];;
    }
    return _daysArray;
}

@end
