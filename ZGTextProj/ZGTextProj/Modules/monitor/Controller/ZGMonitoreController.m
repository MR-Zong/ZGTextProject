//
//  ZGMonitoreController.m
//  ZGTextProj
//
//  Created by XuZongGen on 2019/8/13.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGMonitoreController.h"
#import "ZGMonitorManager.h"

@interface ZGMonitoreController ()

@property (nonatomic, strong) ZGMonitorManager *monitor;
@property (nonatomic, strong) UIButton *btn;

@end

@implementation ZGMonitoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _monitor = [ZGMonitorManager new];
    [_monitor startWatchAnr];
    
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn setTitle:@"rl卡顿测试" forState:UIControlStateNormal];
    _btn.titleLabel.font = [UIFont systemFontOfSize:16];
    _btn.backgroundColor = [UIColor blueColor];
    _btn.frame = CGRectMake(50, 200, 140, 40);
    [_btn addTarget:self action:@selector(didBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
}

- (void)didBtn:(UIButton *)btn
{
//    sleep(1);
    NSInteger count = 10000 * 10;
    for (int i=0; i<count; i++) {
        NSLog(@"zong do");
    }
}


@end
