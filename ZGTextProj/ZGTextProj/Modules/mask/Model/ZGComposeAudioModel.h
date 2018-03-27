//
//  ZGComposeAudioModel.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/8/4.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZGComposeAudioModel : NSObject

+ (instancetype)shareInstance;

+ (void) sourceURLs:(NSArray *) sourceURLs composeToURL:(NSURL *) toURL completed:(void (^)(NSError *error)) completed;
@end
