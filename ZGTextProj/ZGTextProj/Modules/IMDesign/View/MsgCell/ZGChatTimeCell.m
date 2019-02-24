//
//  ZGChatTimeCell.m
//  ZGTextProj
//
//  Created by ali on 2019/2/18.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGChatTimeCell.h"
#import <Masonry/Masonry.h>

@interface ZGChatTimeCell ()

@property (nonatomic, strong) UIView *leftLine;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView *rightLine;

@end

@implementation ZGChatTimeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _leftLine = [[UIView alloc] init];
        _leftLine.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_leftLine];
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_timeLabel];
        
        _rightLine = [[UIView alloc] init];
        _rightLine.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_rightLine];
        
        // auto layout
        [_leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.timeLabel.mas_left).offset(-5.f);
            make.centerY.equalTo(self.timeLabel);
            make.width.equalTo(@40);
            make.height.equalTo(@1);
        }];
        
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.centerY.equalTo(self.contentView);
            make.height.equalTo(@20);
            make.width.lessThanOrEqualTo(@200);
        }];
        
        [_rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.timeLabel.mas_right).offset(5.f);
            make.centerY.equalTo(self.timeLabel);
            make.width.equalTo(@40);
            make.height.equalTo(@1);
        }];
    }
    return self;
}

- (void)setTime:(NSTimeInterval)time
{
    _time = time;
    
    self.timeLabel.text = [self timeStringWithTime:time];
}

- (NSString *)timeStringWithTime:(NSTimeInterval)time
{
    NSString *timeStr = nil;
    NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:time];
    NSDate *curDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:timeDate];
    NSDateComponents *curComponents = [calendar components:NSCalendarUnitYear fromDate:timeDate];
    if (time - curDate.timeIntervalSince1970 < 60) {
        timeStr = [NSString stringWithFormat:@"刚刚"];
    }else if (time - curDate.timeIntervalSince1970 < 3600) {
        timeStr = [NSString stringWithFormat:@"%zd分钟前",components.minute];
    }else if ([calendar isDateInToday:timeDate]) {
        timeStr = [NSString stringWithFormat:@"%zd:%zd",components.hour,components.minute];
    }else if ([calendar isDateInYesterday:timeDate]){
        timeStr = [NSString stringWithFormat:@"昨天%zd:%zd",components.hour,components.minute];
    }else if (components.year == curComponents.year){
        timeStr = [NSString stringWithFormat:@"%zd月%zd日",components.month,components.day];
    }else {
        timeStr = [NSString stringWithFormat:@"%zd年%zd月%zd日",components.year,components.month,components.day];
    }
    return timeStr;

}
@end
