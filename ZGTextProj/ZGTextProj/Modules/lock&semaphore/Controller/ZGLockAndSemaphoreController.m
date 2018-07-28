//
//  ZGLockAndSemaphoreController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/7/28.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGLockAndSemaphoreController.h"

@implementation ZGLockAndSemaphoreController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    dispatch_queue_t que = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    NSLog(@"aaaaaaa");
//    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"zzzzzzzz");
    dispatch_async(que, ^{
        NSLog(@"start xxx");
        sleep(3);
        NSLog(@"end xxx");
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"yyyyyy");
//    dispatch_semaphore_signal(semaphore);
}

@end
