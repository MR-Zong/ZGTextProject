//
//  ZGFPSProbeView.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/3/22.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGFPSProbeView.h"

@interface ZGFPSProbeView ()

@property (nonatomic, strong) CADisplayLink *dLink;
@property (nonatomic, strong) UILabel *textLabel;

@end


@implementation ZGFPSProbeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _dLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkTriggered:)];
//        [_dLink setPaused:YES];
        [_dLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        
        _textLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.backgroundColor = [UIColor redColor];
        _textLabel.textColor = [UIColor blackColor];
        _textLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_textLabel];

    }
    return self;
}

- (void)displayLinkTriggered:(CADisplayLink *)link
{
    static NSTimeInterval lastTime = 0;
    static int frameCount = 0;
    if (lastTime == 0) { lastTime = link.timestamp; return; }
    frameCount++; // 累计帧数
    NSTimeInterval passTime = link.timestamp - lastTime;// 累计时间
    if (passTime > 1) { // 1秒左右获取一次帧数
        int fps = frameCount / passTime; // 帧数 = 总帧数 / 时间
        lastTime = link.timestamp; // 重置
        frameCount = 0; // 重置
//        NSLog(@"%d", fps);
        self.textLabel.text = [NSString stringWithFormat:@"FPS:%zd",fps];
    }
}


@end
