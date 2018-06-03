//
//  ZGNavTestController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/5/18.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGNavTestController.h"
#import "ZGNRootController.h"
#import "ZGNavigationBar.h"
#import "ZGNRoot2Controller.h"

@interface ZGNavTestController ()

@property (nonatomic, strong) UINavigationController *nav;

@end

@implementation ZGNavTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"NavTest";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupBtn];
    [self setupNavView];
}


#pragma mark -
// 测试view heigth
- (void)setupBtn
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
    // 测试view heigth
    //    [self navTestViewHeight];
    
    // 测试 自定义 NavgationBar
    [self navTestCustomBar];
}

#pragma mark -
- (void)setupNavView
{
    ZGNRoot2Controller *rootVC = [[ZGNRoot2Controller alloc] init];
    _nav = [[UINavigationController alloc] initWithRootViewController:rootVC];
    _nav.view.frame = CGRectMake(50, 100, 300, 400);
    _nav.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:_nav.view];
    [self addChildViewController:_nav];
}

#pragma mark - 测试view heigth
- (void)navTestViewHeight
{
    ZGNRootController *rootVC = [[ZGNRootController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rootVC];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - 测试 自定义 NavgationBar
- (void)navTestCustomBar
{
    UINavigationController *nav = [[UINavigationController alloc] initWithNavigationBarClass:[ZGNavigationBar class] toolbarClass:[UIToolbar class]];
    ZGNRootController *rootVC = [[ZGNRootController alloc] init];
    nav.viewControllers = @[rootVC];
     [self presentViewController:nav animated:YES completion:nil];
}


@end
