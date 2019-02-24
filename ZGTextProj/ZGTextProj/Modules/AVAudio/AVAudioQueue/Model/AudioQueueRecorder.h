//
//  AudioQueueRecorder.h
//  ZGTextProj
//
//  Created by ali on 2019/1/2.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

NS_ASSUME_NONNULL_BEGIN

@class AudioQueueRecorder;

@protocol AudioQueueRecorderDelegate <NSObject>

- (void)audioQueueRecorder:(AudioQueueRecorder *)recorder pcmData:(NSData *)pcmData;

@end

@interface AudioQueueRecorder : NSObject

@property (nonatomic, weak) id <AudioQueueRecorderDelegate> delegate;

-(void)startRecording;

-(void)stopRecording;

@end

NS_ASSUME_NONNULL_END
