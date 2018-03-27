//
//  ZGAudioManager.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/8/4.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZGAudioManagerDelegate <NSObject>

- (void)audioManagerDidCompleteComposeAudiosWithDestUrl:(NSURL *)destUrl;

@end

@interface ZGAudioManager : NSObject

+ (instancetype)shareInstance;

- (void)startRecord;
- (void)stopRecord;
- (NSURL *)composeAudios;
- (void)playComposeAudio;
- (void)playRecordAudio;

@property (nonatomic, weak) id <ZGAudioManagerDelegate> delegate;

@end
