//
//  ZGNSPCollectionViewCell.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/4/7.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGNSPCollectionViewCell.h"

@implementation ZGNSPCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _titleLael = [[UILabel alloc] init];
        _titleLael.textAlignment = NSTextAlignmentCenter;
        _titleLael.font = [UIFont systemFontOfSize:18];
        _titleLael.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:_titleLael];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLael.frame = self.bounds;
}

@end
