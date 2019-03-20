//
//  ZGPlayAnimationView.m
//  QianEr
//
//  Created by ali on 2019/3/19.
//  Copyright © 2019 com.alibaba-inc. All rights reserved.
//

#import "ZGPlayAnimationView.h"

@interface ZGPlayAnimationView ()

@property (nonatomic, strong) CALayer *circle1;
@property (nonatomic, strong) CALayer *circle2;

@end

@implementation ZGPlayAnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.hidden = YES;
        _radius1 = 20;
        _radius2 = 10;
        _duration1 = 10;
        _duration2 = 5;
        
        _circle1 = [CALayer layer];
        _circle1.backgroundColor = [UIColor redColor].CGColor;
        [self.layer addSublayer:_circle1];
        
        _circle2 = [CALayer layer];
        _circle2.backgroundColor = [UIColor greenColor].CGColor;
        [self.layer addSublayer:_circle2];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    self.circle1.frame = CGRectMake(0, 0, 2*_radius1, 2*_radius1);
    _circle1.cornerRadius = _radius1;
    _circle1.anchorPoint = CGPointMake(0.5, 0.5);
    _circle1.masksToBounds = YES;

    
    CGFloat diameter = 2*_radius2;
    self.circle2.frame = CGRectMake(self.bounds.size.width-diameter, self.bounds.size.height-diameter, diameter, diameter);
    _circle2.cornerRadius = _radius2;
    _circle2.anchorPoint = CGPointMake(0.5, 0.5);
    _circle2.masksToBounds = YES;
    
}

#pragma mark - - - -
- (void)animationCircleWithLayer:(CALayer *)layer radius:(CGFloat)radius duration:(CGFloat)duration
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPoint circleCenter = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
    CGFloat resultRadius = 1.41421 *(self.bounds.size.width/2.0 - radius);
    CGPathAddArc(path, NULL, circleCenter.x, circleCenter.y, resultRadius, 0,M_PI * 2, 1);
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path;
    CGPathRelease(path);
    animation.duration = duration;
    animation.repeatCount = CGFLOAT_MAX;
    animation.autoreverses = NO;
    animation.rotationMode =kCAAnimationRotateAuto;
    animation.fillMode =kCAFillModeForwards;
    [layer addAnimation:animation forKey:nil];
}

#pragma mark - - - -
- (void)startAnimation
{
    self.hidden = NO;
    [self animationCircleWithLayer:self.circle1 radius:self.radius1 duration:self.duration1];
    [self animationCircleWithLayer:self.circle2 radius:self.radius2 duration:self.duration2];
}

- (void)stopAnimation
{
    self.hidden = YES;
    [self.circle1 removeAllAnimations];
    [self.circle2 removeAllAnimations];
}

@end
