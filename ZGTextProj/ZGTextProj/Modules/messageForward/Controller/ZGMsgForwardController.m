//
//  ZGMsgForwardController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/1/28.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGMsgForwardController.h"
#import "ZGMFPeople.h"

@interface ZGMsgForwardController ()

@end

@implementation ZGMsgForwardController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"消息转发机制";
    
    ZGMFPeople *p = [[ZGMFPeople alloc] init];
    [p name];
}


@end
