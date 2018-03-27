//
//  ZGInstanceController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/1/2.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGInstanceController.h"
#import "ZGBaseObject.h"

@interface ZGInstanceController ()

@end

@implementation ZGInstanceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Instance";
    
    // 此处断点
    // 然后在控制台 (lldb) p *bObj 查看打印内容
    ZGBObject *bObj = [[ZGBObject alloc] init];
}


@end
