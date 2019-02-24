//
//  YGRecordView.m
//  ZGTextProj
//
//  Created by ali on 2018/10/19.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

//#import "YGRecordView.h"
//
//#define BeforeRecord_LineWidth 2.0
//#define BeforeRecord_LineColor UIColorFromRGBA(0xffffff, 1)
//#define Record_LineWidth 5.0
//#define Record_LineColor UIColorFromRGBA(0xffffff, 0.3)
//#define Record_TotalTime 30.0
//
//@interface YGRecordView ()
//
//@property (nonatomic, strong) UIButton *closeButton;//返回按钮
//@property (nonatomic, strong) UIButton *cameraButton;//切换相机按钮
//@property (nonatomic, strong) UIButton *alertButton;//提示按钮
//@property (nonatomic, strong) UIButton *recordButton;//录制按钮
//
//@property (nonatomic, strong) CAShapeLayer *borderLayer;//录制边框
//@property (nonatomic, strong) CAShapeLayer *progressLayer;//设置路径
//@property (nonatomic, strong) CABasicAnimation *strokeAnimationStart;//动画
//
//@property (nonatomic, strong) NSTimer *timer;//定时器
//@property (nonatomic, assign) NSInteger times;//录制时间
//
//@end
//
//@implementation YGRecordView
//
//- (instancetype)init
//{
//    self = [super init];if (self) {
//        [self setUI];
//        [self setFrame];
//        
//    }
//    return self;
//}
//
//- (void)setUI {
//
//    for (int i = 0; i < 4; i ++) {
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [self addSubview:button];
//        button.tag = 31 + i;
//        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//        if (i == 0) {
//            self.closeButton = button;
//            [_closeButton setImage:[UIImage imageNamed:@"record_close"] forState:UIControlStateNormal];
//            
//        } else if (i == 1) {
//            self.cameraButton = button;
//            [_cameraButton setImage:[UIImage imageNamed:@"record_camera"] forState:UIControlStateNormal];
//            
//        } else if (i == 2) {
//            self.alertButton = button;
//            _alertButton.hidden= YES;
//            _alertButton.userInteractionEnabled = NO;
//            [_alertButton setBackgroundImage:[UIImage imageNamed:@"record_alert_bg"] forState:UIControlStateNormal];
//            
//            _alertButton.titleLabel.font = [UIFont systemFontOfSize:11.0];
//            [_alertButton setTitle:@"录制至少八秒以上" forState:UIControlStateNormal];
//            [_alertButton setTitleColor:UIColorFromRGBA(0xffffff, 0.8) forState:UIControlStateNormal];
//            _alertButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 9, 0);
//            
//        } else if (i == 3) {
//            self.recordButton = button;
//            _recordButton.backgroundColor = UIColorFromRGBA(0xffffff, 0.6);
//            [_recordButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            _recordButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
//            
//        }
//        
//    }
//}
//
//- (void)setFrame {
//    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
////    //返回 && 切换摄像头
////    for (int i = 0; i < 2; i ++) {
////        UIButton *button = (UIButton *)[self viewWithTag:31 + i];
////        [button mas_makeConstraints:^(MASConstraintMaker *make) {
////            make.top.equalTo(self).offset(0.06 * SCREEN_HEIGHT);
////            make.height.equalTo(self).multipliedBy(0.06);
////            make.width.equalTo(button.mas_height);
////            if (i == 0) {
////                make.left.equalTo(self).offset(13);
////                
////            } else {
////                make.right.equalTo(self).offset(-13);
////                
////            }
////            
////        }];
////        
////    }
////    
//    //录制按钮
////    [_recordButton mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.centerX.equalTo(self);
////        make.bottom.equalTo(self).offset(- 0.052 * SCREEN_HEIGHT);
////        make.height.equalTo(self).multipliedBy(0.099);
////        make.width.equalTo(_recordButton.mas_height);
////
////    }];
////
////    //提示按钮
////    [_alertButton mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.centerX.equalTo(self);
////        make.bottom.equalTo(_recordButton.mas_top).offset(-0.02 * SCREEN_HEIGHT);
////        make.width.equalTo(self).multipliedBy(0.35);
////        make.height.equalTo(_alertButton.mas_width).multipliedBy(0.24);
////    }];
//}
//
////设置圆角, 添加图层
//- (void)layoutSubviews {
//    
//    [super layoutSubviews];
//    
//    CGFloat H = _recordButton.frame.size.height;
//    
//    _recordButton.layer.masksToBounds = YES;
//    _recordButton.layer.cornerRadius = H / 2.0;
//    
//    [self.layer addSublayer:self.borderLayer];
//}
//
//- (void)buttonClick:(UIButton *)sender {
//    if (sender.tag == 31 || sender.tag == 32) {
//        
////        //点击返回或切换摄像头按钮
////        if (self.recordViewBlock) {
////            _recordViewBlock(sender.tag);
////
////        }
////
//    } else if (sender.tag == 34) {
//        
//        //点击录制按钮
//        [self dealRecordWithSender:sender];
//    }
//}
//- (void)dealRecordWithSender:(UIButton *)sender {
//    sender.selected = !sender.selected;
//    
//    if (sender.selected) {
//        //开始录制
//        [self startRecord];
//        
//    } else {
//        //结束录制
//        [self stopRecordIsEnterBackground:NO];
//        
//    }
//}
//
////开始录制
//- (void)startRecord {
//    _times= 0;
//    _alertButton.hidden= NO;
//    
//    //修改录制按钮
//    _recordButton.backgroundColor = UIColorFromRGBA(0xff0000, 0.8);
//    
//    //修改边框layer
//    _borderLayer.lineWidth = Record_LineWidth;
//    _borderLayer.strokeColor = Record_LineColor.CGColor;
//    
//    //开启定时器
//    [self addTimer];
//    
//    //开启动画
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        [self.layer addSublayer:self.progressLayer];
//        [self.progressLayer addAnimation:self.strokeAnimationStart forKey:nil];
//        
//    });
//    
////    //回调33  开始录制
////    if (self.recordViewBlock) {
////        _recordViewBlock(33);
////
//    }
//}
//
////停止录制
//- (void)stopRecordIsEnterBackground:(BOOL)is {
//    //移除动画
//    [self.layer removeAllAnimations];
//    [_progressLayer removeAllAnimations];
//    [_progressLayer removeFromSuperlayer];
//    
//    //取消定时器
//    [self cancleTimer];
//    _alertButton.hidden= YES;
//    //恢复录制按钮
//    _recordButton.selected = NO;
//    _recordButton.backgroundColor = UIColorFromRGBA(0xffffff, 0.6);
//    
//    [_recordButton setTitle:@"" forState:UIControlStateNormal];
//    //恢复边框layer
//    _borderLayer.lineWidth = BeforeRecord_LineWidth;
//    _borderLayer.strokeColor = BeforeRecord_LineColor.CGColor;
//    
//    //回调 <=30  录制结束
////    if (self.recordViewBlock) {
////
////        //如果是进入后台调用的此方法则不回调
////        if (!is) {
////            _recordViewBlock(_times);
////
////        }
////
////    }
//}
//
//#pragma mark -
////添加定时器
//- (void)addTimer {
//    
//    if (_timer == nil) {
//        _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(saveRecordTime) userInfo:nil repeats:YES];
//        
//    }
//    
//    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
//}
//
//- (void)saveRecordTime {
//    self.times ++;
//    
//    //8s后隐藏提示
//    if (_times >= 8) {
//        [UIView animateWithDuration:0.3 animations:^{
//            _alertButton.alpha = 0;
//            
//        } completion:^(BOOL finished) {
//            _alertButton.hidden = YES;
//            _alertButton.alpha= 1.0;
//            
//        }];
//        
//    }
//    
//    //30s录制完成  停止录制
//    if (self.times >= 30) {
//        [self stopRecordIsEnterBackground:NO];
//        
//    } else {
//        [_recordButton setTitle:[NSString stringWithFormat:@"%lds",(long)_times] forState:UIControlStateNormal];
//        
//    }
//}
//
////取消定时器
//- (void)cancleTimer {
//    
//    if ([_timer isValid]) {
//        [_timer invalidate];
//        _timer = nil;
//        
//    }
//}
//
//#pragma mark - 懒加载方法
//- (CAShapeLayer *)borderLayer {
//    if (!_borderLayer) {
//        
//        _borderLayer = [CAShapeLayer layer];
//        CGMutablePathRef solidPath = CGPathCreateMutable();
//        
//        _borderLayer.lineWidth = BeforeRecord_LineWidth;
//        _borderLayer.strokeColor = BeforeRecord_LineColor.CGColor;
//        _borderLayer.fillColor = [UIColor clearColor].CGColor;
//        CGPathAddEllipseInRect(solidPath, nil, CGRectMake(CGRectGetMinX(_recordButton.frame) - 5,CGRectGetMinY(_recordButton.frame) - 5, 0.099 * SCREEN_HEIGHT + 5*2, 0.099 * SCREEN_HEIGHT + 5*2));
//        _borderLayer.path = solidPath;
//        CGPathRelease(solidPath);
//        
//    }
//    return _borderLayer;
//}
//
//- (CAShapeLayer *)progressLayer {
//    if (!_progressLayer) {
//        
//        _progressLayer = [CAShapeLayer layer];
//        _progressLayer.frame = self.borderLayer.frame;
//        _progressLayer.path = [UIBezierPath bezierPathWithArcCenter:self.recordButton.center radius:(0.099 * SCREEN_HEIGHT + 5*2)/2.0
//                                                             startAngle:-M_PI_2
//                                                               endAngle:-M_PI_2-2*M_PI
//                                                              clockwise:NO].CGPath;
//        _progressLayer.fillColor= [UIColor clearColor].CGColor;
//        _progressLayer.lineWidth= Record_LineWidth;
//        _progressLayer.strokeColor = UIColorFromRGBA(0xffeb45, 1).CGColor;
//        
//        _progressLayer.lineCap= kCALineCapRound;
//        
//    }
//    return _progressLayer;
//}
////动画
//- (CABasicAnimation *)strokeAnimationStart {
//    
//    if (!_strokeAnimationStart) {
//        
//        _strokeAnimationStart = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
//        
//        _strokeAnimationStart.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//        _strokeAnimationStart.duration=Record_TotalTime;
//        _strokeAnimationStart.fromValue = @1;
//        _strokeAnimationStart.toValue=@0;
//        _strokeAnimationStart.speed=1.0;
//        _strokeAnimationStart.removedOnCompletion = NO;
//    }
//    return _strokeAnimationStart;
//}
//
//@end
