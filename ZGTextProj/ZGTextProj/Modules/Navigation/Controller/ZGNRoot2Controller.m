//
//  ZGNRoot2Controller.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/6/1.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGNRoot2Controller.h"
#import "ZGNavView2Controller.h"

@interface ZGNRoot2Controller ()

@end

@implementation ZGNRoot2Controller

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // viewWillAppear 这里改view.frame 并没有实际效果
    NSLog(@"viewWillAppear");
//    self.view.frame = CGRectMake(0, 0, 100, 200);
    NSLog(@"view.frame %@",NSStringFromCGRect(self.view.frame));
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // viewDidAppear 这里改view.frame 才有效
    NSLog(@"viewDidAppear ******");
//    self.view.frame = CGRectMake(0, 0, 300, 200);
    NSLog(@"view.frame %@",NSStringFromCGRect(self.view.frame));
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"root2";
    self.view.backgroundColor = [UIColor greenColor];
    
    NSLog(@"viewDidLoad");
    NSLog(@"view.frame %@",NSStringFromCGRect(self.view.frame));
    NSLog(@"screen.bounds %@",NSStringFromCGRect([UIScreen mainScreen].bounds));
    
    
    // viewDidLoad 这里改view.frame 并没有实际效果
//    self.view.frame = CGRectMake(0, 0, 100, 0);
    NSLog(@"view.frame %@",NSStringFromCGRect(self.view.frame));
    
    [self setupBtn];
}

// 测试view heigth
- (void)setupBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 60, 40);
    [btn addTarget:self action:@selector(didBtn) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"Nav测试" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:btn];
}


- (void)didBtn
{
    ZGNavView2Controller *vc = [[ZGNavView2Controller alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
