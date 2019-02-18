//
//  ZGChatBaseBubbleView.h
//  ZGTextProj
//
//  Created by ali on 2019/2/18.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZGChatMessageModel.h"
#import "ZGChatConst.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZGChatBaseBubbleView : UIView

@property (nonatomic, strong) ZGChatMessageModel *messageModel;

+ (CGFloat)heightForBubbleWithObject:(ZGChatMessageModel *)object;
//- (void)bubbleViewPressed:(id)sender;

@end

NS_ASSUME_NONNULL_END
