//
//  ZGChatTipMesageModel.h
//  ZGTextProj
//
//  Created by ali on 2019/2/21.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,ZGChatTipMesageType) {
    ZGChatTipMesageType_Time, // 时间cell
    ZGChatTipMesageType_Be_Deleted_Friend, // 被删除好友
    ZGChatTipMesageType_DrawInto_Blacklist, // 被拉黑
};

@interface ZGChatTipMesageModel : NSObject

@property (nonatomic, assign) ZGChatTipMesageType tipType;

@property (nonatomic, assign) NSTimeInterval creatTime;


@end

NS_ASSUME_NONNULL_END
