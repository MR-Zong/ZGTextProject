//
//  ZGProModelB.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/7/19.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGProModelB.h"
#import <objc/runtime.h>

@implementation ZGProModelB

//@synthesize name;
//@synthesize delegate;
@synthesize finished = _finished;

- (void)printName
{
    NSLog(@"B-name %@",self.name);
}

@end
