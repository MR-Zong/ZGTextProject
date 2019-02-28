//
//  ZGLevitateView.m
//  ZGTextProj
//
//  Created by ali on 2019/2/27.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGLevitateView.h"
#import "ZGRotateView.h"
#import <Masonry.h>

@interface ZGLevitateBarView : UIView
@property (nonatomic, strong) UILabel *durationLabel;
@property (nonatomic, strong) UILabel *total_durationLabel;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UIButton *replyBtn;

@end

@implementation ZGLevitateBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _durationLabel = [[UILabel alloc] init];
        _durationLabel.font = [UIFont systemFontOfSize:29];
        _durationLabel.textColor = [UIColor whiteColor];
        _durationLabel.text  =@"22''";
        [self addSubview:_durationLabel];
        
        _total_durationLabel = [[UILabel alloc] init];
        _total_durationLabel.text = @"78''";
        _total_durationLabel.font = [UIFont systemFontOfSize:22];
        _total_durationLabel.textColor = [UIColor whiteColor];
        [self addSubview:_total_durationLabel];
        
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn.backgroundColor = [UIColor redColor];
        [self addSubview:_nextBtn];
        
        _replyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _replyBtn.backgroundColor = [UIColor redColor];
        [self addSubview:_replyBtn];
        
        // auto layout
        [_durationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20+11.f);
            make.width.lessThanOrEqualTo(@100);
            make.height.equalTo(@29);
            make.centerY.equalTo(self);
        }];
        
        [_total_durationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20+7.f);
            make.width.lessThanOrEqualTo(@60);
            make.height.equalTo(@22);
            make.bottom.equalTo(self);
        }];
        
        [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.durationLabel.mas_right).offset(7.f);
            make.centerY.equalTo(self);
            make.width.equalTo(@32);
            make.height.equalTo(@32);
        }];
        
        [_replyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nextBtn.mas_right).offset(4.f);
            make.centerY.equalTo(self);
            make.width.equalTo(@32);
            make.height.equalTo(@32);
        }];
    }
    return self;
}

@end


@interface ZGLevitateView ()

@property (nonatomic, strong) ZGRotateView *cdView;
@property (nonatomic, strong) ZGLevitateBarView *barView;
@property (nonatomic, strong) ZGShuoModel *shuoModel;

@end

@implementation ZGLevitateView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor orangeColor];
        
        _barView = [[ZGLevitateBarView alloc] init];
        _barView.backgroundColor = [UIColor blackColor];
        _barView.layer.cornerRadius = 20;
        _barView.layer.masksToBounds = YES;
        [_barView.nextBtn addTarget:self action:@selector(didNext) forControlEvents:UIControlEventTouchUpInside];
        [_barView.replyBtn addTarget:self action:@selector(didReply) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_barView];
        
        _cdView = [[ZGRotateView alloc] init];
        _cdView.backgroundColor = [UIColor blackColor];
        [_cdView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didCdView)]];
        [self addSubview:_cdView];
        
        // auto layout
        [_cdView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.centerY.equalTo(self);
            make.width.equalTo(@52);
            make.height.equalTo(@52);
        }];
        
        [_barView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.cdView.mas_right).offset(-20.f);
            make.right.equalTo(self);
            make.height.equalTo(@40);
            make.centerY.equalTo(self);
        }];
        
    }
    
    return self;
}

#pragma mark -
- (void)playWithShuoModel:(ZGShuoModel *)shuoModel
{
    ;
}


#pragma mark - action
- (void)didNext
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(levitateView:didNextWithModel:)]) {
        [self.delegate levitateView:self didNextWithModel:self.shuoModel];
    }
}

- (void)didReply
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(levitateView:didReplayWithModel:)]) {
        [self.delegate levitateView:self didReplayWithModel:self.shuoModel];
    }
}

- (void)didCdView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(levitateView:didTouchCDithModel:)]) {
        [self.delegate levitateView:self didTouchCDithModel:self.shuoModel];
    }
}

@end
