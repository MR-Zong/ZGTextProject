//
//  ZGOperation.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/5/15.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGMainOperation.h"

@implementation ZGMainOperation

- (void)main
{
    NSLog(@"%@ start",self.fullName);
    NSLog(@"thread %@",[NSThread currentThread]);
    sleep(15);
    NSLog(@"%@ end",self.fullName);
}

@end
