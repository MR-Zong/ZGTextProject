//
//  ZGNotificationControllerViewController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/2/1.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGNotificationController.h"
#import "ZGNFNotificationCenter.h"
#import "ZGNFObserverA.h"
#import "ZGNFObserverB.h"

@interface ZGNotificationController ()

@property (nonatomic, strong) ZGNFNotificationCenter *center;
@property (nonatomic, strong) ZGNFObserverA *a;
@property (nonatomic, strong) ZGNFObserverB *b;

@end

@implementation ZGNotificationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Notification";
    
    /**
     13， 通知 是异步还是同步？会自己开线程吗?。（通知的 实现原理）
     1，  经过测试 通知默认是同步的！！！不会自己开线程！！
     2，post通知后，会挨个一次 执行 监听通知的对象的selector ，顺序是 先进先出，就是先监听的对象的selector 先执行
     3，在哪个线程 post notification  就在哪个线程 执行 监听对象的 selector（第2点依然适用）
     4，千万注意 Post notification 和 监听对象的selector是同一个线程的 （多写一次以重视）
     */
    [self testNotification];
}

- (void)testNotification
{
    
    _a = [[ZGNFObserverA alloc] init];
    
    _b = [[ZGNFObserverB alloc] init];
    
    
    _center = [[ZGNFNotificationCenter alloc] init];
    [_center postNotification:@"zongNotification"];
    NSLog(@"post ZongNotification");
}


@end
