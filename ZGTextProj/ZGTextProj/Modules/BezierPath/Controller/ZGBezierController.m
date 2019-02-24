//
//  ZGBezierController.m
//  ZGTextProj
//
//  Created by ali on 2018/10/16.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGBezierController.h"

@interface ZGBezierController ()

@property (nonatomic, strong) CADisplayLink *dLink;
@property (nonatomic, assign) CGFloat startAngel;
@property (nonatomic, strong) CAShapeLayer *circleLayer;
@property (nonatomic, assign) CGFloat process;

@end

@implementation ZGBezierController

- (void)dealloc
{
    [self.dLink invalidate];
    self.dLink = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self testBezierPath];
    
    // animdation
//    [self testAnimationBezierPath];

    // animdation 方案二
//    [self testAnimationBezierPath2];
}

- (void)testBezierPath
{
    //主要解释一下各个参数的意思
    //center  中心点（可以理解为圆心）
    //radius  半径
    //startAngle 起始角度
    //endAngle  结束角度
    //clockwise  是否顺时针
    UIBezierPath *cicrle     = [UIBezierPath bezierPathWithArcCenter:self.view.center
                                                              radius:95
                                                          startAngle:- M_PI
                                                            endAngle: 0
                                                           clockwise:YES];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineWidth     = 5.f;
    shapeLayer.fillColor     = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor   = [UIColor greenColor].CGColor;
    shapeLayer.path          = cicrle.CGPath;
    
    [self.view.layer addSublayer:shapeLayer];
    
    
    // 画刻度
    CGFloat perAngle = M_PI / 50;
    //我们需要计算出每段弧线的起始角度和结束角度
    //这里我们从- M_PI 开始，我们需要理解与明白的是我们画的弧线与内侧弧线是同一个圆心
    for (int i = 0; i< 51; i++) {
        
        CGFloat startAngel = (-M_PI + perAngle * i);
        CGFloat endAngel   = startAngel + perAngle/5;
        
        UIBezierPath *tickPath = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:150 startAngle:startAngel endAngle:endAngel clockwise:YES];
        CAShapeLayer *perLayer = [CAShapeLayer layer];
        
        if (i % 5 == 0) {
            
            perLayer.strokeColor = [UIColor colorWithRed:0.62 green:0.84 blue:0.93 alpha:1.0].CGColor;
            perLayer.lineWidth   = 10.f;
            
        }else{
            perLayer.strokeColor = [UIColor colorWithRed:0.22 green:0.66 blue:0.87 alpha:1.0].CGColor;
            perLayer.lineWidth   = 5;
            
        }
        
        perLayer.path = tickPath.CGPath;
        [self.view.layer addSublayer:perLayer];
        
    }
    
}

- (void)testAnimationBezierPath
{
    _startAngel = - M_PI;

    
    _circleLayer = [CAShapeLayer layer];
    _circleLayer.lineWidth     = 5.f;
    _circleLayer.lineCap = kCALineCapRound;
    _circleLayer.fillColor     = [UIColor clearColor].CGColor;
    _circleLayer.strokeColor   = [UIColor greenColor].CGColor;
    [self.view.layer addSublayer:_circleLayer];
    
    _dLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(didDLink)];
    [_dLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
}

- (void)testAnimationBezierPath2
{
    _startAngel = - M_PI;
    
    
    //创建贝塞尔路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:100 startAngle:self.startAngel endAngle:M_PI clockwise:YES];
    
    _circleLayer = [CAShapeLayer layer];
    _circleLayer.frame = CGRectMake(0, 0, 100, 100);
    _circleLayer.lineWidth     = 5.f;
    _circleLayer.lineCap = kCALineCapRound;
    _circleLayer.fillColor     = [UIColor clearColor].CGColor;
    _circleLayer.strokeColor   = [UIColor greenColor].CGColor;
    _circleLayer.path = [path CGPath];
    _circleLayer.strokeEnd = 0;
    [self.view.layer addSublayer:_circleLayer];
    
    _dLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(didDLink2)];
    [_dLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
}

- (void)didDLink
{
    if (self.startAngel >= M_PI) {
        return;
    }
    CGFloat perAngle = (2*M_PI) / (15*60);
    CGFloat endAngel   = self.startAngel + perAngle;
    NSLog(@"startAngel %f",self.startAngel);
    
    UIBezierPath *cicrle     = [UIBezierPath bezierPathWithArcCenter:self.view.center
                                                              radius:95
                                                          startAngle:-M_PI
                                                            endAngle: endAngel
                                                           clockwise:YES];
    _circleLayer.path   = cicrle.CGPath;
    
    self.startAngel = endAngel;
}

- (void)didDLink2
{
    if (self.process == 1) {
        return;
    }
    CGFloat perProcess = 1.0 / (15*60);
    self.process += perProcess;
    self.circleLayer.strokeEnd = self.process;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (CALayer *sublayer in self.view.layer.sublayers) {
        NSLog(@"sublayer %@",sublayer);
    }
}


@end
