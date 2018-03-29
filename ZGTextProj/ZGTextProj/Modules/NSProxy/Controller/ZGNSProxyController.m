//
//  ZGNSProxyController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/3/29.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGNSProxyController.h"
#import "ZGProxy.h"

@interface ZGNSProxyController ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ZGNSProxyController

- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
    NSLog(@"dealloc");
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"NSProxy应用";
    [self testProxy];
}

// 测试 NSTimer 导致的循环引用
- (void)testCircule
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(doTimer:) userInfo:nil repeats:YES];
    
}

// 测试 NSProxy 解决 NSTimer 的循环引用
- (void)testProxy
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:[ZGProxy proxyWithTarget:self] selector:@selector(doTimer:) userInfo:nil repeats:YES];
}

- (void)doTimer:(NSTimer *)timer
{
    NSLog(@"xxx");
}


@end
