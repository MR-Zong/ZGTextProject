//
//  ZGChatMessageModel.h
//  ZGTextProj
//
//  Created by ali on 2019/2/18.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ZGChatMessageType) {
    ZGChatMessageType_Text,
    ZGChatMessageType_Audio,
    ZGChatMessageType_time,
    ZGChatMessageType_Undefine,
};

typedef NS_ENUM(NSInteger,ZGChatMessageDeliveryState) {
    ZGChatMessageDeliveryState_Pending = 0, // 待发送
    ZGChatMessageDeliveryState_Delivering, // 发送中
    ZGChatMessageDeliveryState_Delivered, // 发送成功
    ZGChatMessageDeliveryState_Failure, // 发送失败
};

@interface ZGChatMessageModel : NSObject

/** 是否是发送者 */
@property (nonatomic, assign) BOOL isSender;
/** 是否已读 */
@property (nonatomic) BOOL isRead;
/** 是否是群聊 */
@property (nonatomic) BOOL isChatGroup;

@property (nonatomic, assign) ZGChatMessageType type;
@property (nonatomic, assign) ZGChatMessageDeliveryState status;
//@property (nonatomic, strong) NSString *date;
@property (nonatomic, assign) NSTimeInterval creatTime;
//@property (nonatomic, strong) NSString *id;

/** text */
@property (nonatomic, strong) NSString *content;

/** image */
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) NSURL *imageRemoteURL;

/** rowHeight */
@property (nonatomic, assign) CGFloat rowHeight;

@end

NS_ASSUME_NONNULL_END
