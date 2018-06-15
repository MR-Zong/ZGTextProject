//
//  SMTopicHeaderView.m
//  Sleep
//
//  Created by 徐宗根 on 2018/6/14.
//  Copyright © 2018年 Kugou. All rights reserved.
//

#import "SMTopicHeaderView.h"

CGFloat SMTopicHeaderViewBaseHeight = 328; // 364
CGFloat SMTopicHeaderViewBaseTextHeight = 36;

@interface SMTopicHeaderConttentView : UIView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIView *containLabelView;
@property (nonatomic, strong) UIButton *extendBtn;

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) UIButton *downLoadBtn;
@property (nonatomic, strong) UIButton *playAllBtn;

@property (nonatomic, assign) CGFloat textHeight;

@end


@implementation SMTopicHeaderConttentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _textHeight = SMTopicHeaderViewBaseTextHeight;
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"专题简介";
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_titleLabel];
        
        _containLabelView = [[UIView alloc] init];
        _containLabelView.layer.masksToBounds = YES;
        [self addSubview:_containLabelView];

        _descLabel = [[UILabel alloc] init];
        _descLabel.userInteractionEnabled = YES;
        _descLabel.text = @"所谓专题，是指针对某个特定对象而特别收集制作而成的一种集中作品，这个对象可以是具体的某个或某集所谓专题，是指针对某个特定对象而特别收集制作而成的一种集中作品，这个对象可以是具体的某个或某集";
        _descLabel.textColor = [UIColor blackColor];
        _descLabel.font = [UIFont systemFontOfSize:14];
        _descLabel.numberOfLines = 0;
        [_containLabelView addSubview:_descLabel];
        
        _extendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _extendBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_extendBtn setTitle:@"展开" forState:UIControlStateNormal];
        [_extendBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self addSubview:_extendBtn];
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor darkGrayColor];
        [self addSubview:_lineView];
        
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareBtn.backgroundColor = [UIColor redColor];
        [_shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _shareBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
        [self addSubview:_shareBtn];
        
        _downLoadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_downLoadBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _downLoadBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_downLoadBtn setTitle:@"下载" forState:UIControlStateNormal];
        [self addSubview:_downLoadBtn];
        
        _playAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playAllBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _playAllBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_playAllBtn setTitle:@"全部播放" forState:UIControlStateNormal];
        [self addSubview:_playAllBtn];
        
        // set frame
        [self updateSubViewsFrame];


    }
    return self;
}

- (void)updateSubViewsFrame
{
    CGFloat CXTLeftMarginFloat = 15;
    // set frame
    _titleLabel.frame = CGRectMake(CXTLeftMarginFloat, 15, [UIScreen mainScreen].bounds.size.width - 15 - 25, 14);
    CGFloat containViewHeight = _textHeight;
    if (_textHeight == SMTopicHeaderViewBaseTextHeight) {
        containViewHeight -= 1;
    }
    _containLabelView.frame = CGRectMake(CXTLeftMarginFloat, CGRectGetMaxY(_titleLabel.frame)+14, _titleLabel.frame.size.width, containViewHeight);
    
    CGFloat realTextHeight = [_descLabel.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 30, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
    _descLabel.frame = CGRectMake(0, 0, _containLabelView.frame.size.width, realTextHeight);
//    _descLabel.backgroundColor = [UIColor redColor];
    
    
    CGFloat extendBtnX = CGRectGetMaxX(_containLabelView.frame) - 44;
    _extendBtn.frame = CGRectMake(extendBtnX, _containLabelView.frame.origin.y+16, 44, 20);
    _lineView.frame = CGRectMake(CXTLeftMarginFloat, _containLabelView.frame.origin.y + _textHeight +20, _titleLabel.frame.size.width, 1);
    
    CGFloat btnWidth = [UIScreen mainScreen].bounds.size.width / 3.0;
    CGFloat btnHeight = 75;
    _shareBtn.frame = CGRectMake(0, CGRectGetMaxY(_lineView.frame), btnWidth, btnHeight);
    _downLoadBtn.frame = CGRectMake(CGRectGetMaxX(_shareBtn.frame), CGRectGetMaxY(_lineView.frame), btnWidth, btnHeight);
    _playAllBtn.frame = CGRectMake(CGRectGetMaxX(_downLoadBtn.frame), CGRectGetMaxY(_lineView.frame), btnWidth, btnHeight);
}

@end

#pragma mark - - - -- -- --- - - - -
@interface SMTopicHeaderView ()

@property (nonatomic, strong) UIImageView *coverImgView;
@property (nonatomic, strong) SMTopicHeaderConttentView *contentView;

@end


@implementation SMTopicHeaderView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor orangeColor];
        
        _textHeight = SMTopicHeaderViewBaseTextHeight;
        
        _coverImgView = [[UIImageView alloc] init];
        _coverImgView.image = [UIImage imageNamed:@"kid_pic_topic_default"];
        _contentView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_coverImgView];
        
        _contentView = [[SMTopicHeaderConttentView alloc] init];
        _contentView.backgroundColor = [UIColor purpleColor];
        _contentView.layer.masksToBounds = YES;
        [_contentView.extendBtn addTarget:self action:@selector(didExtendBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView.shareBtn addTarget:self action:@selector(didShareBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView.downLoadBtn addTarget:self action:@selector(didDownLoadBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView.playAllBtn addTarget:self action:@selector(didPlayAllBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView.descLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTouchDescLabel)]];
        [self addSubview:_contentView];
        
        // set frame
        _coverImgView.frame = CGRectMake(0, 0, self.bounds.size.width, 200);

        CGFloat contentViewY = CGRectGetMaxY(_coverImgView.frame) - 10;
        _contentView.frame = CGRectMake(0, contentViewY, _coverImgView.frame.size.width, SMTopicHeaderViewBaseHeight - 190 + _textHeight);
        }
    return self;
}



- (void)setTextHeight:(CGFloat)textHeight
{
    _textHeight = textHeight;
    
    self.contentView.textHeight = textHeight;
    
    // set frame
    CGRect tmpF = self.contentView.frame;
    tmpF.size.height = SMTopicHeaderViewBaseHeight -190 + self.textHeight;
    [UIView animateWithDuration:0.25 animations:^{
        [self.contentView updateSubViewsFrame];
        self.contentView.frame = tmpF;
        
    }completion:^(BOOL finished) {
        if (finished) {
            if (textHeight == SMTopicHeaderViewBaseTextHeight) {
                self.contentView.extendBtn.hidden = NO;
            }
        }
    }];
    
    // auto layout
//    [self.contentView.containLabelView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@(_textHeight));
//    }];
//
//    [UIView animateWithDuration:0.25 animations:^{
//        [self layoutIfNeeded];
//        // setNeedsLayout 不会做动画
////        [self setNeedsLayout];
//    }completion:^(BOOL finished) {
//        if (finished) {
//            if (textHeight == SMTopicHeaderViewBaseTextHeight) {
//                self.contentView.extendBtn.hidden = NO;
//            }
//        }
//    }];

}

- (void)didTouchDescLabel
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(topicHeaderView:didDescLabelWithExtendBtn:)]) {
        [self.delegate topicHeaderView:self didDescLabelWithExtendBtn:self.contentView.extendBtn];
    }
}

#pragma mark - action
- (void)didExtendBtn:(UIButton *)btn
{
    btn.hidden = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(topicHeaderView:didExtendBtn:)]) {
        [self.delegate topicHeaderView:self didExtendBtn:btn];
    }
}

- (void)didShareBtn:(UIButton *)btn
{
    ;
}

- (void)didDownLoadBtn:(UIButton *)btn
{
    ;
}

- (void)didPlayAllBtn:(UIButton *)btn
{
    ;
}

@end
