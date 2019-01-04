//
//  AudioQueuePlayer.h
//  ZGTextProj
//
//  Created by ali on 2019/1/2.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

NS_ASSUME_NONNULL_BEGIN

@interface AudioQueuePlayer : NSObject

+ (void)setupAudioSession;

// 播放的数据流数据
- (void)playWithData:(NSData *)data;

// 声音播放出现问题的时候可以重置一下
- (void)cleanUp;

// 停止播放
- (void)stop;

@end

NS_ASSUME_NONNULL_END
