//
//  ZGSDMorePopView.m
//  ZGTextProj
//
//  Created by ali on 2019/2/28.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGSDMorePopView.h"
#import "ZGDiscoverConst.h"
#import <Masonry.h>

@interface ZGSDMorePopViewMaskView : UIView

@property (nonatomic, copy) void(^didTouchBlock)(void);
@end

@implementation ZGSDMorePopViewMaskView
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_didTouchBlock) {
        _didTouchBlock();
    }
}
@end

@interface ZGSDMorePopViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation ZGSDMorePopViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_lineView];
        
        // auto layout
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
            make.height.equalTo(@1);
        }];
    }
    return self;
}
@end


@interface ZGSDMorePopView () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) ZGSDMorePopViewMaskView *maskView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZGSDCommentModel *commentModel;
@property (nonatomic, strong) NSArray *optionsAry;
@end

@implementation ZGSDMorePopView

- (instancetype)initWithCommentModel:(ZGSDCommentModel *)commentModel
{
    if (self = [super init]) {
        
        _commentModel = commentModel;
        
         _optionsAry = @[@"分享",@"举报",@"取消"];
        
        _maskView = [[ZGSDMorePopViewMaskView alloc] init];
        _maskView.backgroundColor = [UIColor blackColor];
        __weak typeof(self) weakSelf = self;
        [_maskView setDidTouchBlock:^{
            [weakSelf dismiss];
        }];
        
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 48;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[ZGSDMorePopViewCell class] forCellReuseIdentifier:@"ZGSDMorePopViewCellReusedId"];
        [self addSubview:_tableView];
        
        // auto layout
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.optionsAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZGSDMorePopViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZGSDMorePopViewCellReusedId"];
    cell.titleLabel.text = self.optionsAry[indexPath.row];
    if (indexPath.row == self.optionsAry.count - 1) {
        cell.lineView.hidden = YES;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSString *op = self.optionsAry[indexPath.row];
    if (self.selectedBlock) {
        self.selectedBlock(self.commentModel, op);
    }
//    if ([op isEqualToString:@"分享"]) {
//        ;
//    }else if ([op isEqualToString:@"举报"]) {
//        ;
//    }else if ([op isEqualToString:@"取消"]) {
//        ;
//    }
    
}

- (void)showInWindow:(UIView *)window moreBtn:(nonnull UIButton *)moreBtn
{
    if (self.superview) {
        return;
    }
    
    self.maskView.frame = window.bounds;
    [window addSubview:self.maskView];
    
    CGRect windowFrame =  [moreBtn convertRect:moreBtn.bounds toView:window];
    CGFloat width = 128;
    CGFloat height = 146;
    CGFloat rightMargin = 18;
    CGFloat bottomMargin = 18;
    CGFloat withMoreBtnSpace = 20;
    CGFloat x = ZG_SCREEN_W - width - rightMargin;
    CGFloat y = windowFrame.origin.y - withMoreBtnSpace - height;
    if ( ZG_SCREEN_H- CGRectGetMaxY(windowFrame)  > withMoreBtnSpace + height + bottomMargin) {
        y = CGRectGetMaxY(windowFrame) + withMoreBtnSpace;
    }
    self.frame = CGRectMake(x, y, width, height);
    [window addSubview:self];
}

- (void)dismiss
{
    if (self.superview) {
        [self.maskView removeFromSuperview];
        [self removeFromSuperview];
    }
}


@end
