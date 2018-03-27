//
//  ZGCalendarCell.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/9/8.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import "ZGCalendarCell.h"
#import "ZGDayModel.h"

NSString *const ZGCalendarCellReusedID = @"ZGCalendarCellReusedID";

@interface ZGCalendarCell ()


@end


@implementation ZGCalendarCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        CGFloat margin = 10.0;
        CGFloat dateLableHeight = 20.0;
        CGFloat chineseLableHeight = 12.0;
        CGFloat baseY = self.bounds.size.height - 2 * margin - dateLableHeight - 5.0 - chineseLableHeight;
        _dateLable = [[UILabel alloc] initWithFrame:CGRectMake(0, baseY, self.bounds.size.width, dateLableHeight)];
        _dateLable.textAlignment = NSTextAlignmentCenter;
        _dateLable.textColor = [UIColor blackColor];
        _dateLable.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:_dateLable];
        
        _chineseLable = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_dateLable.frame) + 5.0, self.bounds.size.width, chineseLableHeight)];
        _chineseLable.textAlignment = NSTextAlignmentCenter;
        _chineseLable.textColor = [UIColor grayColor];
        _chineseLable.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:_chineseLable];

    }
    return self;
}


#pragma mark -setter
- (void)setDayModel:(ZGDayModel *)dayModel
{
    _dayModel = dayModel;
    
    // 公历显示
    self.dateLable.text = [NSString stringWithFormat:@"%zd",dayModel.day];
    
    // 农历显示
    self.chineseLable.text = dayModel.chineseDate.day;
    if ([dayModel.chineseDate.day isEqualToString:@"初一"]) {
        self.chineseLable.text = dayModel.chineseDate.month;
    }
    if (dayModel.worldHoliday.length > 0) {
        self.chineseLable.text = dayModel.worldHoliday;
    }
    if (dayModel.lunarSpecialDay.length > 0) {
        self.chineseLable.text = dayModel.lunarSpecialDay;
    }
    if (dayModel.lunarHoliday.length > 0) {
        self.chineseLable.text = dayModel.lunarHoliday;
    }
    
    if (dayModel.monthType == ZGDayModelMonthTypeCurrent) {
        self.dateLable.textColor = [UIColor blackColor];
    }else if (dayModel.monthType == ZGDayModelMonthTypePrevious){
        self.dateLable.textColor = [UIColor grayColor];
    }else if (dayModel.monthType == ZGDayModelMonthTypeNext){
        self.dateLable.textColor = [UIColor grayColor];
    }
    
    // 是否今天
    if (dayModel.isToday) {
        self.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
    }else {
        self.backgroundColor = [UIColor clearColor];
    }
    
}

@end
