//
//  ZGSubTabBarView.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/1/11.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGSubTabBarView.h"

@interface ZGSubTabBarView ()
@property (nonatomic,strong) UIButton *btn1;
@property (nonatomic,strong) UIButton *btn2;
@property (nonatomic,strong) UIButton *btn3;
@property (nonatomic,strong) UIView *indicatorView;
@end

@implementation ZGSubTabBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor redColor];
        
        CGFloat btnWidth = self.frame.size.width / 3.0;
        _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn1 setTitle:@"电影" forState:UIControlStateNormal];
        _btn1.frame = CGRectMake(0, 0, btnWidth, self.frame.size.height);
        [self addSubview:_btn1];
        
        _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn2 setTitle:@"电视剧" forState:UIControlStateNormal];
        _btn2.frame = CGRectMake(btnWidth, 0, btnWidth, self.frame.size.height);
        [self addSubview:_btn2];
        
        _btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn3 setTitle:@"综艺" forState:UIControlStateNormal];
        _btn3.frame = CGRectMake(btnWidth * 2, 0, btnWidth, self.frame.size.height);
        [self addSubview:_btn3];
        
        _indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 2, btnWidth, 2)];
        _indicatorView.backgroundColor = [UIColor blueColor];
        [self addSubview:_indicatorView];

    }
    return self;
}

- (void)tabWithIndex:(NSInteger)index contentOffset:(CGPoint)contentOffset
{
   CGRect tmpFrame = self.indicatorView.frame;
    tmpFrame.origin.x = (contentOffset.x - [UIScreen mainScreen].bounds.size.width) / self.tabCount;
    self.indicatorView.frame = tmpFrame;
}


@end
