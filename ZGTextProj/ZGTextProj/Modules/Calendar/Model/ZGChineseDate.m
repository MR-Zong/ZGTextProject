//
//  ZGChineseDate.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/9/10.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import "ZGChineseDate.h"

@implementation ZGChineseDate

+ (instancetype)dateWithYear:(NSString *)year month:(NSString *)month day:(NSString *)day components:(NSDateComponents *)components
{
    ZGChineseDate *date = [[ZGChineseDate alloc] init];
    date.year = year;
    date.month = month;
    date.day = day;
    date.yearI = components.year;
    date.monthI = components.month;
    date.dayI = components.day;
    return date;
}

@end
