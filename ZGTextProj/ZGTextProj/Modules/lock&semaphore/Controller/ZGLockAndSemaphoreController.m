//
//  ZGLockAndSemaphoreController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/7/28.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGLockAndSemaphoreController.h"
#import "ZGBenchmarkProtocol.h"

@interface ZGLockAndSemaphoreController ()

@property (nonatomic, strong) NSLock *lock;

@end

@implementation ZGLockAndSemaphoreController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /**
     * 用信号量来实现两个线程同步
     */
//    [self testSemaphore];
    
    /**
     * 用lock 来实现两个线程同步
     */
//    [self testLock];
    
    /**
     * 锁 对于函数递归
     */
//    _lock = [[NSLock alloc] init];
//    [self testLockFuntion];
    
    /**
     * benchmark
     */
//    [self testbenchmark];

    /**
     * @synchronize
     */
//        [self testSynchronize];
    
    
    /**
     * 测试 dispatch_semaphore_wait(signal, overTime);
     */
    [self testSemaphoreWait];
    
    
}

- (void)testSynchronize
{
    // 居然可以嵌套！！
    @synchronized (self) {
        NSLog(@"@synchronized aaaaaa");
        @synchronized (self) {
            NSLog(@"@synchronized bbbb");
        }
    }
}

- (void)testbenchmark
{
    dispatch_time_t runTime = dispatch_benchmark(100, ^{
        NSLog(@"AAAA");
    });
    
    NSLog(@"runTime %llu",runTime);
}

- (void)testLockFuntion
{
    [self.lock lock];
    NSLog(@"AAAAAA");
    sleep(3);
    NSLog(@"BBBBBB");
    
    NSLog(@"self %@",self);
    
    
    /**
     * 千万不能，没解锁时候就递归
     * 否则会导致 死锁  可以用递归锁
     */
    [self testLockFuntion];
    [self.lock unlock];
    
}

#pragma mark - semaphore
- (void)testSemaphore
{
    /** 初始信号 设置为0 比设置为1好
    * 0 不用先wait ,而且后面的wait后 不用signal配对也没问题
    * 1 一定要先wait 而且后面的wait后 一定要signal 来配对
    */
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    dispatch_queue_t que = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    NSLog(@"aaaaaaa");
    //    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"zzzzzzzz");
    dispatch_async(que, ^{
        NSLog(@"start xxx");
        sleep(3);
        NSLog(@"end xxx");
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"yyyyyy");
    //    dispatch_semaphore_signal(semaphore);

}

- (void)testSemaphoreWait
{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
//    long k = dispatch_semaphore_signal(semaphore);
//    NSLog(@"k00 %ld",k);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"option 1");
        dispatch_time_t overTime = dispatch_time(DISPATCH_TIME_NOW, 1*1000*1000*1000); //超时1秒
        long r = dispatch_semaphore_wait(semaphore, overTime);
        NSLog(@"r1 %ld",r);
        sleep(10);
        NSLog(@"option 1 do something...");
        long k = dispatch_semaphore_signal(semaphore);
        NSLog(@"k1 %ld",k);
    });

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(3);
        NSLog(@"option 2");
        dispatch_time_t overTime = dispatch_time(DISPATCH_TIME_NOW, 1*1000*1000*1000); //超时1秒
        long r = dispatch_semaphore_wait(semaphore, overTime);
        NSLog(@"r2 %ld",r);
        NSLog(@"option 2 do something...");
        long k = dispatch_semaphore_signal(semaphore);
        NSLog(@"k2 %ld",k);
        long r2 = dispatch_semaphore_wait(semaphore, overTime);
        NSLog(@"r22 %ld",r2);
    });
}


- (void)testLock
{
    /**
     * lock 要 lock 与 unlock 要配对使用
     */
    NSLock *lock = [[NSLock alloc] init];
    
    [lock lock];
    dispatch_queue_t que = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    NSLog(@"aaaaaaa");
    dispatch_async(que, ^{
        NSLog(@"start xxx");
        sleep(3);
        NSLog(@"end xxx");
        
        [lock unlock];
    });
    
    [lock lock];
    NSLog(@"yyyyyy");
    [lock unlock];
    //    dispatch_semaphore_signal(semaphore);
    
}

@end
