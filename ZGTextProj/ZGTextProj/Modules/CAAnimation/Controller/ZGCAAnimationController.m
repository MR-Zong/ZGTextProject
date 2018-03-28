//
//  ZGCAAnimationController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/3/27.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGCAAnimationController.h"

@interface ZGCAAnimationController ()

@property (nonatomic, strong) UIView *animationView;

@end

@implementation ZGCAAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _animationView = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 40, 40)];
    _animationView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_animationView];
    
    CABasicAnimation *a1 = [CABasicAnimation animationWithKeyPath:@"position.x"];
    a1.fromValue = @100;
    a1.toValue = @340;
    a1.duration = 10;
    a1.repeatCount = 10;
    [_animationView.layer addAnimation:a1 forKey:@"a1"];
    
    // 证明CAAnimation 不会阻塞当前进程
    NSLog(@"xxxxx");
    
}


// 证明CAAnimation 的中间值计算 不是在主线程算的 而是在render server 进程计算的
// 即animation 提交后，中间值计算 ，渲染都会有render server 来处理了
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSLog(@"%@",[NSThread currentThread]);
    
    sleep(10);
    NSLog(@"yyyyyyyyy");
}

@end
