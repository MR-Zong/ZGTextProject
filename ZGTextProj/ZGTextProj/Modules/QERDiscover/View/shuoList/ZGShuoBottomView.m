//
//  ZGShuoBottomView.m
//  ZGTextProj
//
//  Created by ali on 2019/2/27.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGShuoBottomView.h"
#import "ZGShuoUsersListView.h"
#import "ZGShuoModel.h"
#import <Masonry.h>

@interface ZGShuoBottomView ()

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) UILabel *durationLabel;
@property (nonatomic, strong) ZGShuoUsersListView *usersListView;
@property (nonatomic, strong) UIButton *replyBtn;
@end


@implementation ZGShuoBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor redColor];
        [self addSubview:_lineView];
        
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _playBtn.backgroundColor = [UIColor redColor];
        [self addSubview:_playBtn];
        
        _durationLabel = [[UILabel alloc] init];
        _durationLabel.textColor = [UIColor blackColor];
        _durationLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:_durationLabel];
        
        _usersListView = [[ZGShuoUsersListView alloc] init];
        _usersListView.hidden = YES;
        [self addSubview:_usersListView];
        
        _replyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _replyBtn.backgroundColor = [UIColor redColor];
        [self addSubview:_replyBtn];
        
        // auto layout
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.height.equalTo(@1);
            make.left.equalTo(self).offset(18.f);
            make.right.equalTo(self).offset(-18.f);
        }];
        
        [_playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(18.f);
            make.centerY.equalTo(self);
            make.width.equalTo(@32);
            make.height.equalTo(@32);
        }];
        
        [_durationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.playBtn.mas_right).offset(8.f);
            make.width.lessThanOrEqualTo(@60);
            make.height.equalTo(@30);
            make.centerY.equalTo(self);
        }];
    
        _usersListView.backgroundColor = [UIColor purpleColor];
        [_usersListView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_replyBtn.mas_left).offset(-6.f);
            make.centerY.equalTo(self);
            make.width.equalTo(@20);
            make.height.equalTo(@20);
        }];
        
        [_replyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-18.f);
            make.centerY.equalTo(self);
            make.width.equalTo(@96);
            make.height.equalTo(@32);
        }];
    }
    return self;
}

- (void)setShuoModel:(ZGShuoModel *)shuoModel
{
    _shuoModel = shuoModel;
    
    _durationLabel.text = @"29''";
    
    NSArray *userAry = @[@"",@"",@"",@""];
    CGFloat listView_w = [ZGShuoUsersListView listViewWidthWithUsrsAry:userAry];
    [_usersListView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(listView_w));
    }];
    _usersListView.userArray = userAry;

}


@end
