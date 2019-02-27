//
//  ZGShuoBaseCell.m
//  ZGTextProj
//
//  Created by ali on 2019/2/27.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGShuoBaseCell.h"

@interface ZGShuoBaseCell ()

@property (nonatomic, strong) UIView *progressView;

@end

@implementation ZGShuoBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _progressView = [[UIView alloc] init];
        [self.contentView addSubview:_progressView];
    }
    return self;
}
@end
