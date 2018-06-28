//
//  ZGEventChainController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/6/28.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGEventChainController.h"
#import "ZGEventChainView.h"
#import "ZGEventChainSubView.h"

@interface ZGEventChainController ()

@property (nonatomic, strong) ZGEventChainView *v1;
@property (nonatomic, strong) ZGEventChainSubView *v2;

@end

@implementation ZGEventChainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"事件链";
    
    [self setupViews];
}

- (void)setupViews
{
    _v1 = [[ZGEventChainView alloc] initWithFrame:CGRectMake(50, 100, 150, 150)];
    _v1.backgroundColor = [UIColor redColor];
    [self.view addSubview:_v1];
    
    _v2 = [[ZGEventChainSubView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    _v2.backgroundColor = [UIColor orangeColor];
    [_v1 addSubview:_v2];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"vc vc");
}


@end
