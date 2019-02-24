//
//  ZGReportPopView.m
//  ZGTextProj
//
//  Created by ali on 2019/2/15.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGReportPopView.h"
#import <Masonry/Masonry.h>

@interface ZGReportPopViewMaskView : UIView

@property (nonatomic, copy) void(^didTouchBlock)(void);
@end

@implementation ZGReportPopViewMaskView
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_didTouchBlock) {
        _didTouchBlock();
    }
}
@end

@interface ZGReportPopViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation ZGReportPopViewCell
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
            make.top.equalTo(self.contentView);
            make.height.equalTo(@1);
        }];
    }
    return self;
}
@end


#pragma mark - - - - - -  -
@interface ZGReportPopView () <UITableViewDelegate,UITableViewDataSource,CAAnimationDelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZGReportPopViewMaskView *maskView;
@property (nonatomic, strong) NSArray *optionsAry;
@end

@implementation ZGReportPopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _optionsAry = @[@"黄色言论",@"内容重复",@"涉嫌犯罪",@"其他"];
        
        self.layer.cornerRadius = 20;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        _maskView = [[ZGReportPopViewMaskView alloc] init];
        _maskView.backgroundColor = [UIColor blackColor];
        __weak typeof(self) weakSelf = self;
        [_maskView setDidTouchBlock:^{
            [weakSelf dismiss];
        }];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"举报的原因？";
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 48;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[ZGReportPopViewCell class] forCellReuseIdentifier:@"ZGReportPopViewCellReusedId"];
        [self addSubview:_tableView];
        
        // auto layout
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(18);
            make.height.equalTo(@20);
            make.left.equalTo(self).offset(18.f);
            make.right.equalTo(self).offset(-18.f);
        }];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(18.f);
            make.height.equalTo(@(self.tableView.rowHeight*self.optionsAry.count));
            make.left.equalTo(self).offset(18.f);
            make.right.equalTo(self).offset(-18.f);
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
    ZGReportPopViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZGReportPopViewCellReusedId"];
    cell.titleLabel.text = self.optionsAry[indexPath.row];
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
    
    CGFloat width = 300;
    CGFloat height = self.optionsAry.count*self.tableView.rowHeight + 76;
    self.frame = CGRectMake((view.bounds.size.width - width)/2.0, (view.bounds.size.height - height)/2.0, width, height);
    self.alpha = 0;
    [view addSubview:self];
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1;
    }];
}

- (void)dismiss
{
    if (self.superview) {
        
        self.alpha = 1;
        [UIView animateWithDuration:0.25 animations:^{
            self.alpha = 0;
        }completion:^(BOOL finished) {
            [self.maskView removeFromSuperview];
            [self removeFromSuperview];
        }];
        
    }
}


@end
