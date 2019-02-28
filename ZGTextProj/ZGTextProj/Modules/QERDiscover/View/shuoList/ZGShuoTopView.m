//
//  ZGShuoTopView.m
//  ZGTextProj
//
//  Created by ali on 2019/2/27.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGShuoTopView.h"
#import <Masonry.h>

@interface ZGShuoTopView ()

@property (nonatomic, strong) UIImageView *headerImgView;
@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation ZGShuoTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _headerImgView = [[UIImageView alloc] init];
        _headerImgView.backgroundColor = [UIColor redColor];
        [self addSubview:_headerImgView];
        
        _textLabel = [[UILabel alloc] init];
        [self addSubview:_textLabel];
        
        // auto layout
        [_headerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(20.f);
            make.left.equalTo(self);
            make.width.equalTo(@20);
            make.height.equalTo(@20);
        }];
        
        [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headerImgView.mas_right).offset(8.f);
            make.centerY.equalTo(self.headerImgView);
            make.right.equalTo(self).offset(-5.f);
            make.height.equalTo(@20);
        }];
    }
    
    return self;
}

- (void)setShuoModel:(ZGShuoModel *)shuoModel
{
    _shuoModel = shuoModel;
    NSString *ts = [self timeStringWithTimeinteral:[[NSDate date] timeIntervalSince1970]];
    _textLabel.text = [NSString stringWithFormat:@"%@ · %@",@"zong",ts];
    
}

- (NSString *)timeStringWithTimeinteral:(NSTimeInterval)timeInterval
{
    return @"2小时前";
}

@end
