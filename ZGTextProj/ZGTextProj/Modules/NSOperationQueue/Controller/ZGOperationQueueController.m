//
//  ZGOperationQueueController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/4/1.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGOperationQueueController.h"
#import "ZGMainOperation.h"
#import "ZGStartOperation.h"

@interface ZGOperationQueueController ()

@end

@implementation ZGOperationQueueController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"NSOperationQueue";
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"navigationBar %f",self.navigationController.navigationBar.bounds.size.height);
    
    // 状态栏(statusbar)
//    NSLog(@"status width - %f", rectStatus.size.width); // 宽度
    NSLog(@"status height  %f",  [[UIApplication sharedApplication] statusBarFrame].size.height);  // 高度
    
    // tabBAr 高度
    
    
//    [self testOperationQueue];
    
    // NSOperationQueue测试：A任务完成后，等待状态的B任务是否会自动执行
    // 测试结果：NSOperationQueue相当完美！以后自己需要队列管理，都用NSOperationQueue
//    [self testWaitAndContinue2];
    
    // NSOperationQueue测试： 但注意是测试自定义NSOperation 实现main方式
//    [self testMainOperationWaitAndContinue];
    
    // NSOperationQueue测试： 但注意是测试自定义NSOperation 实现start方式
//    [self testStartOperationWaitAndContinue];
    
    /** NSOperationQueue测试：maxConcurrentOperationCount 设置为0会怎样?
     * 答案如下：
     * maxConcurrentOperationCount 默认值是 -1，负数时，线程数量不限制
     * 实验证明：maxConcurrentOperationCount = 0 时，queue不会执行Operation
     * maxConcurrentOperationCount > 0 时，按设置值，限制最大线程数
     */
    [self testQueueMaxCount];
}

- (void)testOperation
{
    NSOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"op1 %@",[NSThread currentThread]);
    }];
    
    [op1 start];
}


- (void)testOperationQueue
{
    
    // 测试结果：NSOperationQueue 一定会开线程
    NSOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"op1 %@",[NSThread currentThread]);
        
        NSOperation *op11 = [NSBlockOperation blockOperationWithBlock:^{
            NSLog(@"op11 %@",[NSThread currentThread]);
        }];
        
        NSOperationQueue *queue1 = [[NSOperationQueue alloc] init];
        [queue1 addOperation:op11];

    }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:op1];
}

// NSOperationQueue测试：A任务完成后，等待状态的B任务是否会自动执行
- (void)testWaitAndContinue
{
    NSBlockOperation *bopA = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"bopA start");
        NSLog(@"thread %@",[NSThread currentThread]);
        sleep(15);
        NSLog(@"bopA end");
    }];


    NSBlockOperation *bopB = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"bopB start");
        NSLog(@"thread %@",[NSThread currentThread]);
        NSLog(@"bopB end");
    }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 1;
    [queue addOperation:bopA];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"add bopB");
        [queue addOperation:bopB];
    });
}

// NSOperationQueue测试：A,B任务其中任何一个任务完成后，等待状态的C任务是否会自动执行
- (void)testWaitAndContinue2
{
    NSBlockOperation *bopA = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"bopA start");
        NSLog(@"thread %@",[NSThread currentThread]);
        sleep(15);
        NSLog(@"bopA end");
    }];
    
    
    NSBlockOperation *bopB = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"bopB start");
        NSLog(@"thread %@",[NSThread currentThread]);
        sleep(25);
        NSLog(@"bopB end");
    }];

    NSBlockOperation *bopC = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"bopC start");
        NSLog(@"thread %@",[NSThread currentThread]);
        NSLog(@"bopC end");
    }];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 2;
    [queue addOperation:bopA];
    [queue addOperation:bopB];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"add bopC");
        [queue addOperation:bopC];
    });
}

#pragma mark - 自定义NSOperation main
// NSOperationQueue测试：A任务完成后，等待状态的B任务是否会自动执行
- (void)testMainOperationWaitAndContinue
{
    ZGMainOperation *bopA = [[ZGMainOperation alloc] init];
    bopA.fullName = @"bopA";
    
    ZGMainOperation *bopB = [[ZGMainOperation alloc] init];
    bopB.fullName = @"bopB";
    
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 1;
    [queue addOperation:bopA];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"add bopB");
        [queue addOperation:bopB];
    });
}

// NSOperationQueue测试：A,B任务其中任何一个任务完成后，等待状态的C任务是否会自动执行
- (void)testMainOperationWaitAndContinue2
{
    ZGMainOperation *bopA = [[ZGMainOperation alloc] init];
    bopA.fullName = @"bopA";
    
    ZGMainOperation *bopB = [[ZGMainOperation alloc] init];
    bopB.fullName = @"bopB";
    
    ZGMainOperation *bopC = [[ZGMainOperation alloc] init];
    bopC.fullName = @"bopC";
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 2;
    [queue addOperation:bopA];
    [queue addOperation:bopB];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"add bopC");
        [queue addOperation:bopC];
    });
}

#pragma mark - 自定义NSOperation start
// NSOperationQueue测试：A任务完成后，等待状态的B任务是否会自动执行
- (void)testStartOperationWaitAndContinue
{
    ZGStartOperation *bopA = [[ZGStartOperation alloc] init];
    bopA.fullName = @"bopA";
    
    ZGStartOperation *bopB = [[ZGStartOperation alloc] init];
    bopB.fullName = @"bopB";
    
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 1;
    [queue addOperation:bopA];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"add bopB");
        [queue addOperation:bopB];
    });
}

// NSOperationQueue测试：A,B任务其中任何一个任务完成后，等待状态的C任务是否会自动执行
- (void)testStartOperationWaitAndContinue2
{
    ZGStartOperation *bopA = [[ZGStartOperation alloc] init];
    bopA.fullName = @"bopA";
    
    ZGStartOperation *bopB = [[ZGStartOperation alloc] init];
    bopB.fullName = @"bopB";
    
    ZGStartOperation *bopC = [[ZGStartOperation alloc] init];
    bopC.fullName = @"bopC";
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 2;
    [queue addOperation:bopA];
    [queue addOperation:bopB];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"add bopC");
        [queue addOperation:bopC];
    });
}

#pragma mark - testQueueMaxCount
- (void)testQueueMaxCount
{
    /** NSOperationQueue测试：maxConcurrentOperationCount 设置为0会怎样?
     * 答案如下：
     * maxConcurrentOperationCount 默认值是 -1，负数时，线程数量不限制
     * 实验证明：maxConcurrentOperationCount = 0 时，queue不会执行Operation
     * maxConcurrentOperationCount > 0 时，按设置值，限制最大线程数
     */
    NSOperationQueue *queue =[[NSOperationQueue alloc] init];
//    queue.maxConcurrentOperationCount = -1;
    NSLog(@"maxConcurrentOperationCount 默认值: %zd",queue.maxConcurrentOperationCount);
    
    NSLog(@"maxConcurrentOperationCount 测试");
    NSBlockOperation *bo = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"bo thread %@",[NSThread currentThread]);
        NSLog(@"maxConcurrentOperationCount = 0，会开辟线程吗？");
    }];
    
    NSBlockOperation *bo1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"bo1 thread %@",[NSThread currentThread]);
    }];
    
    [queue addOperation:bo];
    [queue addOperation:bo1];
}


@end
