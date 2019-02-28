//
//  ZGSDTextCommentCell.m
//  ZGTextProj
//
//  Created by ali on 2019/2/27.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGSDTextCommentCell.h"
#import <Masonry.h>

@interface ZGSDTextCommentCell ()

@property (nonatomic, strong) UILabel *commentLabel;

@end

@implementation ZGSDTextCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.font = [UIFont systemFontOfSize:18];
        [self.containView addSubview:_commentLabel];
        
        // auto layout
        [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.containView);
        }];
    }
    return self;
}

- (void)setCommentModel:(ZGSDCommentModel *)commentModel
{
    [super setCommentModel:commentModel];
    self.commentLabel.text = @"899";
}

+ (CGSize)containViewSizeWithObject:(ZGSDCommentModel *)model
{
    return CGSizeMake(100, 30);
}
@end
