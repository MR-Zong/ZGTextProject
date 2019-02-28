//
//  ZGDiscoverCell.m
//  ZGTextProj
//
//  Created by ali on 2019/2/27.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGShuoCell.h"
#import "ZGShuoTopView.h"
#import "ZGShuoBottomView.h"
#import "ZGCommentShowView.h"
#import "ZGShuoTextShowView.h"
#import <Masonry.h>
#import "ZGDiscoverConst.h"

@interface ZGShuoCell ()

@property (nonatomic, strong) ZGShuoTopView *topView;
@property (nonatomic, strong) ZGShuoBottomView *bottomView;
@property (nonatomic, strong) ZGCommentShowView *commentShuoView;
@property (nonatomic, strong) ZGShuoTextShowView *textShowView;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation ZGShuoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _topView = [[ZGShuoTopView alloc] init];
        [self.contentView addSubview:_topView];
        
        _commentShuoView = [[ZGCommentShowView alloc] init];
        [self.contentView addSubview:_commentShuoView];
        
        _textShowView = [[ZGShuoTextShowView alloc] init];
        [self.contentView addSubview:_textShowView];
        
        _bottomView = [[ZGShuoBottomView alloc] init];
        [self.contentView addSubview:_bottomView];
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor darkGrayColor];
        [self.contentView addSubview:_lineView];
        
        // auto layout
        [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(18.f);
            make.right.equalTo(self.contentView).offset(-18.f);
            make.height.equalTo(@40);
        }];
        
        [_commentShuoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-18.f);
            make.left.equalTo(self.contentView).offset(18.f);
            make.top.equalTo(self.topView.mas_bottom).offset(7.f);
            make.bottom.equalTo(self.bottomView.mas_top).offset(0);
        }];
        
        [_textShowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topView.mas_bottom).offset(10.f);
            make.bottom.equalTo(self.bottomView.mas_top).offset(-16.f);
            make.right.equalTo(self.contentView).offset(-18.f);
            make.left.equalTo(self.contentView).offset(18.f);
        }];
        
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.lineView.mas_top);
            make.height.equalTo(@64);
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
        }];
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView);
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.height.equalTo(@6);
        }];
    }
    return self;
}

#pragma mark -
- (void)setShuoModel:(ZGShuoModel *)shuoModel
{
    _shuoModel = shuoModel;
    self.topView.shuoModel = shuoModel;
    self.textShowView.shuoModel = shuoModel;
    self.bottomView.shuoModel = shuoModel;
    self.commentShuoView.shuoModel = shuoModel;
}

#pragma mark -
+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath withObject:(ZGShuoModel *)model
{
    CGFloat textHeight = [model.content boundingRectWithSize:CGSizeMake(ZG_SCREEN_W - 36, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size.height;
    NSLog(@"text_h %f",textHeight);
    if (textHeight > 64) {
        textHeight = 64;
    }
    return 6 + 40 + 64 + 12 + 10 + 16 + textHeight + 20;
}

@end
