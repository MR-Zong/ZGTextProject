//
//  ZGShuoBaseCell.m
//  ZGTextProj
//
//  Created by ali on 2019/2/27.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGShuoBaseCell.h"

@interface ZGShuoBaseCellProgressView : UIView

@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, strong) UIView *progressView;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@end

@implementation ZGShuoBaseCellProgressView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _progressView = [[UIView alloc] init];
        [self addSubview:_progressView];
        
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor greenColor].CGColor];
        _gradientLayer.locations = @[@0.1, @1.0];
        _gradientLayer.startPoint = CGPointMake(0, 0);
        _gradientLayer.endPoint = CGPointMake(1.0, 0);
        [_progressView.layer addSublayer:_gradientLayer];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _gradientLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    if (progress <= 1) {
        _progressView.frame = CGRectMake(self.bounds.size.width*(progress - 1.0), 0, self.bounds.size.width, self.bounds.size.height);
        NSLog(@"_progressView.frame %@",NSStringFromCGRect(_progressView.frame));
    }
}
@end

#pragma mark  - - - - -  -
@interface ZGShuoBaseCell ()

@property (nonatomic, strong) ZGShuoBaseCellProgressView *progressView;

@end

@implementation ZGShuoBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _progressView = [[ZGShuoBaseCellProgressView alloc] init];
        _progressView.hidden = YES;
        [self.contentView addSubview:_progressView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.progressView.frame = self.contentView.bounds;
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    if (progress >0  && progress < 1) {
        self.progressView.hidden = NO;
    }else {
        self.progressView.hidden = YES;
    }
    self.progressView.progress = progress;
}


@end
