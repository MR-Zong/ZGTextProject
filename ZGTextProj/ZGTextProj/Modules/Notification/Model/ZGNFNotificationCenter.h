//
//  ZGNFNotificationCenter.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/2/1.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZGNFNotificationCenter : NSObject

- (void)postNotification:(NSString *)notificationKey;

@end
