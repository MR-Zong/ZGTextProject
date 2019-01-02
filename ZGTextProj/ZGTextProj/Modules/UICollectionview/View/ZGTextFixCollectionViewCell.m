//
//  ZGTextFixCollectionViewCell.m
//  ZGTextProj
//
//  Created by ali on 2018/12/14.
//  Copyright © 2018 XuZonggen. All rights reserved.
//

#import "ZGTextFixCollectionViewCell.h"

@interface ZGTextFixCollectionViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ZGTextFixCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor redColor];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:25];
        [self.contentView addSubview:_titleLabel];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = self.contentView.bounds;
}

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    
    self.titleLabel.text = [NSString stringWithFormat:@"%zd",indexPath.item];
}

@end
