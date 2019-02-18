//
//  ZGChatTextBubbleView.m
//  ZGTextProj
//
//  Created by ali on 2019/2/18.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGChatTextBubbleView.h"
#import <Masonry.h>

@interface ZGChatTextBubbleView ()

@property (nonatomic, strong) UILabel *textLabel;
@end

@implementation ZGChatTextBubbleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _textLabel = [[UILabel alloc] init];
        _textLabel.numberOfLines = 0;
        _textLabel.font = [UIFont systemFontOfSize:14];
        _textLabel.textColor = [UIColor blackColor];
        [self addSubview:_textLabel];
        
        // auto layout
        [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(ZGCHAT_BUBBLE_VIEW_PADDING_HORIZONTAL);
            make.width.lessThanOrEqualTo(@(ZGCHAT_TEXTLABEL_MAX_WIDTH));
            make.centerY.equalTo(self);
        }];
    }
    return self;
}

+ (CGFloat)heightForBubbleWithObject:(ZGChatMessageModel *)object
{
     CGSize textSize = [object.content boundingRectWithSize:CGSizeMake(ZGCHAT_TEXTLABEL_MAX_WIDTH, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    return ZGCHAT_BUBBLE_VIEW_PADDING*2+textSize.height;
}

- (CGSize)sizeThatFits:(CGSize)size {
    
    CGSize textSize = [self.messageModel.content boundingRectWithSize:CGSizeMake(ZGCHAT_TEXTLABEL_MAX_WIDTH, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName:self.textLabel.font} context:nil].size;
    
    return CGSizeMake(textSize.width + ZGCHAT_BUBBLE_VIEW_PADDING_HORIZONTAL * 2 + ZGCHAT_BUBBLE_ARROW_WIDTH, 2 * ZGCHAT_BUBBLE_VIEW_PADDING + textSize.height);
}

- (void)setMessageModel:(ZGChatMessageModel *)messageModel {
    [super setMessageModel:messageModel];
    
    if (messageModel.isSender) {
        [_textLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(ZGCHAT_BUBBLE_VIEW_PADDING_HORIZONTAL);
        }];
    }else {
        [_textLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(ZGCHAT_BUBBLE_VIEW_PADDING_HORIZONTAL+ZGCHAT_BUBBLE_ARROW_WIDTH);
        }];
    }
    self.textLabel.text = messageModel.content;
}

@end
