//
//  ZGWaterWaveView.m
//  ZGTextProj
//
//  Created by ali on 2019/3/17.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGWaterWaveView.h"

@interface ZGWaterWaveView ()

@property (nonatomic, strong) CADisplayLink *waveDisplaylink;
@property (nonatomic, strong) CAShapeLayer  *firstWaveLayer;
//@property (nonatomic, strong) CAShapeLayer  *secondWaveLayer;

@end


@implementation ZGWaterWaveView {
    CGFloat waveAmplitude;  // 波纹振幅
    CGFloat waveCycle;      // 波纹周期
    CGFloat waveSpeed;      // 波纹速度
    CGFloat waveGrowth;     // 波纹上升速度
    
    CGFloat waterWaveHeight;
    CGFloat waterWaveWidth;
    CGFloat offsetX;           // 波浪x位移
    CGFloat currentWavePointY; // 当前波浪上市高度Y（高度从大到小 坐标系向下增长）
    
    float variable;     //可变参数 更加真实 模拟波纹
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor blackColor];
        [self initalize];
    }
    return self;
}

- (void)initalize
{
    waterWaveHeight = self.frame.size.height/2;
    waterWaveWidth  = self.frame.size.width;
    if (waterWaveWidth > 0) {
        waveCycle =  2*M_PI / waterWaveWidth;//1.29 * M_PI / waterWaveWidth;
    }
    _firstWaveColor = [UIColor redColor];
//    _secondWaveColor = [UIColor colorWithRed:236/255.0f green:90/255.0f blue:66/255.0f alpha:1];
    
    waveGrowth = 0.85;
    waveSpeed = 0.2/M_PI;
    
    [self resetProperty];
}


- (void)resetProperty
{
    currentWavePointY = 50;
    variable = 1.6;
    offsetX = 0;
    waveAmplitude = 10;
}

-(void)startWave
{
//    [self resetProperty];
    
    if (_firstWaveLayer == nil) {
        // 创建第一个波浪Layer
        _firstWaveLayer = [CAShapeLayer layer];
        _firstWaveLayer.fillColor = _firstWaveColor.CGColor;
        [self.layer addSublayer:_firstWaveLayer];
    }
    
    if (_waveDisplaylink) {
        [self stopWave];
    }
    
    _waveDisplaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkProcess:)];
    [_waveDisplaylink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
}

-(void) stopWave
{
    ;
}

- (void)reset
{
    [_waveDisplaylink invalidate];
    _waveDisplaylink = nil;
    
    [_firstWaveLayer removeFromSuperlayer];
    _firstWaveLayer = nil;
//    [_secondWaveLayer removeFromSuperlayer];
//    _secondWaveLayer = nil;
}


-(void)animateWave
{
//    variable += 0.01;
    
    waveAmplitude = 20;//variable*5;
}

#pragma mark - dislink
- (void)displayLinkProcess:(CADisplayLink *)dl
{
    [self animateWave];
    
    
    // 波浪位移
//    offsetX += waveSpeed;
    
    [self setCurrentFirstWaveLayerPath];
//    [self setCurrentSecondWaveLayerPath];
}


#pragma mark - shape
-(void)setCurrentFirstWaveLayerPath
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = currentWavePointY;
    CGPathMoveToPoint(path, nil, 0, y);
    for (float x = 0.0f; x <=  waterWaveWidth ; x++) {
        // 正弦波浪公式
        y = waveAmplitude * sin(waveCycle * x + offsetX) + currentWavePointY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, waterWaveWidth, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    CGPathCloseSubpath(path);
    
    _firstWaveLayer.path = path;
    CGPathRelease(path);
}

#pragma mark - setter
- (void)setFirstWaveColor:(UIColor *)firstWaveColor
{
    _firstWaveColor = firstWaveColor;
    _firstWaveLayer.fillColor = firstWaveColor.CGColor;
}

//- (void)setSecondWaveColor:(UIColor *)secondWaveColor
//{
//    _secondWaveColor = secondWaveColor;
//    _secondWaveLayer.fillColor = secondWaveColor.CGColor;
//}
@end
