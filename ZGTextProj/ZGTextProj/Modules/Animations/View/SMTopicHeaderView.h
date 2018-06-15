//
//  SMTopicHeaderView.h
//  Sleep
//
//  Created by 徐宗根 on 2018/6/14.
//  Copyright © 2018年 Kugou. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN CGFloat SMTopicHeaderViewBaseHeight;
UIKIT_EXTERN CGFloat SMTopicHeaderViewBaseTextHeight;


@class SMTopicHeaderView;

@protocol SMTopicHeaderViewDelegate <NSObject>
- (void)topicHeaderView:(SMTopicHeaderView *)view didExtendBtn:(UIButton *)btn;
- (void)topicHeaderView:(SMTopicHeaderView *)view didDescLabelWithExtendBtn:(UIButton *)btn;
@end

@interface SMTopicHeaderView : UIView

@property (nonatomic, weak) id <SMTopicHeaderViewDelegate> delegate;
@property (nonatomic, assign) CGFloat textHeight;


@end
