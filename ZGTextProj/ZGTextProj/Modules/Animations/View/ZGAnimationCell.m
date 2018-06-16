//
//  ZGAnimationCell.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/6/16.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGAnimationCell.h"

@implementation ZGAnimationCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor redColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(15, 0, 200, 40);
}
@end
