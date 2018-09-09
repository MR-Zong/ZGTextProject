//
//  ZGVAKDiscoverReusableViewFooter.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/9/9.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGVAKDiscoverReusableViewFooter.h"

@implementation ZGVAKDiscoverReusableViewFooter

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 1)];
        _lineView.backgroundColor = [UIColor grayColor];
        [self addSubview:_lineView];
    }
    return self;
}

@end
