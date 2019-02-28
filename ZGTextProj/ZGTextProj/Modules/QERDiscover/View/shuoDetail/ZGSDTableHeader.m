//
//  ZGSDTableHeader.m
//  ZGTextProj
//
//  Created by ali on 2019/2/27.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGSDTableHeader.h"
#import "ZGShuoTopView.h"
#import <Masonry.h>


@interface ZGSDTHBottomView : UIView
@property (nonatomic, strong) UILabel *hashtabLabel;
@property (nonatomic, strong) UIButton *playBtn;

@end

@implementation ZGSDTHBottomView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _hashtabLabel = [[UILabel alloc] init];
        [self addSubview:_hashtabLabel];
        
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_playBtn];
        
        // auto layout
        [_hashtabLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(18.f);
            make.centerY.equalTo(self);
            make.height.equalTo(@20);
        }];
        
        [_playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-18.f);
            make.centerY.equalTo(self);
            make.height.equalTo(@32);
            make.width.equalTo(@32);
        }];
    }
    return self;
}
@end

#pragma mark - - - - - -- -
@interface ZGSDTableHeader ()

@property (nonatomic, strong) ZGShuoTopView *topView;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) ZGSDTHBottomView *bottomView;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation ZGSDTableHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _topView = [[ZGShuoTopView alloc] init];
        [self addSubview:_topView];
        
        _textLabel = [[UILabel alloc] init];
        _textLabel.numberOfLines = 0;
        _textLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:_textLabel];
        
        _bottomView = [[ZGSDTHBottomView alloc] init];
        [_bottomView.playBtn addTarget:self action:@selector(didPlayBtn:) forControlEvents:UIControlEventTouchUpOutside];
        [self addSubview:_bottomView];
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor darkGrayColor];
        [self addSubview:_lineView];
        
        // auto layout
        [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self).offset(18.f);
            make.right.equalTo(self).offset(-18.f);
            make.height.equalTo(@40);
        }];
        
        [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topView.mas_bottom).offset(10.f);
            make.bottom.equalTo(self.bottomView.mas_top);
            make.right.equalTo(self).offset(-18.f);
            make.left.equalTo(self).offset(18.f);
        }];
        
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.lineView.mas_top);
            make.height.equalTo(@64);
            make.left.equalTo(self);
            make.right.equalTo(self);
        }];
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.height.equalTo(@6);
        }];
        
    }
    return self;
}

#pragma mark - action
- (void)didPlayBtn:(UIButton *)btn
{
    ;
}

@end


#pragma mark - - -  - -
@implementation ZGSDTableSectionHeader
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:20];
        [self addSubview:_titleLabel];
        
        // auto layout
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(38.f);
            make.left.equalTo(self).offset(18.f);
            make.height.equalTo(@30);
            make.right.equalTo(self);
        }];
    }
    return self;
}
@end
