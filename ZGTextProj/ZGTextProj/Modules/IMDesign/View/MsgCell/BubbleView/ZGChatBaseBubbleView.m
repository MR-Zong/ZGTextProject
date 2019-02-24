//
//  ZGChatBaseBubbleView.m
//  ZGTextProj
//
//  Created by ali on 2019/2/18.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGChatBaseBubbleView.h"

// bubbleView 的背景图片
NSString *const BUBBLE_LEFT_IMAGE_NAME = @"IM_Chat_receiver_bg";
NSString *const BUBBLE_RIGHT_IMAGE_NAME = @"IM_Chat_sender_bg";

@interface ZGChatBaseBubbleView ()

@property (nonatomic, strong) UIImageView *backImageView;

@end

@implementation ZGChatBaseBubbleView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.backImageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bubbleViewPressed:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setMessageModel:(ZGChatMessageModel *)messageModel {
    _messageModel = messageModel;
    
    BOOL isReceiver = !messageModel.isSender;
    NSString *imageName = isReceiver ? BUBBLE_LEFT_IMAGE_NAME : BUBBLE_RIGHT_IMAGE_NAME;
    NSInteger leftCapWidth = isReceiver?ZGCHAT_BUBBLE_LEFT_LEFT_CAP_WIDTH:ZGCHAT_BUBBLE_RIGHT_LEFT_CAP_WIDTH;
    NSInteger topCapHeight =  isReceiver?ZGCHAT_BUBBLE_LEFT_TOP_CAP_HEIGHT:ZGCHAT_BUBBLE_RIGHT_TOP_CAP_HEIGHT;
    
    UIImage *image = [UIImage imageNamed:imageName];
    NSInteger bottomCapHeight = image.size.height - topCapHeight - 1;
    NSInteger rightCapWidth = image.size.width - leftCapWidth -1;
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(topCapHeight, leftCapWidth, bottomCapHeight, rightCapWidth)];
    self.backImageView.image = image;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backImageView.frame = self.bounds;
}

#pragma mark - public
+ (CGFloat)heightForBubbleWithObject:(ZGChatMessageModel *)object {
    return 40;
}

- (void)bubbleViewPressed:(id)sender
{
    if (self.didTouchBlock) {
        self.didTouchBlock();
    }
}

#pragma mark - lazy
- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.userInteractionEnabled = YES;
        _backImageView.multipleTouchEnabled = YES;
        _backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return _backImageView;
}

@end
