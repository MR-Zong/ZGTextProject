//
//  ZGMsgCountDownView.m
//  ZGTextProj
//
//  Created by ali on 2019/2/15.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGMsgCountDownView.h"

@interface ZGMsgCountDownView ()

@property (nonatomic, strong) UIImageView *iconImgView;
@property (nonatomic, strong) UIView *seperatView;
@property (nonatomic, strong) UILabel *daysLabel;

@end

@implementation ZGMsgCountDownView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _iconImgView = [[UIImageView alloc] init];
        [self addSubview:_iconImgView];
        
        _seperatView = [[UIView alloc] init];
        [self addSubview:_seperatView];
        
        _daysLabel = [[UILabel alloc] init];
        [self addSubview:_daysLabel];
        
        // auto layout
    }
    return self;
}

- (void)setCountDownDays:(NSInteger)days
{
    ;
}
@end
