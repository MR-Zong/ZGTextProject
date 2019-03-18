//
//  ZGShapeAnimationController.m
//  ZGTextProj
//
//  Created by ali on 2019/3/17.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGShapeAnimationController.h"
#import "ZGWaterWaveView.h"

@interface ZGShapeAnimationController ()

@property (nonatomic, strong) ZGWaterWaveView *waveView;
@property (nonatomic, strong) UIButton *btn;

@end

@implementation ZGShapeAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _waveView = [[ZGWaterWaveView alloc] initWithFrame:CGRectMake(50, 100, 200, 100)];
    [self.view addSubview:_waveView];
    [_waveView startWave];
    
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.backgroundColor = [UIColor redColor];
    _btn.frame = CGRectMake(50, 250, 60, 40);
    [_btn addTarget:self action:@selector(didBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_btn setTitle:@"switch" forState:UIControlStateNormal];
    [self.view addSubview:_btn];
}


#pragma mark - action
- (void)didBtn:(UIButton *)btn
{
    self.waveView.hidden = !self.waveView.hidden;
}

@end
