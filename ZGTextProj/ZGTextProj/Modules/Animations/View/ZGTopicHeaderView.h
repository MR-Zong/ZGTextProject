//
//  ZGTopicHeaderView.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/6/21.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN CGFloat ZGTopicHeaderViewBaseHeight;
UIKIT_EXTERN CGFloat ZGTopicHeaderViewBaseTextHeight;


@class ZGTopicHeaderView;

@protocol ZGTopicHeaderViewDelegate <NSObject>
- (void)topicHeaderView:(ZGTopicHeaderView *)view didExtendBtn:(UIButton *)btn;
- (void)topicHeaderView:(ZGTopicHeaderView *)view didDescLabelWithExtendBtn:(UIButton *)btn;
@end

@interface ZGTopicHeaderView : UIView

@property (nonatomic, weak) id <ZGTopicHeaderViewDelegate> delegate;
@property (nonatomic, assign) CGFloat textHeight;

@property (nonatomic, assign) BOOL isExtend;


@end
