//
//  ZGAniTextCell.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/6/23.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGAniTextCell.h"

@implementation ZGAniTextCellModel

- (void)setText:(NSString *)text
{
    _text = text;
    
    self.textHeight = [text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height + 1;
    
}
@end

#pragma mark -  - - - -  -  - - - -- - - - -

@interface ZGAniTextCell ()

@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIButton *extendBtn;

@property (nonatomic, strong) CADisplayLink *displayLink;

@end


@implementation ZGAniTextCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateUI)];
        _displayLink.paused = YES;
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        
        _containView = [[UIView alloc] initWithFrame:CGRectZero];
        _containView.backgroundColor = [UIColor purpleColor];
        _containView.layer.masksToBounds = YES;
        [self.contentView addSubview:_containView];
        
        _descLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _descLabel.font = [UIFont systemFontOfSize:15];
        _descLabel.numberOfLines = 0;
        [_containView addSubview:_descLabel];
        
        _extendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _extendBtn.userInteractionEnabled = NO;
        [_containView addSubview:_extendBtn];
//        _extendBtn.translatesAutoresizingMaskIntoConstraints = NO;
//
//        NSLayoutConstraint *bottomLayout = [NSLayoutConstraint constraintWithItem:_extendBtn attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
//
//        NSLayoutConstraint *leftLayout = [NSLayoutConstraint constraintWithItem:_extendBtn attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
//
//        NSLayoutConstraint *rightLayout = [NSLayoutConstraint constraintWithItem:_extendBtn attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
//
//        NSLayoutConstraint *heightLayout = [NSLayoutConstraint constraintWithItem:_extendBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:30];
//
//        [self.contentView addConstraint:leftLayout];
//        [self.contentView addConstraint:rightLayout];
//        [self.contentView addConstraint:bottomLayout];
//        [_extendBtn addConstraint:heightLayout];
        
        _extendBtn.backgroundColor = [UIColor blueColor];
        _extendBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_extendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_extendBtn setTitle:@"展开" forState:UIControlStateNormal];
        
    }
    return self;
}


- (void)setModel:(ZGAniTextCellModel *)model
{
    // _model 没有值 可以验证是第一次
   
    _model = model;
    
    self.descLabel.text = model.text;
    self.descLabel.frame = CGRectMake(0, 0, self.bounds.size.width, model.textHeight);
    
    
    if (model.isExtend) {
        
        self.containView.frame = CGRectMake(0, 0, self.bounds.size.width, model.miniHeight);
        self.extendBtn.frame = CGRectMake(0, model.miniHeight - 40, self.bounds.size.width, 40);
    }else {
        self.containView.frame = CGRectMake(0, 0, self.bounds.size.width, model.textHeight);
        self.extendBtn.frame = CGRectMake(0, model.textHeight - 40, self.bounds.size.width, 40);
    }

    
    // animation
    self.displayLink.paused = NO;


}

- (void)updateUI
{
    if (self.model.isExtend) {
        [self extendAnimation];
    }else {
        [self backAnimation];
    }
    
}

- (void)extendAnimation
{
    [self containAnimationWithDuration:0.25 fromValue:self.model.miniHeight toValue:self.model.textHeight];
    [self btnAnimationWithDuration:0.25 fromValue:self.model.miniHeight - 40 toValue:self.model.textHeight - 40];
}

- (void)backAnimation
{
    [self containAnimationWithDuration:0.25 fromValue:self.model.textHeight toValue:self.model.miniHeight];
    [self btnAnimationWithDuration:0.25 fromValue:self.model.textHeight - 40 toValue:self.model.miniHeight - 40];
}


- (void)btnAnimationWithDuration:(CGFloat)duration fromValue:(CGFloat)fromValue toValue:(CGFloat)toValue
{
    CGFloat offsetY = (toValue - fromValue)/(duration*60);

    if (fabs(self.extendBtn.frame.origin.y -toValue) < 1) {
        return;
    }

    CGRect tmpF = self.extendBtn.frame;
    tmpF.origin.y += offsetY;
    self.extendBtn.frame = tmpF;
    
}


- (void)containAnimationWithDuration:(CGFloat)duration fromValue:(CGFloat)fromValue toValue:(CGFloat)toValue
{
    CGFloat offsetH = (toValue - fromValue)/(duration*60);

    if (fabs(self.containView.frame.size.height -toValue) < 1) {
        self.displayLink.paused = YES;
        return;
    }

    CGRect tmpF = self.containView.frame;
    tmpF.size.height += offsetH;
    self.containView.frame = tmpF;
    
}



@end
