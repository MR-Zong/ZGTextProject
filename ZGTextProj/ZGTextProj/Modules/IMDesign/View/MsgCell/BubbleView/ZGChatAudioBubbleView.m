//
//  ZGChatAudioBubbleView.m
//  ZGTextProj
//
//  Created by ali on 2019/2/18.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGChatAudioBubbleView.h"
#import <Masonry.h>

@interface ZGChatAudioBubbleView ()

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *playIconImgView;

@end

@implementation ZGChatAudioBubbleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
                
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = [UIFont systemFontOfSize:12];
        _textLabel.textColor = [UIColor blackColor];
        [self addSubview:_textLabel];
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = [UIColor blackColor];
        [self addSubview:_timeLabel];
        
        _playIconImgView = [[UIImageView alloc] init];
        _playIconImgView.image = [UIImage imageNamed:@"msgAudioPlay"];
        [self addSubview:_playIconImgView];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat playIcon_w = 14.7;
    CGFloat timeLabel_w = 16.0;
    CGFloat text_h = 20;
    CGFloat self_h = self.bounds.size.height;
    CGFloat self_w = self.bounds.size.width;
    CGFloat textLabel_w = self_w-timeLabel_w-playIcon_w-5-3-(8+10);
    self.timeLabel.backgroundColor = [UIColor orangeColor];
    self.playIconImgView.backgroundColor = [UIColor orangeColor];
    self.textLabel.backgroundColor = [UIColor orangeColor];
    if (self.messageModel.isSender) {
        self.timeLabel.frame = CGRectMake(8, (self_h-18)/2.0, timeLabel_w, text_h);
        self.textLabel.frame = CGRectMake(CGRectGetMaxX(self.timeLabel.frame)+5, (self_h-18)/2.0, textLabel_w, text_h);
        self.playIconImgView.frame = CGRectMake(CGRectGetMaxX(self.textLabel.frame)+8, (self_h-18)/2.0, playIcon_w, 18);
    }else {
        self.playIconImgView.frame = CGRectMake(10, (self_h-18)/2.0, playIcon_w, 18);
        self.textLabel.frame = CGRectMake(CGRectGetMaxX(self.playIconImgView.frame)+3.0, (self_h-text_h)/2.0, textLabel_w, text_h);
        self.timeLabel.frame = CGRectMake(self_w-timeLabel_w-8, (self_h-text_h)/2.0, timeLabel_w, text_h);
    }
}

+ (CGFloat)heightForBubbleWithObject:(ZGChatMessageModel *)object
{
    return 38;
}

- (CGSize)sizeThatFits:(CGSize)size {
    
    CGFloat baseLen = 70;
    CGFloat maxAudioLength = [UIScreen mainScreen].bounds.size.width - 68 - 20 - baseLen;
    CGFloat rate = 60.0 / maxAudioLength;
    CGFloat audioLen = baseLen + self.messageModel.audio_duration / rate;
    return CGSizeMake(audioLen,30);
}

- (void)setMessageModel:(ZGChatMessageModel *)messageModel
{
    [super setMessageModel:messageModel];
    
    self.textLabel.text = messageModel.audio_text;
    self.timeLabel.text = [self timeStringWtihDuration:messageModel.audio_duration];
}


#pragma mark -
- (NSString *)timeStringWtihDuration:(NSInteger)duration
{
    return [NSString stringWithFormat:@"%zd“",duration];
}

@end
