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
