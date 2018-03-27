//
//  ZGNFNotificationCenter.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/2/1.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGNFNotificationCenter.h"

@implementation ZGNFNotificationCenter

- (void)postNotification:(NSString *)notificationKey
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSLog(@"post t =  %@",[NSThread currentThread]);
        [[NSNotificationCenter defaultCenter] postNotification:[[NSNotification alloc] initWithName:notificationKey object:self userInfo:nil] ];
    });
}

@end
