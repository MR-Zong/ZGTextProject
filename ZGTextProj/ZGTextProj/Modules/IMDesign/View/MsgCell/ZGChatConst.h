//
//  ZGChatConst.h
//  ZGTextProj
//
//  Created by ali on 2019/2/18.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZGChatConst : NSObject
@end

#define ZG_SCREEN_W ([UIScreen mainScreen].bounds.size.width)
#define ZG_SCREEN_H ([UIScreen mainScreen].bounds.size.height)


#pragma mark - IM模块常量
// 头像大小
UIKIT_EXTERN CGFloat const ZGCHAT_HEAD_SIZE;
// 头像到bubble的间距
UIKIT_EXTERN CGFloat const ZGCHAT_HEAD_Bubble_SPACE;
// 头像与cell间距
UIKIT_EXTERN CGFloat const ZGCHAT_HEAD_CELL_SPACE;
// Cell之间间距
UIKIT_EXTERN CGFloat const ZGCHAT_CELL_PADDING;
// nameLabel宽度
UIKIT_EXTERN CGFloat const ZGCHAT_NAME_LABEL_WIDTH;
// nameLabel 高度
UIKIT_EXTERN CGFloat const ZGCHAT_NAME_LABEL_HEIGHT;
// nameLabel间距
UIKIT_EXTERN CGFloat const ZGCHAT_NAME_LABEL_PADDING;

//　textLaebl 最大宽度
UIKIT_EXTERN CGFloat const ZGCHAT_TEXTLABEL_MAX_WIDTH;

// tableView 拉起后最后一行消息与 输入条的间隔
UIKIT_EXTERN CGFloat const ZGCHAT_TABLEVIEW_CONTENTINESET_PADDING;

// bubbleView中，箭头的宽度
UIKIT_EXTERN CGFloat const ZGCHAT_BUBBLE_ARROW_WIDTH;

// bubbleView 与 在其中的控件内边距 水平
UIKIT_EXTERN CGFloat const ZGCHAT_BUBBLE_VIEW_PADDING_HORIZONTAL;

// bubbleView 与 在其中的控件内边距
UIKIT_EXTERN CGFloat const ZGCHAT_BUBBLE_VIEW_PADDING;
// 文字在右侧时,bubble用于拉伸点的X坐标
UIKIT_EXTERN CGFloat const ZGCHAT_BUBBLE_RIGHT_LEFT_CAP_WIDTH;
// 文字在右侧时,bubble用于拉伸点的Y坐标
UIKIT_EXTERN CGFloat const ZGCHAT_BUBBLE_RIGHT_TOP_CAP_HEIGHT;
// 文字在左侧时,bubble用于拉伸点的X坐标
UIKIT_EXTERN CGFloat const ZGCHAT_BUBBLE_LEFT_LEFT_CAP_WIDTH;
// 文字在左侧时,bubble用于拉伸点的Y坐标
UIKIT_EXTERN CGFloat const ZGCHAT_BUBBLE_LEFT_TOP_CAP_HEIGHT;
// progressView 高度
UIKIT_EXTERN CGFloat const ZGCHAT_BUBBLE_PROGRESSVIEW_HEIGHT;

NS_ASSUME_NONNULL_END
