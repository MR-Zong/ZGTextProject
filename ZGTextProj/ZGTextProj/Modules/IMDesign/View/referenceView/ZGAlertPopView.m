//
//  ZGAlertPopView.m
//  ZGTextProj
//
//  Created by ali on 2019/2/16.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGAlertPopView.h"
#import <Masonry/Masonry.h>

@interface ZGAlertPopViewMaskView : UIView

@property (nonatomic, copy) void(^didTouchBlock)(void);
@end

@implementation ZGAlertPopViewMaskView
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_didTouchBlock) {
        _didTouchBlock();
    }
}
@end

#pragma mark - - - - - -  -
@interface ZGAlertPopView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) ZGAlertPopViewMaskView *maskView;
@end


@implementation ZGAlertPopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.layer.cornerRadius = 20;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        _maskView = [[ZGAlertPopViewMaskView alloc] init];
        _maskView.backgroundColor = [UIColor blackColor];
        __weak typeof(self) weakSelf = self;
        [_maskView setDidTouchBlock:^{
            [weakSelf dismiss];
        }];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor grayColor];
        [self addSubview:_lineView];
        
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(didConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_confirmBtn];
        
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(didCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:_cancelBtn];
        
        // auto layout
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(28);
            make.height.equalTo(@20);
            make.left.equalTo(self).offset(18.f);
            make.right.equalTo(self).offset(-18.f);
        }];
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.confirmBtn.mas_top);
            make.height.equalTo(@1);
            make.left.equalTo(self).offset(18.f);
            make.right.equalTo(self).offset(-18.f);
        }];
        
        [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self.cancelBtn.mas_left);
            make.width.equalTo(self.cancelBtn);
            make.bottom.equalTo(self);
            make.height.equalTo(@48);
        }];
        
        [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.left.equalTo(self.confirmBtn.mas_right);
            make.width.equalTo(self.confirmBtn);
            make.bottom.equalTo(self);
            make.height.equalTo(@48);
        }];
        
    }
    return self;
}

#pragma mark - process
- (void)showInView:(UIView *)view title:(nonnull NSString *)title
{
    if (self.superview) {
        return;
    }
    
    self.maskView.frame = view.bounds;
    [view addSubview:self.maskView];
    
    self.titleLabel.text = title;
    
    CGFloat width = 300;
    CGFloat height = 128;
    self.frame = CGRectMake((view.bounds.size.width - width)/2.0, (view.bounds.size.height - height)/2.0, width, height);
    self.alpha = 0;
    [view addSubview:self];
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1;
    }];
}

- (void)dismiss
{
    if (self.superview) {
        
        self.alpha = 1;
        [UIView animateWithDuration:0.25 animations:^{
            self.alpha = 0;
        }completion:^(BOOL finished) {
            [self.maskView removeFromSuperview];
            [self removeFromSuperview];
        }];
        
    }
}

#pragma mark - action
- (void)didConfirmBtn:(UIButton *)btn
{
    ;
}

- (void)didCancelBtn:(UIButton *)btn
{
    ;
}
@end
