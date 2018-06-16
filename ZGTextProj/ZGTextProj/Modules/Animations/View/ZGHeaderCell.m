//
//  ZGHeaderCell.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/6/16.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGHeaderCell.h"

@implementation ZGHeaderCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor greenColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _hView = [[SMTopicHeaderView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.contentView addSubview:_hView];

    }
    
    return self;
}

@end
