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
     ;
//    NSLog(@"status width - %f", rectStatus.size.width); // 宽度
    NSLog(@"status height  %f",  [[UIApplication sharedApplication] statusBarFrame].size.height);  // 高度
    
    // tabBAr 高度
    
    
    [self testOperationQueue];
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


@end
