//
//  ZGShapeAnimationController.m
//  ZGTextProj
//
//  Created by ali on 2019/3/17.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGShapeAnimationController.h"
#import "ZGWaterWaveView.h"
#import "ZGPlayAnimationView.h"

@interface ZGShapeAnimationController ()

@property (nonatomic, strong) ZGWaterWaveView *waveView;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) ZGPlayAnimationView *circleAnimationView;

@end

@implementation ZGShapeAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self waveAnimation];
    [self circleAnimation];
}

#pragma mark - 波纹动画
- (void)waveAnimation
{
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

- (void)circleAnimation
{
    _circleAnimationView = [[ZGPlayAnimationView alloc] initWithFrame:CGRectMake(50, 100, 70, 70)];
    _circleAnimationView.radius1 = 40;
    _circleAnimationView.duration1 = 2;
    _circleAnimationView.radius2 = 39;
    _circleAnimationView.duration2 = 3;
    _circleAnimationView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_circleAnimationView];
    [_circleAnimationView startAnimation];
}


#pragma mark - action
- (void)didBtn:(UIButton *)btn
{
    self.waveView.hidden = !self.waveView.hidden;
}

@end
