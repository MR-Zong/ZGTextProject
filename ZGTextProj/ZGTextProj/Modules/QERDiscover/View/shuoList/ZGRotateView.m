//
//  ZGRotateView.m
//  ZGTextProj
//
//  Created by ali on 2019/2/28.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGRotateView.h"
#import <Masonry.h>

@interface ZGRotateView ()

@property (nonatomic, strong) UIImageView *bgImgView;

@end

@implementation ZGRotateView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _bgImgView = [[UIImageView alloc] init];
        _bgImgView.image = [UIImage imageNamed:@"videoInfo_music_cover"];
        [self addSubview:_bgImgView];
        
        _coverImgView = [[UIImageView alloc] init];
        _coverImgView.layer.cornerRadius = 16;
        _coverImgView.layer.masksToBounds = YES;
        [self addSubview:_coverImgView];
        
        // auto layout
        [_bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [_coverImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.centerX.equalTo(self);
            make.width.equalTo(@32);
            make.height.equalTo(@32);
        }];
        
    }
    return self;
}

-(void)startRotating
{
    if (self.layer.animationKeys.count > 0) {
        return;
    }
    [self reset];
    //    NSLog(@"startRotating startRotating startRotating startRotating");
    CABasicAnimation* rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    rotateAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2];   // 旋转一周
    rotateAnimation.duration = 20.0;                                 // 旋转时间20秒
    rotateAnimation.repeatCount = MAXFLOAT;                          // 重复次数，这里用最大次数
    
    [self.layer addAnimation:rotateAnimation forKey:
     @"zongRotating"];
    
}

-(void)stopRotating
{
    
    CFTimeInterval pausedTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.layer.speed = 0.0;                                          // 停止旋转
    self.layer.timeOffset = pausedTime;                              // 保存时间，恢复旋转需要用到
}

-(void)resumeRotate
{
    
    if (self.layer.timeOffset == 0) {
        [self startRotating];
        return;
    }
    
    CFTimeInterval pausedTime = self.layer.timeOffset;
    self.layer.speed = 1.0;                                         // 开始旋转
    self.layer.timeOffset = 0.0;
    self.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;                                             // 恢复时间
    self.layer.beginTime = timeSincePause;                          // 从暂停的时间点开始旋转
}

-(void)reset{
    [self.layer removeAllAnimations];
}

@end
