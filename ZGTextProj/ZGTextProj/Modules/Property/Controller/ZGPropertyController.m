//
//  ZGPropertyController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/7/19.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGPropertyController.h"
#import "ZGProModelA.h"
#import "ZGProModelB.h"
#import "ZGPAUTModelA.h"

@interface ZGPropertyController ()

@end

@implementation ZGPropertyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"property";
    
    /** 测试 @synthesize
     */
//    [self testProperty];
    
    /** 测试 automic,，原子性 只能是对get set 方法的原子性
     * 不能对直接访问实例成员变量，或者 改变成员变量的属性原子性
     */
//    [self testAutomic];
    
    
    /**
     * 测试通知
     */
//    [self testNotify];
    
    /**
     * 测试runloop
     * 结论：实践证明 runloop唤醒后 一定会先执行完 睡眠前未执行完的任务，然后再执行唤醒runloop的
     * timer dispatch_asyn source1 的对应回调
     */
    [self testRunLoop];
    
}

- (void)testProperty
{
    ZGProModelA *a = [[ZGProModelA alloc] init];
    a.name = @"中国";
    a.finished = YES;
    [a printName];
    
    ZGProModelB *b = [[ZGProModelB alloc] init];
    b.name = @"日本";
    b.finished = YES;
    NSLog(@"b.finished %zd",b.finished);
}

- (void)testAutomic
{
    ZGPAUTModelA *a = [[ZGPAUTModelA alloc] init];


    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);

    dispatch_async(queue, ^{

    });
}

#pragma mark - test notify
- (void)testNotify
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didNote) name:@"abc" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didNote) name:@"abc" object:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"abc" object:nil];
}

- (void)didNote
{
    NSLog(@"didNote");
}


#pragma mark - testRunLoop
- (void)testRunLoop
{
    [self rlTimer];
    
    [self afterRlTimer];
}

- (void)rlTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(didTimer) userInfo:nil repeats:NO];
    NSTimer *timer1 = [NSTimer scheduledTimerWithTimeInterval:7 target:self selector:@selector(didTimer1) userInfo:nil repeats:NO];
    [self testRlB];
    [self testRlC];
    //    [self testRlC];[self testRlC];[self testRlC];[self testRlC];[self testRlC];

}

- (void)afterRlTimer
{
    NSLog(@"afterRlTimer");
}

- (void)didTimer
{
    NSLog(@"timerA");
}
- (void)didTimer1
{
    NSLog(@"timerA111");
}

- (void)testRlB
{
    NSLog(@"testRlB");
    [NSThread sleepForTimeInterval:10];
}

- (void)testRlC
{
    NSLog(@"testRlC");
    [NSThread sleepForTimeInterval:6];
}

@end
