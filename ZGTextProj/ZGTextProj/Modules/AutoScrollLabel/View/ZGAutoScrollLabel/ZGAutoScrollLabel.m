//
//  ZGAutoScrollLabel.m
//  ZGTextProj
//
//  Created by ali on 2018/10/25.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGAutoScrollLabel.h"


@interface ZGAutoScrollLabel ()

@property (nonatomic, strong) NSMutableArray <UILabel *>*labelsAry;
@property (nonatomic, assign) BOOL isAnimationing;
@property (nonatomic, assign) NSInteger numberOFLabels;


@end

@implementation ZGAutoScrollLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self initialize];
        [self setupViews];
    }
    return self;
}

- (void)initialize
{
    _numberOFLabels = 2;
    _scrollSpeed = 50;
}

- (void)setupViews
{
    _labelsAry = [NSMutableArray arrayWithCapacity:2];
    for (int i=0; i<_numberOFLabels; i++) {
        UILabel *lab = [[UILabel alloc] init];
        lab.font = [UIFont systemFontOfSize:15];
        lab.textColor = [UIColor whiteColor];
        [self addSubview:lab];
        [_labelsAry addObject:lab];
    }
}

- (void)strartAnimation
{
    [self startAnimationWithText:self.text];
}

- (void)startAnimationWithText:(NSString *)text
{
    if (self.text.length == 0) {
        return;
    }
    
    [self stopAnimation];
    
    [self layoutLabels];
    
    [self animation];
}

- (void)continueAnimation
{
    [self animation];
}

- (void)stopAnimation
{
    [self.layer removeAllAnimations];
}

-(void)reset{
    [self layoutLabels];
}

- (void)layoutLabels
{
    CGFloat labX = 0;
    for (UILabel *lab in self.labelsAry) {
        [lab sizeToFit];
        
        CGPoint center = lab.center;
        center.y = self.center.y - self.frame.origin.y;
        lab.center = center;
        
        CGRect tmpF = lab.frame;
        tmpF.origin.x = labX;
        lab.frame = tmpF;
        
        labX += lab.frame.size.width + self.spaceBetweenLabels;
    }
    
    CGSize size;
    size.width = self.labelsAry[0].frame.size.width + self.frame.size.width + self.spaceBetweenLabels;
    size.height = self.frame.size.height;
    self.contentSize = size;
    
    [self setContentOffset:CGPointMake(0,0) animated:NO];
    
    // If the label is bigger than the space allocated, then it should scroll
    if (self.labelsAry[0].frame.size.width > self.frame.size.width){
        for (int i = 1; i < self.numberOFLabels; ++i){
            self.labelsAry[i].hidden = NO;
        }
    }else{
        for (int i = 1; i < self.numberOFLabels; ++i){
            self.labelsAry[i].hidden = YES;
        }
        CGPoint center;
        center = self.labelsAry[0].center;
        center.x = self.center.x - self.frame.origin.x;
        self.labelsAry[0].center = center;
    }
}

- (void)animation
{
    if (self.labelsAry.firstObject.frame.size.width <= self.bounds.size.width) {
        return;
    }
    // initialize
    if (self.scrollDirection == ZGAutoScrollDirectionLeftToRight) {
        self.contentOffset = CGPointMake(0,0);
    }else if (self.scrollDirection == ZGAutoScrollDirectionRightToLeft){
        self.contentOffset = CGPointMake(self.labelsAry[0].frame.size.width + self.spaceBetweenLabels,0);
    }
    
    
    [UIView beginAnimations:@"autoScroll" context:@"移动"];
    [UIView setAnimationDuration:self.labelsAry[0].frame.size.width/self.scrollSpeed];
    if (self.pauseInterval == 0) {
        [UIView setAnimationRepeatCount:CGFLOAT_MAX];
    }
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    if (!self.isAnimationing) {
        self.isAnimationing = YES;
        [UIView setAnimationDelay:self.delayInterval];
    }
    [UIView setAnimationDelegate:self];
    [UIView setAnimationWillStartSelector:@selector(animationDidStart: context:)];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:)];
    
    if (self.scrollDirection == ZGAutoScrollDirectionLeftToRight) {
        self.contentOffset = CGPointMake(self.labelsAry[0].frame.size.width + self.spaceBetweenLabels,0);
    }else if (self.scrollDirection == ZGAutoScrollDirectionRightToLeft){
        self.contentOffset = CGPointMake(0,0);
    }
    
    [UIView commitAnimations];
}

#pragma mark -- 动画的代理方法
-(void)animationDidStart:(NSString *)animID context:(NSString*)context
{
    NSLog(@"动画开始的代理--%@",context);
}

-(void)animationDidStop:(NSString *)animID
{
    NSLog(@"动画结束--%@",animID);
    if (self.pauseInterval > 0) {
        if (self.labelsAry[0].frame.size.width > self.frame.size.width){
            [NSTimer scheduledTimerWithTimeInterval:self.pauseInterval target:self selector:@selector(strartAnimation) userInfo:nil repeats:NO];
        }
    }
}


#pragma mark - setter
- (void)setText:(NSString *)text
{
    _text = text;
    for (UILabel *lab in self.labelsAry) {
        
//        NSShadow *liShow = [[NSShadow alloc] init];
//        liShow.shadowBlurRadius = 3.0;
//        liShow.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
//        liShow.shadowOffset = CGSizeMake(0, 1);
//        NSAttributedString *at = [[NSAttributedString alloc] initWithString:text attributes:@{NSShadowAttributeName:liShow,NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont cairo_regular_with_size:10]}];
//        lab.attributedText = at;
                lab.text = text;
    }
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    
    for (UILabel *lab in self.labelsAry) {
        lab.font = font;
    }
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    
    for (UILabel *lab in self.labelsAry) {
        lab.textColor = textColor;
    }
}

@end
