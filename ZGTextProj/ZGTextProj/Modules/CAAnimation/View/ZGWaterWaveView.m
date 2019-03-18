//
//  ZGWaterWaveView.m
//  ZGTextProj
//
//  Created by ali on 2019/3/17.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGWaterWaveView.h"
#import "ZGProxy.h"

@interface ZGWaterWaveView ()

@property (nonatomic, strong) CADisplayLink *waveDisplaylink;
@property (nonatomic, strong) CAShapeLayer  *firstWaveLayer;
@property (nonatomic, strong) CAShapeLayer  *secondWaveLayer;

@end


@implementation ZGWaterWaveView {
    CGFloat waveAmplitude_first;  // 波纹振幅
     CGFloat waveAmplitude_second;  // 波纹振幅
    CGFloat waveCycle;
    CGFloat waveSpeed;      // 波纹速度
    CGFloat waveGrowth;     // 波纹上升速度
    
    CGFloat waterWaveHeight;
    CGFloat waterWaveWidth;
    CGFloat offsetX;           // 波浪x位移
    CGFloat currentWavePointY; // 当前波浪上市高度Y（高度从大到小 坐标系向下增长）
    
    float variable;     //可变参数 更加真实 模拟波纹
}


- (void)dealloc
{
    [self clear];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor blackColor];
        [self initalize];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    waterWaveHeight = self.frame.size.height/2;
    waterWaveWidth  = self.frame.size.width;
    if (waterWaveWidth > 0) {
        waveCycle =  2*M_PI / waterWaveWidth;//1.29 * M_PI / waterWaveWidth;
    }
}

- (void)initalize
{
    _firstWaveColor = [UIColor redColor];
    _secondWaveColor = [UIColor blueColor];
    
    waveGrowth = 0.85;
    waveSpeed = 0.2/M_PI;
    
    _firstWaveLayer = [CAShapeLayer layer];
    _firstWaveLayer.fillColor = _firstWaveColor.CGColor;
    [self.layer addSublayer:_firstWaveLayer];
    
    _secondWaveLayer = [CAShapeLayer layer];
    _secondWaveLayer.fillColor = _secondWaveColor.CGColor;
    [self.layer addSublayer:_secondWaveLayer];
    
    _waveDisplaylink = [CADisplayLink displayLinkWithTarget:[ZGProxy proxyWithTarget:self] selector:@selector(displayLinkProcess:)];
    _waveDisplaylink.paused = YES;
    [_waveDisplaylink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    [self resetProperty];
}


- (void)resetProperty
{
    currentWavePointY = 50;
    variable = 1.6;
    offsetX = 0;
    waveAmplitude_first = 20;
    waveAmplitude_second = 10;
}

-(void)startWave
{
    [self resetProperty];
   
    if (_waveDisplaylink.paused == NO) {
        [self stopWave];
    }
    
    _waveDisplaylink.paused = NO;
}

-(void)stopWave
{
    _waveDisplaylink.paused = YES;
}


- (void)clear
{
    [_waveDisplaylink invalidate];
    _waveDisplaylink = nil;
    
    [self resetProperty];
    
    [_firstWaveLayer removeFromSuperlayer];
    _firstWaveLayer = nil;
    [_secondWaveLayer removeFromSuperlayer];
    _secondWaveLayer = nil;
}


-(void)animateWave
{
    variable += 0.01;
    
    waveAmplitude_first = 20;//variable*5;
}

#pragma mark - dislink
- (void)displayLinkProcess:(CADisplayLink *)dl
{
    [self animateWave];

    offsetX += waveSpeed;
    [self setCurrentFirstWaveLayerPath];
    [self setCurrentSecondWaveLayerPath];
}


#pragma mark - shape
-(void)setCurrentFirstWaveLayerPath
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = currentWavePointY;
    CGPathMoveToPoint(path, nil, 0, y);
    for (float x = 0.0f; x <=  waterWaveWidth ; x++) {
        y = waveAmplitude_first * sin(waveCycle * x + offsetX)+ currentWavePointY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, waterWaveWidth, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    CGPathCloseSubpath(path);
    
    _firstWaveLayer.path = path;
    CGPathRelease(path);
}

-(void)setCurrentSecondWaveLayerPath
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = currentWavePointY;
    CGPathMoveToPoint(path, nil, 0, y);
    for (float x = 0.0f; x <=  waterWaveWidth ; x++) {
        y = waveAmplitude_second * cos(waveCycle * x + offsetX) + currentWavePointY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, waterWaveWidth, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    CGPathCloseSubpath(path);
    
    _secondWaveLayer.path = path;
    CGPathRelease(path);
}

#pragma mark - setter
- (void)setFirstWaveColor:(UIColor *)firstWaveColor
{
    _firstWaveColor = firstWaveColor;
    _firstWaveLayer.fillColor = firstWaveColor.CGColor;
}

- (void)setSecondWaveColor:(UIColor *)secondWaveColor
{
    _secondWaveColor = secondWaveColor;
    _secondWaveLayer.fillColor = secondWaveColor.CGColor;
}

- (void)setHidden:(BOOL)hidden
{
    [super setHidden:hidden];
    if (hidden == YES) {
        [self stopWave];
    }else {
        [self startWave];
    }
}
@end
