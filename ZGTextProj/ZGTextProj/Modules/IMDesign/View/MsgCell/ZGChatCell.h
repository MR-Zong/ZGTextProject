//
//  ZGChatCell.h
//  ZGTextProj
//
//  Created by ali on 2019/2/18.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGChatBaseCell.h"
#import "ZGChatTextBubbleView.h"
#import "ZGChatAudioBubbleView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZGChatCell : ZGChatBaseCell

@property (nonatomic, strong) UIActivityIndicatorView *activtiy;
@property (nonatomic, strong) UIView *activityView;
@property (nonatomic, strong) UIButton *retryButton;

@end

NS_ASSUME_NONNULL_END
