//
//  ZGClassFunctionController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/4/27.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGClassFunctionController.h"
#import <objc/runtime.h>

@interface ZGClassFunctionController ()

@end

@implementation ZGClassFunctionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self test];
}

- (void)test
{
    Class obj = [NSObject class];
    Class cls = object_getClass(obj);
    Class cls2 = [obj class];
    NSLog(@"%p",obj);
    NSLog(@"%p",cls);
    NSLog(@"%p",cls2);
}

@end
