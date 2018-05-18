//
//  ZGNavTestController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/5/18.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGNavTestController.h"
#import "ZGNRootController.h"

@interface ZGNavTestController ()

@end

@implementation ZGNavTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"NavTest";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self navTest];
}

- (void)navTest
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 60, 40);
    [btn addTarget:self action:@selector(didBtn) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"Nav测试" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
}

- (void)didBtn
{
    ZGNRootController *rootVC = [[ZGNRootController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rootVC];
    [self presentViewController:nav animated:YES completion:nil];
}


@end
