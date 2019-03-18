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

@end

@implementation ZGShapeAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _waveView = [[ZGWaterWaveView alloc] initWithFrame:CGRectMake(50, 100, 200, 100)];
    [self.view addSubview:_waveView];
    [_waveView startWave];
}

@end
