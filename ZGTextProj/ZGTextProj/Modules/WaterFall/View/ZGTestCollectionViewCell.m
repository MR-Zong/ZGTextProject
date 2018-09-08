//
//  ZGTestCollectionViewCell.m
//  ZGWaterfallCollectionViewLayout
//
//  Created by Zong on 16/3/7.
//  Copyright © 2016年 Zong. All rights reserved.
//

#import "ZGTestCollectionViewCell.h"

@implementation ZGTestCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UILabel *titleLabel = [[UILabel alloc] init];
        self.titleLabel = titleLabel;
        [self.contentView addSubview:titleLabel];
    }
    return self;
}

@end
