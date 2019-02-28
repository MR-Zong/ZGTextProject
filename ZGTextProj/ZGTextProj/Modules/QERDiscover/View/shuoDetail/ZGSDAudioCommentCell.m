//
//  ZGSDAudioCommentCell.m
//  ZGTextProj
//
//  Created by ali on 2019/2/27.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGSDAudioCommentCell.h"
#import "ZGCornerView.h"

@interface ZGSDAudioView : ZGCornerView

@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, strong) UIImageView *playImgView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UILabel *durationLabel;


@end

@implementation ZGSDAudioView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _cornerRadius_topRight = 10;
        _cornerRadius_topLeft = 2;
        _cornerRadius_bottomRight = 10;
        _cornerRadius_bottomLeft = 10;
        
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor greenColor].CGColor];
        _gradientLayer.locations = @[@0.1, @1.0];
        _gradientLayer.startPoint = CGPointMake(0, 0);
        _gradientLayer.endPoint = CGPointMake(1.0, 0);
        [self.layer addSublayer:_gradientLayer];
        
        _playImgView = [[UIImageView alloc] init];
        [self addSubview:_playImgView];
        
        _tipLabel = [[UILabel alloc] init];
        [self addSubview:_tipLabel];
        
        _durationLabel = [[UILabel alloc] init];
        [self addSubview:_durationLabel];

    }
    return self;
}

@end


#pragma mark --- - - - - - -  - -

@interface ZGSDAudioCommentCell ()
@property (nonatomic, strong) ZGSDAudioView *audioView;
@end

@implementation ZGSDAudioCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _audioView = [[ZGSDAudioView alloc] init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(audioViewPressed:)];
        [_audioView addGestureRecognizer:tap];

        [self.containView addSubview:_audioView];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

+ (CGSize)containViewSizeWithObject:(ZGSDCommentModel *)model
{
    return CGSizeMake(100, 40);
}

#pragma mark - - - -
- (void)audioViewPressed:(UITapGestureRecognizer *)tap
{
    ;
}

#pragma mark - - - -
- (void)setCommentModel:(ZGSDCommentModel *)commentModel
{
    [super setCommentModel:commentModel];
}

@end
