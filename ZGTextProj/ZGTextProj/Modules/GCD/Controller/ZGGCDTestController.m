//
//  ZGGCDTestController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/3/3.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGGCDTestController.h"
#import <libkern/OSAtomic.h>

@interface ZGGCDTestController ()
@property (nonatomic,copy) void(^block)(void);

@property (nonatomic, strong) dispatch_source_t sourceTimer;

@end

@implementation ZGGCDTestController

- (void)dealloc
{
    NSLog(@"dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"GCD";
    
    /**
     * 测试 NSDictionary 的allkeys 是否随机
     */
//    [self testAllKeys];
    
    
//    [self testBlock];
    
//    [self testDispatchQueue];
//    [self testSyncAndAsync];
//    [self testDispatch_group_enter];
    
    
    /**
     * dispatch_source
     */
    [self testSource];
    
    /**
     * 怎么实用自旋锁
     */
    [self testSpinLock];
}

- (void)testSpinLock
{
    static OSSpinLock lock = OS_SPINLOCK_INIT;
    OSSpinLockLock(&lock);
    NSLog(@"xxxx");
    OSSpinLockUnlock(&lock);
}

- (void)testSource
{
    _sourceTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, DISPATCH_TARGET_QUEUE_DEFAULT);
    dispatch_source_set_event_handler(_sourceTimer, ^{
        NSLog(@"source Timer");
    });
    dispatch_source_set_timer(_sourceTimer, DISPATCH_TIME_NOW, 5ull * NSEC_PER_SEC, 100ull * NSEC_PER_MSEC);
    dispatch_resume(_sourceTimer);
}

- (void)testBlock
{
    self.block = ^(){
        NSLog(@"%@",self);
    };

    self.block();
    self.block = nil;
}

- (void)testAllKeys
{
    // 测试 allKeys 是否是有序的？
    NSDictionary *dic = @{@"key1":@"zong",
                          @"key2":@"gen",
                          @"key3":@"xu",
                          };
    
    NSArray *allkeys = dic.allKeys;
    for (int i=0; i<allkeys.count; i++) {
        NSLog(@"%@",allkeys[i]);
    }
}

// 测试 queue 对在 多个线程会不会出问题
- (void)testDispatchQueue
{
//    dispatch_queue_t cQueue = dispatch_queue_create("testConcurrentQ", DISPATCH_QUEUE_CONCURRENT);
//
//    dispatch_async(cQueue, ^{
//
//        NSLog(@"1--%@",[NSThread currentThread]);
//        dispatch_async(cQueue, ^{
//            NSLog(@"11--%@",[NSThread currentThread]);
//        });
//    });
//
//    dispatch_async(cQueue, ^{
//
//        NSLog(@"2--%@",[NSThread currentThread]);
//        dispatch_async(cQueue, ^{
//            NSLog(@"22--%@",[NSThread currentThread]);
//        });
//    });

    
    
    
    
    // 串行队列测试 一个串行队列 被不同线程使用会怎样
//    dispatch_queue_t sQueue = dispatch_queue_create("testSerialQ", NULL);
//    dispatch_queue_t sQueue2 = dispatch_queue_create("testSerialQ2", NULL);
//
//    dispatch_async(sQueue, ^{
//
//        NSLog(@"7--%@",[NSThread currentThread]);
//        dispatch_async(sQueue, ^{
//            NSLog(@"77--%@",[NSThread currentThread]);
//        });
//    });
//
//    dispatch_async(sQueue2, ^{
//
//        NSLog(@"8--%@",[NSThread currentThread]);
////        sleep(20); // 等待7 和 77 那条线程销毁
//        dispatch_async(sQueue, ^{
//            NSLog(@"88--%@",[NSThread currentThread]);
//        });
//    });

//    dispatch_async(sQueue, ^{
//
//        NSLog(@"9--%@",[NSThread currentThread]);
//        dispatch_async(sQueue, ^{
//            NSLog(@"99--%@",[NSThread currentThread]);
//        });
//    });
    
    
    
    
    
    
//    // 串行队列测试 一个串行队列 同时，同步，异步调用会怎样
//    dispatch_queue_t sQueue = dispatch_queue_create("testSerialQ", NULL);
////    dispatch_queue_t sQueue2 = dispatch_queue_create("testSerialQ2", NULL);
//
//    dispatch_async(sQueue, ^{
//
//        NSLog(@"7--%@",[NSThread currentThread]);
//        sleep(10);
////        dispatch_async(sQueue, ^{
////            NSLog(@"77--%@",[NSThread currentThread]);
////        });
//    });
//
//    dispatch_sync(sQueue, ^{
//
//        NSLog(@"8--%@",[NSThread currentThread]);
//        //        sleep(20); // 等待7 和 77 那条线程销毁
//        dispatch_async(sQueue, ^{
//            NSLog(@"88--%@",[NSThread currentThread]);
//        });
//    });
    
    
    
    
    
    
    // dispatch 传入什么队列，块就在那个队列执行
    dispatch_queue_t sQueue = dispatch_queue_create("testSerialQ", DISPATCH_QUEUE_CONCURRENT);
    //    dispatch_queue_t sQueue2 = dispatch_queue_create("testSerialQ2", NULL);
    
    dispatch_sync(sQueue, ^{
        
        NSLog(@"7--%@",[NSThread currentThread]);
        if(dispatch_get_current_queue()==sQueue)
        {
            NSLog(@"ssssssss");
        }
//        sleep(10);
    });
    
    
    
    
}

// 测试 sync 并行队列 会怎样
- (void)testSyncAndAsync
{
    dispatch_queue_t currentQueue = dispatch_queue_create("com.zong.concurrent1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(currentQueue, ^{
        NSLog(@"block1  %@",[NSThread currentThread]);
    });

    dispatch_sync(currentQueue, ^{
        NSLog(@"block2  %@",[NSThread currentThread]);
    });


    dispatch_sync(currentQueue, ^{
        NSLog(@"block3  %@",[NSThread currentThread]);
    });

    // 使用全局并发队列 测试
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"blockGlobal1  %@",[NSThread currentThread]);
    });
    
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"blockGlobal2  %@",[NSThread currentThread]);
    });
    
    
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"blockGlobal3  %@",[NSThread currentThread]);
    });
    
    // 结论：dispatch_sync  即使是传并发队列，也不会开新线程，而是在当前线程串行执行

}

// 测试 dispatch_group
- (void)testDispatch_group_enter
{
    
    
    dispatch_group_t group = dispatch_group_create();
    
    
    
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(2);
        NSLog(@"AA");
        dispatch_group_leave(group);
        NSLog(@"group_leave");
    });
    
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(3);
        NSLog(@"BB");
        dispatch_group_leave(group);
        NSLog(@"group_leave");
    });
    
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(1);
        NSLog(@"CC");
        //        dispatch_group_leave(group);
        //        NSLog(@"group_leave");
    });
    
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"group over!");
    });
}

@end
