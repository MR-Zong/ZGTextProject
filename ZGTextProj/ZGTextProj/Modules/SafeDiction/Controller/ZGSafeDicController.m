//
//  ZGSafeDicController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/4/1.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGSafeDicController.h"
#import "ZGThreadSafeMutableDictionary.h"

@interface ZGSafeDicController ()

@end

@implementation ZGSafeDicController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"safe dictionary";
    
    
    /**
     测试发现，最多执行64次打印set: ，但无after set: ，需要仔细分析才能理解。
     
     造成原因：
     for语句的遍历非常的快，导致的结果是开辟的线程都是concurrentQueue 的线程，超过64GCD最大执行线程数时，所有的接下来线程都不会执行而进入排队状态（底层未必是线程状态），而set操作需要新的执行线程，无法申请，如果concurrentQueue 的线程有执行完毕的，后面排队的线程可以继续执行，问题在于concurrentQueue 的线程中get操作是同步操作，该同步操作依赖于WXThreadSafeMutableDictionary 内部队列的barrier_async 线程执行完毕，而barrier_async 线程在排队中，尚未到执行阶段，无法申请执行，导致死循环。
     
     如何验证上述原因？
     取消的sleep(1); 注释，调整sleep参数为0.6会发现，set操作可以执行部分，还是最后死锁，这是因为concurrentQueue 队列的线程产生的速度比较慢，因此部分barrier_async 线程申请到了执行，但是并没有把所有的barrier_async 线程执行完毕，最终还是到达最大GCD线程数64，导致后面的get方法仍然无法执行结束；将sleep参数改为1，则可以一直执行下去，因为concurrentQueue 队列的线程产生速度非常慢，barrier_async 线程有机会切换并执行，get的barrier_async 线程有机会切换并执行完毕，也导致了concurrentQueue 队列的线程本身能够执行完毕并释放，从而流动起来。
     */
    dispatch_queue_t gq = [self concurrentQueue];
    ZGThreadSafeMutableDictionary *d = [ZGThreadSafeMutableDictionary new];
    //    NSMutableDictionary *sd = [NSMutableDictionary new];
    for (int i = 1; i < NSUIntegerMax; i ++) {
        //        sleep(1);
        dispatch_async(gq, ^{
            NSLog(@"set:%d", i);
            [d setObject:@"1" forKey:@"1"];
            NSLog(@"after set:%d", i);
            
            NSLog(@"%d :%@", i, [d objectForKey:@"1"]);
            NSLog(@"get:%d", i);
        });
    }
    
    NSLog(@"finish");
}

- (dispatch_queue_t)serialQueue {
    static dispatch_queue_t queue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("test.serialQueue", DISPATCH_QUEUE_SERIAL);
    });
    
    return queue;
}

- (dispatch_queue_t)concurrentQueue {
    static dispatch_queue_t queue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("test.concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    });
    
    return queue;
}


@end
