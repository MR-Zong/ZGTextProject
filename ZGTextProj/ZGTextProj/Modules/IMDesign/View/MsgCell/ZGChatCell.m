//
//  ZGChatCell.m
//  ZGTextProj
//
//  Created by ali on 2019/2/18.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGChatCell.h"

CGFloat const ACTIVTIYVIEW_BUBBLE_PADDING = 5.0f;
CGFloat const SEND_STATUS_SIZE = 20.0f;

@implementation ZGChatCell

- (id)initWithMessageModel:(ZGChatMessageModel *)model reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithMessageModel:model reuseIdentifier:reuseIdentifier]) {
        self.headImageView.clipsToBounds = YES;
        self.headImageView.layer.cornerRadius = 20.0;
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect bubbleFrame = _bubbleView.frame;
    bubbleFrame.origin.y = self.headImageView.frame.origin.y;
    
    if (self.messageModel.isChatGroup) {
        bubbleFrame.origin.y = self.headImageView.frame.origin.y + ZGCHAT_NAME_LABEL_HEIGHT;
    }
    if (self.messageModel.isSender) {
        bubbleFrame.origin.y = self.headImageView.frame.origin.y;
        // 菊花状态 （因不确定菊花具体位置，要在子类中实现位置的修改）
        switch (self.messageModel.status) {
            case ZGChatMessageDeliveryState_Delivering:
            {
                [_activityView setHidden:NO];
                [_retryButton setHidden:YES];
                [_activtiy setHidden:NO];
                [_activtiy startAnimating];
            }
                break;
            case ZGChatMessageDeliveryState_Delivered:
            {
                [_activtiy stopAnimating];
                [_activityView setHidden:YES];
                
            }
                break;
            case ZGChatMessageDeliveryState_Failure:
            {
                [_activityView setHidden:NO];
                [_activtiy stopAnimating];
                [_activtiy setHidden:YES];
                [_retryButton setHidden:NO];
            }
                break;
            default:
                break;
        }
        
        bubbleFrame.origin.x = self.headImageView.frame.origin.x - bubbleFrame.size.width - 8;
        _bubbleView.frame = bubbleFrame;
        
        CGRect frame = self.activityView.frame;
        frame.origin.x = bubbleFrame.origin.x - frame.size.width - ACTIVTIYVIEW_BUBBLE_PADDING;
        frame.origin.y = _bubbleView.center.y - frame.size.height / 2;
        self.activityView.frame = frame;
    }
    else{
        bubbleFrame.origin.x = ZGCHAT_HEAD_Bubble_SPACE  + ZGCHAT_HEAD_SIZE + 8;
        _bubbleView.frame = bubbleFrame;
    }
}

- (void)setMessageModel:(ZGChatMessageModel *)model {
    [super setMessageModel:model];
    
    if (model.isChatGroup) {
        //        _nameLabel.text = [model.message.ext objectForKey:sendUserName];
        _nameLabel.hidden = model.isSender;
    }
    
    _bubbleView.messageModel = self.messageModel;
    [_bubbleView sizeToFit];
}

#pragma mark - action

// 重发按钮事件
- (void)retryButtonPressed:(UIButton *)sender {
//    [self routerEventWithName:kRouterEventChatResendEventName
//                     userInfo:@{kShouldResendCell : self}];
}

#pragma mark - override
- (void)setupSubviewsForMessageModel:(ZGChatMessageModel *)messageModel
{
    [super setupSubviewsForMessageModel:messageModel];
    
    if (messageModel.isSender) {
        // 发送进度显示view
        _activityView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SEND_STATUS_SIZE, SEND_STATUS_SIZE)];
        [_activityView setHidden:YES];
        [self.contentView addSubview:_activityView];
        
        // 重发按钮
        _retryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _retryButton.frame = CGRectMake(0, 0, SEND_STATUS_SIZE, SEND_STATUS_SIZE);
        [_retryButton addTarget:self action:@selector(retryButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_retryButton setImage:[UIImage imageNamed:@"messageSendFail"] forState:UIControlStateNormal];
        [_activityView addSubview:_retryButton];
        
        // 菊花
        _activtiy = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activtiy.backgroundColor = [UIColor clearColor];
        [_activityView addSubview:_activtiy];
    }
    
    _bubbleView = [self bubbleViewForMessageModel:messageModel];
    [self.contentView addSubview:_bubbleView];
}

- (ZGChatBaseBubbleView *)bubbleViewForMessageModel:(ZGChatMessageModel *)messageModel {
    switch (messageModel.type) {
        case ZGChatMessageType_Text: {
            return [[ZGChatTextBubbleView alloc] init];
        }
            break;
        case ZGChatMessageType_Audio: {
            return [[ZGChatAudioBubbleView alloc] init];
        }
            break;
        
        default:
            break;
    }
    
    return nil;
}

+ (CGFloat)bubbleViewHeightForMessageModel:(ZGChatMessageModel *)messageModel {
    switch (messageModel.type) {
        case ZGChatMessageType_Text: {
            return [ZGChatTextBubbleView heightForBubbleWithObject:messageModel];
        }
            break;
        case ZGChatMessageType_Audio: {
            return [ZGChatAudioBubbleView heightForBubbleWithObject:messageModel];
        }
            break;
        
        default:
            break;
    }
    
    return ZGCHAT_HEAD_SIZE;
}

+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath withObject:(ZGChatMessageModel *)model {
    NSInteger bubbleHeight = [self bubbleViewHeightForMessageModel:model];
    if (model.isChatGroup && !model.isSender) {
        bubbleHeight += ZGCHAT_NAME_LABEL_HEIGHT;
    }
    return MAX(ZGCHAT_HEAD_SIZE+ZGCHAT_CELL_PADDING, bubbleHeight+ZGCHAT_CELL_PADDING);
}

@end
