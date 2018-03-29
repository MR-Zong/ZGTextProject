//
//  ZGCrashController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/3/28.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGCrashController.h"

@interface ZGCrashController ()

@end

@implementation ZGCrashController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSProxy
    
    NSArray *arry=[NSArray arrayWithObject:@"sss"];
    NSLog(@"%@",[arry objectAtIndex:1]);

}


@end
