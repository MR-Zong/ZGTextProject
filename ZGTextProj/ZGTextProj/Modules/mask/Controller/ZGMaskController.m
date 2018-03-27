//
//  ZGMaskController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/7/28.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import "ZGMaskController.h"

@interface ZGMaskController ()

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation ZGMaskController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Mask";
    
    [self setupViews];
}


- (void)setupViews
{
    _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 200, 40)];
    _textLabel.text = @"你又从西厢过，十多年后才有盼头";
    _textLabel.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_textLabel];
    
    
    [self createFadeRightMask];
    CABasicAnimation *basicAnimation = [CABasicAnimation animation];
    basicAnimation.keyPath = @"transform.translation.x";
    basicAnimation.fromValue = @(0);
    basicAnimation.toValue = @(_textLabel.bounds.size.width);
    basicAnimation.duration = 4.0;
    basicAnimation.repeatCount = LONG_MAX;
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.fillMode = kCAFillModeForwards;
    [_textLabel.layer.mask addAnimation:basicAnimation forKey:nil];
    
    
}



- (void)createFadeRightMask{
//    [self.AxcfrontLabel.layer removeAllAnimations];
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = self.textLabel.bounds;
    layer.colors = @[(id)[UIColor clearColor],(id)[UIColor redColor].CGColor,(id)[UIColor blackColor].CGColor,(id)[UIColor clearColor].CGColor];
    layer.locations = @[@(0.01),@(0.1),@(0.9),@(0.99)];
    
    self.textLabel.layer.mask = layer;
}





@end
