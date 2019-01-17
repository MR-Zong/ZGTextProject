//
//  ZGBottomToolBar.m
//  AudioProgress
//
//  Created by ali on 2019/1/16.
//  Copyright © 2019 赵成峰. All rights reserved.
//

#import "ZGBottomToolBar.h"

@implementation ZGBottomToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor orangeColor];
        
        CGFloat screenCenterX = [UIScreen mainScreen].bounds.size.width/2.0;
        
        _routeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_routeBtn setTitle:@"自带音频" forState:UIControlStateNormal];
        _routeBtn.backgroundColor = [UIColor redColor];
        _routeBtn.frame = CGRectMake(screenCenterX - 100, 20, 100, 40);
        [_routeBtn addTarget:self action:@selector(didRouteBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_routeBtn];
        
        _recBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _recBtn.enabled = NO;
        [_recBtn setTitle:@"录制" forState:UIControlStateNormal];
        _recBtn.backgroundColor = [UIColor redColor];
        _recBtn.frame = CGRectMake(screenCenterX+10, 20, 60, 40);
        [_recBtn addTarget:self action:@selector(didRecBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_recBtn];
        
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _playBtn.hidden = YES;
        [_playBtn setTitle:@"播放原声" forState:UIControlStateNormal];
        _playBtn.backgroundColor = [UIColor redColor];
        _playBtn.frame = CGRectMake(220, 20, 80, 40);
        [_playBtn addTarget:self action:@selector(didPlayBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_playBtn];
    }
    return self;
}

#pragma mark - action
- (void)didRouteBtn:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected) {
        [btn setTitle:@"自己录制" forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor greenColor];
        _recBtn.enabled = YES;
    }else {
        [btn setTitle:@"自带音频" forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor redColor];
        _recBtn.enabled = NO;
        if (_recBtn.selected) {
            [self didRecBtn:_recBtn];
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(toolBar:didClickRouteBtn:)]) {
        [self.delegate toolBar:self didClickRouteBtn:btn];
    }
}

- (void)didRecBtn:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected) {
        [btn setTitle:@"停止" forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor greenColor];
    }else {
        [btn setTitle:@"录制" forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor redColor];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(toolBar:didClickRecBtn:)]) {
        [self.delegate toolBar:self didClickRecBtn:btn];
    }

}

- (void)didPlayBtn:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected) {
        [btn setTitle:@"停止" forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor greenColor];
    }else {
        [btn setTitle:@"播放原声" forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor redColor];
    }

}

@end
