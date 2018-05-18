//
//  ZGNTestController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/5/18.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGNTestController.h"

@interface ZGNTestController ()

@end

@implementation ZGNTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"pushVC";
    
    NSLog(@"%@-height %f",self.title,[UIScreen mainScreen].bounds.size.height);
    NSLog(@"%@-frame %@",self.title,NSStringFromCGRect(self.view.frame));
}


@end
