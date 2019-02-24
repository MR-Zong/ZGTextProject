//
//  ZGMsgMenuPopView.m
//  ZGTextProj
//
//  Created by ali on 2019/2/15.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGMsgMenuPopView.h"
#import <Masonry/Masonry.h>

@interface ZGMsgMenuPopMaskView : UIView

@property (nonatomic, copy) void(^didTouchBlock)(void);
@end

@implementation ZGMsgMenuPopMaskView
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_didTouchBlock) {
        _didTouchBlock();
    }
}
@end

@interface ZGMsgMenuPopCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation ZGMsgMenuPopCell
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


#pragma mark - - - - - -  -
@interface ZGMsgMenuPopView () <UITableViewDelegate,UITableViewDataSource,CAAnimationDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZGMsgMenuPopMaskView *maskView;
@property (nonatomic, strong) NSArray *optionsAry;
@end

@implementation ZGMsgMenuPopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _optionsAry = @[@"删除好友",@"移出小黑屋",@"举报",@"取消"];
        
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        self.layer.anchorPoint = CGPointMake(1, 0);
        
        _maskView = [[ZGMsgMenuPopMaskView alloc] init];
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
        [_tableView registerClass:[ZGMsgMenuPopCell class] forCellReuseIdentifier:@"ZGMsgMenuPopCellReusedId"];
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
    ZGMsgMenuPopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZGMsgMenuPopCellReusedId"];
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
    if ([op isEqualToString:@"删除好友"]) {
        ;
    }else if ([op isEqualToString:@"移出小黑屋"]) {
        ;
    }else if ([op isEqualToString:@"举报"]) {
        ;
    }else if ([op isEqualToString:@"取消"]) {
        ;
    }

}


#pragma mark - process
- (void)showInView:(UIView *)view
{
    if (self.superview) {
        return;
    }
    
    self.maskView.frame = view.bounds;
    [view addSubview:self.maskView];
    
    CGFloat width = 128;
    CGFloat height = self.optionsAry.count*self.tableView.rowHeight;
    self.frame = CGRectMake(view.bounds.size.width - width -18, 64 - 6, width, height);
    self.alpha = 0;
    [view addSubview:self];
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1;
    }];
}

- (void)dismiss
{
    if (self.superview) {
        
        CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnim.delegate = self;
        scaleAnim.fromValue = @1;
        scaleAnim.toValue = @0.3;
        scaleAnim.duration = 0.25;
        [self.layer addAnimation:scaleAnim forKey:@"scaleAnimate"];
        
    }
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self.maskView removeFromSuperview];
    [self removeFromSuperview];
}
@end
