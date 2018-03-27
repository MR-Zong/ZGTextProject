//
//  ZGCalendarHeaderView.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/9/8.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZGCalendarHeaderView;

@protocol  ZGCalendarHeaderViewDelegate <NSObject>

- (void)calendarHeaderView:(ZGCalendarHeaderView *)calendarHeaderview didTouchPreBtn:(UIButton *)btn;
- (void)calendarHeaderView:(ZGCalendarHeaderView *)calendarHeaderview didTouchNextBtn:(UIButton *)btn;

@end

@interface ZGCalendarHeaderOptionView : UIView

@property (nonatomic, strong) UIButton *preBtn;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UILabel *yearAndMonthLabel;

@property (nonatomic, weak) id <ZGCalendarHeaderViewDelegate> delegate;

@end

@interface ZGCalendarHeaderTitleView : UIView

@end

@interface ZGCalendarHeaderView : UIView

@property (nonatomic, strong) ZGCalendarHeaderOptionView *optionView;

@property (nonatomic, weak) id <ZGCalendarHeaderViewDelegate> delegate;

@end
