//
//  ZGTestWindowController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/12/28.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import "ZGTestWindowController.h"

@interface ZGTestWindowController ()

@property (nonatomic,strong) UIButton *btn;
@property (nonatomic, strong) UIWindow *myWindow;

@end

@implementation ZGTestWindowController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"window 相关";
    
    self.view.backgroundColor = [UIColor redColor];
    
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.backgroundColor = [UIColor greenColor];
    _btn.frame = CGRectMake(100, 100, 80, 40);
    [_btn setTitle:@"window" forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(didBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
}


- (void)didBtn:(UIButton *)btn
{
    self.myWindow = [[UIWindow alloc] initWithFrame:self.view.bounds];
    self.myWindow.windowLevel = UIWindowLevelAlert;
    self.myWindow.backgroundColor = [UIColor orangeColor];
    self.myWindow.hidden = NO;
}


@end
