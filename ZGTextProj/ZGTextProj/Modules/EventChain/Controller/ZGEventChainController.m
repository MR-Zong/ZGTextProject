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
#import "ZGMemoryWebView.h"

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
    
    // 测试webView 内存释放
//    ZGMemoryWebView *webView = [[ZGMemoryWebView alloc] initWithFrame:self.view.bounds];
//    webView.backgroundColor = [UIColor redColor];
//    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
//    [self.view addSubview:webView];
    
    // 事件链 测试
    [self setupViews];
}

- (void)setupViews
{
    _v1 = [[ZGEventChainView alloc] initWithFrame:CGRectMake(50, 100, 150, 150)];
    _v1.backgroundColor = [UIColor redColor];
    [self.view addSubview:_v1];
    
    
    _v2 = [[ZGEventChainSubView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapV1:)];
//    tapGes.delaysTouchesBegan = YES;
    [_v2 addGestureRecognizer:tapGes];
    _v2.backgroundColor = [UIColor orangeColor];
    [_v1 addSubview:_v2];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"vc vc");
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touch cancel");
}

#pragma mark -
- (void)didTapV1:(UITapGestureRecognizer *)tap
{
    NSLog(@"tap v1");
}

@end
