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
#import "ZGCornerView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZGChatBaseBubbleView : ZGCornerView

@property (nonatomic, strong) ZGChatMessageModel *messageModel;

+ (CGFloat)heightForBubbleWithObject:(ZGChatMessageModel *)object;
@property (nonatomic, copy) void(^didTouchBlock)(void);

@end

NS_ASSUME_NONNULL_END
