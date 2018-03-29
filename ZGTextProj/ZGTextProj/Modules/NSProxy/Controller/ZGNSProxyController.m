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
    
    /* NSProxy 用途还可以实现多重继承 */
    
    
    // 测试 NSProxy 解决 NSTimer 的循环引用
    [self testProxy];
}

// 测试 NSTimer 导致的循环引用
- (void)testCircule
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(doTimer:) userInfo:nil repeats:YES];
    
}

// 测试 ios10 之后 用block的方法 不会引起 NSTimer循环引用
- (void)testIos10
{
    // 此方法iOS10以上版本可用 因为 并没有引用 self
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"yyyy");
    }];
    
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
