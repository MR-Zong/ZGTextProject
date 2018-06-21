//
//  ZGHeaderCollectionViewCell.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/6/21.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGHeaderCollectionViewCell.h"

@implementation ZGHeaderCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor greenColor];
        
        _hView = [[ZGTopicHeaderView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.contentView addSubview:_hView];
        
    }
    
    return self;
}

- (void)setDesc:(NSString *)desc
{
    _desc = desc;
    
    CGFloat textHeight = [desc boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 30, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
    textHeight = ceil(textHeight) + 1;
    
    self.hView.textHeight = textHeight;

}

- (void)setIsExtend:(BOOL)isExtend
{
    _isExtend = isExtend;
    
    self.hView.isExtend = isExtend;
}



@end
