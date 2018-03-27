//
//  ZGNoDataView.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/1/5.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGNoDataView.h"

@interface ZGNoDataView ()

@property (nonatomic, assign) CGFloat iconImgViewWidth;
@property (nonatomic, assign) CGFloat iconImgViewHeight;

@property (nonatomic, strong) UIImageView *iconImgView;
@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation ZGNoDataView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _iconImgViewWidth = 200.0;
        _iconImgViewHeight = _iconImgViewWidth;
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)]];
        
        _iconImgView = [[UIImageView alloc] init];
        _iconImgView.image = [UIImage imageNamed:@"no_description"];
        _iconImgView.backgroundColor = [UIColor redColor];
        [self addSubview:_iconImgView];
        
        _textLabel = [[UILabel alloc] init];
        _textLabel.backgroundColor = [UIColor orangeColor];
        _textLabel.text = @"暂无数据";
        _textLabel.font = [UIFont systemFontOfSize:14];
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.numberOfLines = 0;
        [self addSubview:_textLabel];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // layout
    _iconImgView.frame = CGRectMake((self.bounds.size.width-self.iconImgViewWidth)/2.0, 0, self.iconImgViewWidth, self.iconImgViewHeight);
    _textLabel.frame = CGRectMake(0, CGRectGetMaxY(_iconImgView.frame)+5, self.bounds.size.width, 40);

}

#pragma mark - aciton
- (void)didTap:(UITapGestureRecognizer *)tap
{
    if (self.didTapBlock) {
        self.didTapBlock(self);
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(noDataViewDidTap:)]) {
        [self.delegate noDataViewDidTap:self];
    }
}


- (void)setImage:(UIImage *)image text:(NSString *)text
{
    if (image) {
        self.iconImgView.image = image;
    }else {
        self.iconImgView.image = [UIImage imageNamed:@"no_description"];
    }
    self.textLabel.text = text;
}

- (void)setImage:(UIImage *)image attributeText:(NSAttributedString *)attributeText
{
    if (image) {
        self.iconImgView.image = image;
    }else {
        self.iconImgView.image = [UIImage imageNamed:@"no_description"];
    }
    self.textLabel.attributedText = attributeText;
}


- (void)setIconImgViewWidth:(CGFloat)width iconImgViewHeight:(CGFloat)height
{
    self.iconImgViewWidth = width;
    self.iconImgViewHeight = height;
    
    CGRect tmpF = self.iconImgView.frame;
    tmpF.size.width = width;
    tmpF.size.height = height;
    self.iconImgView.frame = tmpF;

    tmpF = self.textLabel.frame;
    tmpF.origin.y = CGRectGetMaxY(self.iconImgView.frame);
    self.textLabel.frame = tmpF;

}


@end
