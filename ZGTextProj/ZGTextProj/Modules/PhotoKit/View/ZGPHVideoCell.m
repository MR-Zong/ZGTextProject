//
//  ZGPHVideoCell.m
//  ZGTextProj
//
//  Created by ali on 2018/11/7.
//  Copyright © 2018 XuZonggen. All rights reserved.
//

#import "ZGPHVideoCell.h"

@interface ZGPHVideoCell ()


@end

@implementation ZGPHVideoCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _imgView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imgView.backgroundColor = [UIColor redColor];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.layer.masksToBounds = YES;
        [self.contentView addSubview:_imgView];
    }
    return self;
}

#pragma mark - setter
- (void)setPhAsset:(PHAsset *)phAsset
{
    _phAsset = phAsset;
    
}
@end
