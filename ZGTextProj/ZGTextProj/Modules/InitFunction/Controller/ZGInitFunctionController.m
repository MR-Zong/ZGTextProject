//
//  ZGInitFunctionController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/4/26.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGInitFunctionController.h"
#import "ZGIFUAObject.h"

@interface ZGInitFunctionController ()

@end

@implementation ZGInitFunctionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"initFunction";
    
    [self test];
}


- (void)test
{
    ZGIFUAObject *a = [[ZGIFUAObject alloc] init];
    NSLog(@"age %zd",a.age);
}

@end
