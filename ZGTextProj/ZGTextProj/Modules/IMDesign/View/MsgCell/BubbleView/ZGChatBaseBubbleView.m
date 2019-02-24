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
@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@property (nonatomic, assign) CGFloat cornerRadius_topRight;
@property (nonatomic, assign) CGFloat cornerRadius_topLeft;
@property (nonatomic, assign) CGFloat cornerRadius_bottomRight;
@property (nonatomic, assign) CGFloat cornerRadius_bottomLeft;

@end

@implementation ZGChatBaseBubbleView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.backImageView];
        
        _cornerRadius_topRight = 10;
        _cornerRadius_topLeft = 5;
        _cornerRadius_bottomRight = 10;
        _cornerRadius_bottomLeft = 10;

        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor greenColor].CGColor];
        _gradientLayer.locations = @[@0.1, @1.0];
        _gradientLayer.startPoint = CGPointMake(0, 0);
        _gradientLayer.endPoint = CGPointMake(1.0, 0);
        [self.layer addSublayer:_gradientLayer];
        
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

- (void)maskWithRect:(CGRect)rect
{
    // path
    CGSize  rectSize = rect.size;
    
    // 确定8个点，每条边有两个点 从左上点，顺时针
    CGPoint p_top_left = CGPointMake(self.cornerRadius_topLeft, 0);
    // 由于CGContextAddArcToPoint特性，这里必须是刚好右上角的点
    CGPoint p_top_right = CGPointMake(rectSize.width, 0);
    
    CGPoint p_right_top = CGPointMake(rectSize.width, self.cornerRadius_topRight);
    // 由于CGContextAddArcToPoint特性，这里必须是刚好右下角的点
    CGPoint p_right_bottom = CGPointMake(rectSize.width, rectSize.height);
    
    CGPoint p_bottom_right = CGPointMake(rectSize.width - self.cornerRadius_bottomRight, rectSize.height);
    // 由于CGContextAddArcToPoint特性，这里必须是刚好左下角的点
    CGPoint p_bottom_left = CGPointMake(0, rectSize.height);
    
    CGPoint p_left_bottom = CGPointMake(0, rectSize.height - self.cornerRadius_bottomLeft);
    // 由于CGContextAddArcToPoint特性，这里必须是刚好左上角的点
    CGPoint p_left_top = CGPointMake(0, 0);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, p_top_left.x
                      , p_top_left.y);
    CGPathAddArcToPoint(path, NULL, p_top_right.x, p_top_right.y, p_right_top.x, p_right_top.y, self.cornerRadius_topRight);
    CGPathAddArcToPoint(path, NULL, p_right_bottom.x, p_right_bottom.y, p_bottom_right.x, p_bottom_right.y, self.cornerRadius_bottomRight);
    CGPathAddArcToPoint(path, NULL, p_bottom_left.x, p_bottom_left.y, p_left_bottom.x, p_left_bottom.y, self.cornerRadius_bottomLeft);
    CGPathAddArcToPoint(path, NULL, p_left_top.x, p_left_top.y, p_top_left.x, p_top_left.y, self.cornerRadius_topLeft);
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    [shapeLayer setPath:path];
    self.layer.mask = shapeLayer;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.messageModel.isSender) {
        _cornerRadius_topRight = 5;
        _cornerRadius_topLeft = 10;
        _cornerRadius_bottomRight = 10;
        _cornerRadius_bottomLeft = 10;
    }else {
        _cornerRadius_topRight = 10;
        _cornerRadius_topLeft = 5;
        _cornerRadius_bottomRight = 10;
        _cornerRadius_bottomLeft = 10;
    }
    [self maskWithRect:self.bounds];
    self.backImageView.frame = self.bounds;
    self.gradientLayer.frame = self.bounds;
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
        _backImageView.hidden = YES;
        _backImageView.userInteractionEnabled = YES;
        _backImageView.multipleTouchEnabled = YES;
        _backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return _backImageView;
}

@end
