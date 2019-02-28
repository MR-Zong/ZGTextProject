//
//  ZGShuoTextShowView.m
//  ZGTextProj
//
//  Created by ali on 2019/2/27.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGShuoTextShowView.h"
#import <Masonry.h>
#import "ZGShuoModel.h"


@interface ZGShuoTextShowView ()

@property (nonatomic, strong) UILabel *shuoLabel;
@property (nonatomic, strong) UILabel *hashTagView;
@end


@implementation ZGShuoTextShowView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor greenColor];
        
        _shuoLabel = [[UILabel alloc] init];
        _shuoLabel.numberOfLines = 3;
        _shuoLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:_shuoLabel];
        
        _hashTagView = [[UILabel alloc] init];
        [self addSubview:_hashTagView];
        
        // auto layout
        [_shuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self);
            make.right.equalTo(self);
        }];
        
        [_hashTagView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.shuoLabel.mas_bottom).offset(10.f);
            make.height.equalTo(@17);
            make.left.equalTo(self);
        }];
    }
    return self;
}

- (void)setShuoModel:(ZGShuoModel *)shuoModel
{
    _shuoModel = shuoModel;
    _shuoLabel.text = shuoModel.content;
    _hashTagView.text = [NSString stringWithFormat:@" # %@ ",shuoModel.hashTag];
}


@end
