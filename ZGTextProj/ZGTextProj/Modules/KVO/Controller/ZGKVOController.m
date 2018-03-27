//
//  ZGKVOController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/2/1.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGKVOController.h"
#import "ZGKVODataModel.h"
#import "ZGKVOObserverA.h"
#import "ZGKVOObserverB.h"

@interface ZGKVOController ()

@property (nonatomic, strong) ZGKVODataModel *dataModel;
@property (nonatomic, strong) ZGKVOObserverA *a;
@property (nonatomic, strong) ZGKVOObserverB *b;

@end

@implementation ZGKVOController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"KVO";
    
    /**
     1，  经过测试 KVO 和通知一样 默认是同步的！！！  不会自己开线程！！
     2，changeValue后，会挨个一次 执行 监听通知的对象的selector ，顺序是 先进后出（与通知相反），就是先监听的对象的selector  反而会后面执行
     3，在哪个线程 changeValue  就在哪个线程 执行 监听对象的 selector（第2点依然适用）
     4，千万注意 changeValue 和 监听对象的selector是同一个线程的 （多写一次以重视）
     */
    [self testKVO];
    
}

- (void)testKVO
{
    _dataModel = [[ZGKVODataModel alloc] init];
    
    _a = [[ZGKVOObserverA alloc] init];
    [_a kvoObject:_dataModel];
    
    _b = [[ZGKVOObserverB alloc] init];
    [_b kvoObject:_dataModel];
    
    
    [_dataModel changeValue];
    NSLog(@"KVO changeValue");
}


@end
