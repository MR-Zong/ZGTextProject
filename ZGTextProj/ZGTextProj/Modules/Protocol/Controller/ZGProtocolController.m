//
//  ZGProtocolController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/1/5.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGProtocolController.h"
#import "ZGPLman.h"
#import "ZGPLzong.h"

@interface ZGProtocolController ()

@end

@implementation ZGProtocolController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"协议关联测试";

    [self test];
}

- (void)testBool
{
    NSLog(@"TARGET_OS_IPHONE == %zd",TARGET_OS_IPHONE);
    BOOL a = 256;
    if (a == YES) {
        NSLog(@"a == yes");
    }else {
        NSLog(@"a ==  NO");
    }
    NSLog(@"%zd",a);
    
    bool b = 10;
    if (b == YES) {
        NSLog(@"b == yes");
    }else {
        NSLog(@"b ==  NO");
    }
    NSLog(@"%zd",b);
}

- (void)test
{
    ZGPLman *man = [[ZGPLman alloc] init];
    [man eat];
    ZGPLzong *z = [[ZGPLzong alloc] init];
    [z eat];
}


@end
