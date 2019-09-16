//
//  ZGC++ViewController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2019/8/24.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGCPPViewController.h"


@interface ZGCPPViewController ()

@end

@implementation ZGCPPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    /**
     * 理解 __has_include 的作用
     * 此宏传入一个你想引入文件的名称作为参数，如果该文件能够被引入则返回1，否则返回0。
     * 本质是检测到某个文件,是否在工程中被包含（注意是工程，在工程中说明可以引用该文件）
     */
#if __has_include("xxx.h")
    NSLog(@"能包含");
#else
    NSLog(@"不能包含");
#endif
    
    [self testSwitch];
}

- (void)testSwitch
{
    int a = 9;
    switch (a) {
        case 1:
            NSLog(@"1");
            break;
            
        default:
            NSLog(@"default");
            break;
    }
    
    // int 类型的内存大小
    NSLog(@"sizeof(int) %zd",sizeof(int));
    NSLog(@"sizeof(int8_t) %zd",sizeof(int8_t));
    NSLog(@"sizeof(int16_t) %zd",sizeof(int16_t));
    NSLog(@"sizeof(int32_t) %zd",sizeof(int32_t));
    NSLog(@"sizeof(int64_t) %zd",sizeof(int64_t));
}


@end
