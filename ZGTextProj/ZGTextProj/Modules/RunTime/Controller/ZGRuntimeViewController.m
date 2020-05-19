//
//  ZGRuntimeViewController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2020/5/17.
//  Copyright © 2020 XuZonggen. All rights reserved.
//

#import "ZGRuntimeViewController.h"
#import "ZGRtTModel.h"

@interface ZGRuntimeViewController ()

@end

@implementation ZGRuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Runtime";
    
    ZGRtTModel *rm = [ZGRtTModel new];
    [rm performSelector:NSSelectorFromString(@"zong:") withObject:@"gen"];
    
     [[NSNotificationCenter defaultCenter] postNotificationName:@"zongNote" object:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"zongNote" object:nil];
    NSLog(@"post");
}


@end
