//
//  ZGOperationQueueController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/4/1.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGOperationQueueController.h"

@interface ZGOperationQueueController ()

@end

@implementation ZGOperationQueueController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"NSOperationQueue";
    
    NSLog(@"navigationBar %f",self.navigationController.navigationBar.bounds.size.height);
    
    // 状态栏(statusbar)
//    NSLog(@"status width - %f", rectStatus.size.width); // 宽度
    NSLog(@"status height  %f",  [[UIApplication sharedApplication] statusBarFrame].size.height);  // 高度
    
    // tabBAr 高度
    
    
//    [self testOperationQueue];
    
    // NSOperationQueue测试：A任务完成后，等待状态的B任务是否会自动执行
    // 测试结果：NSOperationQueue相当完美！以后自己需要队列管理，都用NSOperationQueue
    [self testWaitAndContinue2];
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


@end
