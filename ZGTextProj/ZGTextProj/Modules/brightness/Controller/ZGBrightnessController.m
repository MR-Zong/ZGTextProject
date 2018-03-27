//
//  ZGBrightnessController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/1/6.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGBrightnessController.h"
#import "ZGBrightManger.h"

@interface ZGBrightnessController ()

@property (nonatomic,strong) ZGBrightManger *brightM;

@end

@implementation ZGBrightnessController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"环境光照";
    
    [self test];
}

- (void)test
{
    [[ZGBrightManger shareInstance] getBrightnessWithCompleteBlock:^(float brightness) {
        NSLog(@"brightness == %f",brightness);
    }];
}

@end
