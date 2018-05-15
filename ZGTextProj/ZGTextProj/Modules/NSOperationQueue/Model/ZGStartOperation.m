//
//  ZGStartOperation.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/5/15.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGStartOperation.h"

@interface ZGStartOperation (){
    BOOL _zg_isExecuting;
    BOOL _zg_isCancelled;
    BOOL _zg_isFinished;
}



@end

@implementation ZGStartOperation

- (void)start
{
    
    [self willChangeValueForKey:@"isExecuting"];
    _zg_isExecuting = YES;
    [self didChangeValueForKey:@"isExecuting"];

    
    NSLog(@"%@ start",self.fullName);
    NSLog(@"thread %@",[NSThread currentThread]);
    sleep(15);
    NSLog(@"%@ end",self.fullName);
    
    [self willChangeValueForKey:@"isFinished"];
    _zg_isFinished = YES;
    [self didChangeValueForKey:@"isFinished"];
}

- (BOOL)isCancelled
{
    return _zg_isCancelled;
}

- (BOOL)isFinished
{
    return _zg_isFinished;
}

- (BOOL)isExecuting
{
    return _zg_isExecuting;
}

@end
