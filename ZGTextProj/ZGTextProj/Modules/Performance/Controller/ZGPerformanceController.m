//
//  ZGPerformanceController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/3/22.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGPerformanceController.h"
#import "ZGFPSProbeView.h"

@interface ZGPerformanceController ()

@property (nonatomic, strong) ZGFPSProbeView *fpsProbeView;

@end

@implementation ZGPerformanceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"iOS性能参数检测";
    
    _fpsProbeView = [[ZGFPSProbeView alloc] initWithFrame:CGRectMake(50, 150, 100, 40)];
    [self.view addSubview:_fpsProbeView];
}


@end
