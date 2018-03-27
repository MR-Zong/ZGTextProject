//
//  ZGInitializeController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/3/13.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGInitializeController.h"
#import "ZGINBaseObject.h"
#import "ZGINSubObject.h"
#import "ZGINSubObject+initialize.h"

@interface ZGInitializeController ()

@end

@implementation ZGInitializeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"initialize调用顺序";
    
    ZGINSubObject *obj = [[ZGINSubObject alloc] init];
    [obj eat];
    
}


@end
