//
//  ZGMsgBottomView.m
//  ZGTextProj
//
//  Created by ali on 2019/2/15.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGMsgBottomView.h"
#import <Masonry/Masonry.h>

@interface ZGMsgBottomView ()

@property (nonatomic, strong) UIButton *recordBtn;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;


@end

@implementation ZGMsgBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
//        self.backgroundColor = [UIColor greenColor];

        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.colors = @[(__bridge id)[[UIColor whiteColor] colorWithAlphaComponent:0].CGColor, (__bridge id)[UIColor whiteColor].CGColor];
        _gradientLayer.locations = @[@0, @1];
        _gradientLayer.startPoint = CGPointMake(0, 0);
        _gradientLayer.endPoint = CGPointMake(0, 1);
        [self.layer addSublayer:_gradientLayer];
        
        _recordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _recordBtn.backgroundColor = [UIColor redColor];
        _recordBtn.layer.cornerRadius = 35.0;
        _recordBtn.layer.masksToBounds = YES;
        [_recordBtn addTarget:self action:@selector(didRecordBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_recordBtn];
        
        // auto layout
        [_recordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.centerX.equalTo(self);
            make.width.equalTo(@70);
            make.height.equalTo(@70);
        }];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.gradientLayer.frame = self.bounds;
}

#pragma mark - action
- (void)didRecordBtn:(UIButton *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(bottomView:didRecordBtn:)]) {
        [self.delegate bottomView:self didRecordBtn:btn];
    }
}


@end
