//
//  ZGRecorder.h
//  AudioProgress
//
//  Created by ali on 2019/1/16.
//  Copyright © 2019 赵成峰. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZGRecorder : NSObject

+ (void)configAVAudioSession;

/**
 *  开始录音
 */
- (instancetype)initWithResultPath:(NSString *)resultPath;


/**
 *  开始录音
 */
- (void)start;

/**
 *  停止录音
 */
- (void)stop;

@end

NS_ASSUME_NONNULL_END
