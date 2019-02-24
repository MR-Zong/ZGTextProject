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
    ZGChatMessageType_Undefine, // 未识别消息
};

typedef NS_ENUM(NSInteger,ZGChatMessageDeliveryState) {
    ZGChatMessageDeliveryState_Pending = 0, // 待发送
    ZGChatMessageDeliveryState_Delivering, // 发送中
    ZGChatMessageDeliveryState_Delivered, // 发送成功
    ZGChatMessageDeliveryState_Failure, // 发送失败
};

@interface ZGChatMessageModel : NSObject

#pragma mark - 需要手动设置
/** 是否是发送者 */
@property (nonatomic, assign) BOOL isSender;
/** 是否已读 暂时没用*/
@property (nonatomic) BOOL isRead;
/** 是否是群聊 暂时没用*/
@property (nonatomic) BOOL isChatGroup;
/** 消息类型*/
@property (nonatomic, assign) ZGChatMessageType type;
/** 消息发送状态*/
@property (nonatomic, assign) ZGChatMessageDeliveryState status;

#pragma mark - 数据库字段
@property (nonatomic, assign) NSTimeInterval creatTime;
/** 消息唯一id*/
//@property (nonatomic, strong) NSString *messageId;

#pragma mark - 或许可以放到子类
/** text */
@property (nonatomic, strong) NSString *content;

/** audio */
@property (nonatomic, strong) NSString *audio_localPath;
@property (nonatomic, assign) NSInteger audio_duration;
@property (nonatomic, strong) NSString *audio_text;

/** image */
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) NSURL *imageRemoteURL;

/** rowHeight */
@property (nonatomic, assign) CGFloat rowHeight;

@end

NS_ASSUME_NONNULL_END
