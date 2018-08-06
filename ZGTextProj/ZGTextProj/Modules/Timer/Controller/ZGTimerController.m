//
//  ZGTimerController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/8/6.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGTimerController.h"
#import "ZGTimerProcess.h"

@interface ZGTimerController ()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) ZGTimerProcess *timerProcess;

@end

@implementation ZGTimerController

- (void)dealloc
{
    NSLog(@"time controller dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /**
     * 测试timer 对self的强引用，是否导致内存泄露
     */
//    [self testTimer];
    
    /**
     * 测试blockTimer 解决对self的强引用
     */
    [self testBlockTimer];
    
}

- (void)testTimer
{
    /**
     * 证明 timer 对self 强引用 ，用weakSelf也是解决不了的
     * 解决方法，可以用 ZGBlockTimer
     */
    __weak typeof(self) weakSelf = self;
    _timer = [NSTimer scheduledTimerWithTimeInterval:5 target:weakSelf selector:@selector(didTimer) userInfo:nil repeats:NO];
}

- (void)testBlockTimer
{
    _timerProcess = [ZGTimerProcess timerProcessWithTarget:self selector:@selector(didTimer)];
    _timer = [NSTimer scheduledTimerWithTimeInterval:5 target:_timerProcess selector:ZGTimerProcessDefaultSel userInfo:nil repeats:NO];
}

- (void)didTimer
{
    NSLog(@"didTimer");
}

@end
