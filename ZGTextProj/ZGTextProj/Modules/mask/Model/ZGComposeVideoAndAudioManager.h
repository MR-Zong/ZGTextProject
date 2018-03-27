//
//  ZGComposeVideoAndAudioManager.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/8/4.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZGComposeVideoAndAudioManager : NSObject

+ (instancetype)shareInstance;
// 混合音乐
- (NSURL *)composeVideoInputUrl:(NSURL *)videoInputUrl audioInputUrl:(NSURL *)audioInputUrl;


@end
