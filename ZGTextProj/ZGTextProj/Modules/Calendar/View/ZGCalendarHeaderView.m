//
//  ZGCalendarHeaderView.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/9/8.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import "ZGCalendarHeaderView.h"

@implementation ZGCalendarHeaderOptionView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        CGFloat btnWidth = 80.0;
        CGFloat btnHeigt = frame.size.height;
        _preBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _preBtn.frame = CGRectMake(0, 0, btnWidth, btnHeigt);
        [_preBtn setTitle:@"上一月" forState:UIControlStateNormal];
        [_preBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_preBtn addTarget:self action:@selector(didTouchPreBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_preBtn];
        
        _yearAndMonthLabel = [[UILabel alloc] init];
        _yearAndMonthLabel.textAlignment = NSTextAlignmentCenter;
        _yearAndMonthLabel.frame = CGRectMake(CGRectGetMaxX(_preBtn.frame), 0, frame.size.width - 2*btnWidth, btnHeigt);
        _yearAndMonthLabel.font = [UIFont systemFontOfSize:16];
        _yearAndMonthLabel.textColor = [UIColor blackColor];
        _yearAndMonthLabel.text = @"2017年13月";
        [self addSubview:_yearAndMonthLabel];
        
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn.frame = CGRectMake(frame.size.width - btnWidth, 0, btnWidth, btnHeigt);
        [_nextBtn setTitle:@"下一月" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(didTouchNextBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_nextBtn];
    }
    return self;
}

- (void)didTouchPreBtn:(UIButton *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(calendarHeaderView:didTouchPreBtn:)]) {
        [self.delegate calendarHeaderView:(ZGCalendarHeaderView *)self.superview didTouchPreBtn:btn];
    }
}

- (void)didTouchNextBtn:(UIButton *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(calendarHeaderView:didTouchNextBtn:)]) {
        [self.delegate calendarHeaderView:(ZGCalendarHeaderView *)self.superview didTouchNextBtn:btn];
    }
}


@end


@implementation ZGCalendarHeaderTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        NSInteger columCount = 7;
        CGFloat labelWidth = frame.size.width / columCount;
        CGFloat labelHeight = frame.size.height;
        
        for (int i=0; i<columCount; i++) {
            
            CGRect labelFrame = CGRectMake(i*labelWidth, 0, labelWidth,labelHeight);
            
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = [UIColor whiteColor];
            label.backgroundColor = [UIColor redColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.frame = labelFrame;
            label.text  = [self weekDayStringWithIndex:i];
            [self addSubview:label];
        }
    }
    return self;
}


- (NSString *)weekDayStringWithIndex:(NSInteger)index
{
    NSString *weekDayString = nil;
    switch (index) {
        case 0:
            weekDayString = @"Sun";
            break;
        case 1:
            weekDayString = @"Mon";
            break;
        case 2:
            weekDayString = @"Tues";
            break;
        case 3:
            weekDayString = @"Wed";
            break;
        case 4:
            weekDayString = @"Thur";
            break;
        case 5:
            weekDayString = @"Fri";
            break;
        case 6:
            weekDayString = @"Sat";
            break;

    }
    return weekDayString;
}

@end


#pragma mark - 
@interface ZGCalendarHeaderView ()


@property (nonatomic, strong) ZGCalendarHeaderTitleView *titleView;

@end

@implementation ZGCalendarHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    _optionView = [[ZGCalendarHeaderOptionView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 44.0)];
    [self addSubview:_optionView];
    
    _titleView = [[ZGCalendarHeaderTitleView alloc] initWithFrame:CGRectMake(0, _optionView.frame.size.height, self.bounds.size.width, 44.0)];
    [self addSubview:_titleView];
}

#pragma  mark - setter
- (void)setDelegate:(id<ZGCalendarHeaderViewDelegate>)delegate
{
    _delegate = delegate;
    
    self.optionView.delegate = delegate;
}

@end
