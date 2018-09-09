//
//  ZGVAKDiscoverReusableViewHeader.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/9/9.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGVAKDiscoverReusableViewHeader.h"

@implementation ZGVAKDiscoverReusableViewHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor redColor];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.frame = CGRectMake(0, 0, 100, 20);
        [self addSubview:_titleLabel];
    }
    return self;
}

@end
