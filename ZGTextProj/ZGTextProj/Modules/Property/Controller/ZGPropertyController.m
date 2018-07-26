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
    
    /** 测试 automic
     */
    [self testAutomic];
}

- (void)testProperty
{
    ZGProModelA *a = [[ZGProModelA alloc] init];
    a.name = @"中国";
    [a printName];
    
    ZGProModelB *b = [[ZGProModelB alloc] init];
    b.name = @"日本";
}

- (void)testAutomic
{
    ZGPAUTModelA *a = [[ZGPAUTModelA alloc] init];


    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);

    dispatch_async(queue, ^{

    });
}


@end
