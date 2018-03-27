//
//  ZGTestBlockViewController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/8/1.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import "ZGTestBlockViewController.h"

@interface ZGTestBlockViewController ()


@end

@implementation ZGTestBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    int base = 100;
    base += 200;
    __weak long (^sum)(int a,int b)  = ^ long (int a, int b) {
        // base++; 编译错误，只读
        return base + a + b;
    };
    base = 0;
    NSLog(@"%@",^ long (int a, int b) {
        // base++; 编译错误，只读
//        return base + a + b;
        return a;
    });
    NSLog(@"%@",sum);
    NSLog(@"%ld\n",sum(1,2));
    
    
    
    

    
}




@end
