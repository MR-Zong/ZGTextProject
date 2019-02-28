//
//  ZGSDBaseComentCell.m
//  ZGTextProj
//
//  Created by ali on 2019/2/27.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGSDBaseComentCell.h"
#import <Masonry.h>
#import "ZGSDAudioCommentCell.h"
#import "ZGSDTextCommentCell.h"


@implementation ZGSDBaseComentCellBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _textLabel = [[UILabel alloc] init];
        _textLabel.text = @"2小时前";
        [self addSubview:_textLabel];
        
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_moreBtn];
        
        // auto layout
        [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.centerY.equalTo(self);
            make.height.equalTo(@20);
            make.right.equalTo(self.moreBtn.mas_left).offset(-20.f);
        }];
        
        [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.centerY.equalTo(self);
            make.height.equalTo(@32);
            make.width.equalTo(@60);
        }];
    }
    return self;
}

@end


#pragma mark -
@interface ZGSDBaseComentCell ()


@end

@implementation ZGSDBaseComentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _headerImgView = [[UIImageView alloc] init];
        _headerImgView.userInteractionEnabled = YES;
        [_headerImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTouchHeader)]];
        [self.contentView addSubview:_headerImgView];
        
        _containView = [[UIView alloc] init];
         [_containView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTouchContain)]];
        [self.contentView addSubview:_containView];
        
        _bottomView = [[ZGSDBaseComentCellBottomView alloc] init];
        [_bottomView.moreBtn addTarget:self action:@selector(didMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_bottomView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _headerImgView.frame = CGRectMake(18, 11, 24, 24);
    CGSize containViewSize = [self.class containViewSizeWithObject:self.commentModel];
    CGFloat contianViewX = CGRectGetMaxX(_headerImgView.frame)+16;
    _containView.frame = CGRectMake(contianViewX, _headerImgView.frame.origin.y, containViewSize.width, containViewSize.height);
    _bottomView.frame = CGRectMake(contianViewX, self.bounds.size.height - 32, self.bounds.size.width - contianViewX - 18, 32);
}

+ (CGSize)containViewSizeWithObject:(ZGSDCommentModel *)model
{
    return CGSizeMake(100, 30);
}

+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath withObject:(ZGSDCommentModel *)model
{
    // 区分类型
    CGSize containSize;
    if (1) {
        containSize = [ZGSDTextCommentCell containViewSizeWithObject:model];
    }
    return containSize.height + 32 + 11;
}

#pragma mark - action
- (void)didMoreBtn:(UIButton *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(commentCell:didTouchMoreBtn:)]) {
        [self.delegate commentCell:self didTouchMoreBtn:btn];
    }
}

- (void)didTouchHeader
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(commentCell:didTouchHeaderWithModel:)]) {
        [self.delegate commentCell:self didTouchHeaderWithModel:self.commentModel];
    }
}

- (void)didTouchContain
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(commentCell:didTouchContainViewWithModel:)]) {
        [self.delegate commentCell:self didTouchContainViewWithModel:self.commentModel];
    }
}

@end
