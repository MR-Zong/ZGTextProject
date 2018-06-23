//
//  ZGAniTextCell.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/6/23.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGAniTextCell.h"

@implementation ZGAniTextCellModel

- (void)setText:(NSString *)text
{
    _text = text;
    
    self.textHeight = [text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height + 1;
    
}
@end

#pragma mark -  - - - -  -  - - - -- - - - -

@interface ZGAniTextCell ()

@property (nonatomic, strong) UILabel *descLabel;

@end


@implementation ZGAniTextCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor purpleColor];
        self.layer.masksToBounds = YES;
        
        _descLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _descLabel.font = [UIFont systemFontOfSize:15];
        _descLabel.numberOfLines = 0;
        [self.contentView addSubview:_descLabel];
        
    }
    return self;
}

- (void)setModel:(ZGAniTextCellModel *)model
{
    _model = model;
    
    self.descLabel.text = model.text;
    self.descLabel.frame = CGRectMake(0, 0, self.bounds.size.width, model.textHeight);
}

@end
