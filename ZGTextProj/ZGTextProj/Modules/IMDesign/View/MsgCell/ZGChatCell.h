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

@class ZGChatCell;

@protocol ZGChatCellDelegate <NSObject>

- (void)chatCell:(ZGChatCell *)cell didTouchHeaderWithMsgModel:(ZGChatMessageModel *)messageModel;
- (void)chatCell:(ZGChatCell *)cell didTouchBubbleWithMsgModel:(ZGChatMessageModel *)messageModel;
- (void)chatCell:(ZGChatCell *)cell didRetrybtnWithMsgModel:(ZGChatMessageModel *)messageModel;

@end

@interface ZGChatCell : ZGChatBaseCell

@property (nonatomic, weak) id <ZGChatCellDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
