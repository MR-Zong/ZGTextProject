//
//  ZGNRootController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/5/18.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGNRootController.h"
#import "ZGNTestController.h"

@interface ZGNRootController ()

@end

@implementation ZGNRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"rootVC";
    [self navTest];
    
    NSLog(@"%@-height %f",self.title,[UIScreen mainScreen].bounds.size.height);
    NSLog(@"%@-frame %@",self.title,NSStringFromCGRect(self.view.frame));

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
    ZGNTestController *vc = [[ZGNTestController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
