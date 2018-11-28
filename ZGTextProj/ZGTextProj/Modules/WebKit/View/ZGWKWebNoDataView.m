
//
//  ZGNoDataView.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/1/5.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGWKWebNoDataView.h"

@implementation ZGWKWebNoDataViewModel

+ (instancetype)noDataViewModelWithCode:(NSInteger)code message:(NSString *)message error:(NSError *)error
{
    ZGWKWebNoDataViewModel *model = [[self alloc] init];
    model.code = code;
    model.message = message;
    model.error = error;
    return model;
}

@end


#pragma mark - - - - -  - - -

@interface ZGWKWebNoDataView ()

@property (nonatomic, assign) CGFloat iconImgViewWidth;
@property (nonatomic, assign) CGFloat iconImgViewHeight;

@property (nonatomic, strong) UIImageView *animateImgView;
@property (nonatomic, strong) UIImageView *iconImgView;
@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation ZGWKWebNoDataView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _iconImgViewWidth = 175.0;
        _iconImgViewHeight = _iconImgViewWidth;
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)]];
        
        _animateImgView = [[UIImageView alloc] init];
        _animateImgView.hidden = YES;
        _animateImgView.contentMode = UIViewContentModeCenter;
        NSInteger imgsCount = 17;
        _animateImgView.animationDuration = imgsCount * 0.1;
        NSMutableArray *imgsAry = [NSMutableArray arrayWithCapacity:20];
        // 此处待处理
        //        for (int i=1; i<=imgsCount; i++) {
        //            UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"kid_common_animation_release_%zd",i]];
        //            [imgsAry addObject:img];
        //        }
        _animateImgView.animationImages = imgsAry;
        [self addSubview:_animateImgView];
        
        _iconImgView = [[UIImageView alloc] init];
        _iconImgView.image = [UIImage imageNamed:@"vak_home_no_record"];
        //        _iconImgView.backgroundColor = [UIColor redColor];
        [self addSubview:_iconImgView];
        
        _textLabel = [[UILabel alloc] init];
        _textLabel.textColor = [UIColor blackColor];
        _textLabel.font = [UIFont systemFontOfSize:12];
        _textLabel.text = @"这里空空哒";
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
    _animateImgView.frame = self.bounds;
    _iconImgView.frame = CGRectMake((self.bounds.size.width-self.iconImgViewWidth)/2.0, 0, self.iconImgViewWidth, self.iconImgViewHeight);
    CGFloat textHeight = [self.textLabel.text boundingRectWithSize:CGSizeMake(self.bounds.size.width, 40) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.textLabel.font} context:nil].size.height;
    _textLabel.frame = CGRectMake(0, CGRectGetMaxY(_iconImgView.frame)+16, self.bounds.size.width, textHeight);
    
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

#pragma mark - setter
- (void)setImage:(UIImage *)image text:(NSString *)text
{
    if (image) {
        self.iconImgView.image = image;
    }else {
        self.iconImgView.image = [UIImage imageNamed:@"vak_home_no_record"];
    }
    self.textLabel.text = text;
}

- (void)setImage:(UIImage *)image attributeText:(NSAttributedString *)attributeText
{
    if (image) {
        self.iconImgView.image = image;
    }else {
        self.iconImgView.image = [UIImage imageNamed:@"vak_home_no_record"];
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

#pragma mark -
- (void)updateWithTotalCount:(NSInteger)totalCount model:(ZGWKWebNoDataViewModel *)model
{
    // 特殊code 处理
    if(model.code != 0){
        if (model.code == -100) {
            [self setImage:nil text:@"登录身份过期，请重新登录"];
        }else {
            [self setImage:nil text:model.message];
        }
    }else {
        [self setImage:nil text:@"这里空空哒"];
    }
    
    // 如果有error
    if (model.error) {
        [self setImage:[UIImage imageNamed:@"kid_pic_network_error"] text:@"当前网络太差，请点击刷新重试"];
    }
    
    if (totalCount == 0) {
        self.hidden = NO;
    }else {
        self.hidden = YES;
    }
}

#pragma mark - animateImgView
- (void)showAnimateImgViewWithIsEmpty:(BOOL)isEmpty
{
    if (isEmpty) {
        self.hidden = NO;
        self.animateImgView.hidden = NO;
        [self.animateImgView startAnimating];
        self.iconImgView.hidden = YES;
        self.textLabel.hidden = YES;
    }
}


- (void)hiddenAnimateImgView
{
    self.hidden = YES;
    self.animateImgView.hidden = YES;
    [self.animateImgView stopAnimating];
    self.iconImgView.hidden = NO;
    self.textLabel.hidden = NO;
}

@end
