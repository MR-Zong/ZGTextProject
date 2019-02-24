//
//  ZGChatInputInfoModel.h
//  ZGTextProj
//
//  Created by ali on 2019/2/18.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZGChatInputInfoModel : NSObject
/** text */
@property (nonatomic, strong) NSString *text;

/** audio */
@property (nonatomic, strong) NSString *audio_localPath;
@property (nonatomic, assign) NSInteger audio_duration;
@property (nonatomic, strong) NSString *audio_text;

@end

NS_ASSUME_NONNULL_END
