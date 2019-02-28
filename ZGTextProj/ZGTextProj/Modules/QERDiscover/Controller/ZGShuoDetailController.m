//
//  ZGShuoDetailController.m
//  ZGTextProj
//
//  Created by ali on 2019/2/27.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGShuoDetailController.h"
#import "ZGSDTableHeader.h"
#import <MJRefresh.h>
#import "ZGSDAudioCommentCell.h"
#import "ZGSDTextCommentCell.h"
#import "ZGDiscoverConst.h"
#import "ZGSDMorePopView.h"
#import "ZGSDBottomView.h"

@interface ZGShuoDetailController () <UITableViewDelegate,UITableViewDataSource,ZGSDBottomViewDelegate,ZGSDBaseComentCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZGSDTableHeader *tbHeader;
@property (nonatomic, strong) ZGSDBottomView *bottomView;

@end

@implementation ZGShuoDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialze];
    [self setupViews];
}

- (void)initialze
{
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupViews
{
    // tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64.0, ZG_SCREEN_W, ZG_SCREEN_H - 64.0)];
    //    _tableView.backgroundColor = [UIColor redColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [_tableView registerClass:[ZGSDAudioCommentCell class] forCellReuseIdentifier:@"ZGSDAudioCommentCellReusedId"];
    [_tableView registerClass:[ZGSDTextCommentCell class] forCellReuseIdentifier:@"ZGSDTextCommentCellReusedId"];
    MJRefreshHeader *header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(didRefresh)];
    _tableView.mj_header = header;
    _tableView.mj_footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(didLoadMore)];
    [self.view addSubview:_tableView];
    
    ZGSDTableHeader *tbHeader = [[ZGSDTableHeader alloc] initWithFrame:CGRectMake(0, 0, ZG_SCREEN_W, 100)];
    _tableView.tableHeaderView = tbHeader;
    
    // bottomView
    CGFloat bottomHeight = 100;
    _bottomView = [[ZGSDBottomView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame) - bottomHeight, _tableView.bounds.size.width, bottomHeight)];
    _bottomView.delegate = self;
    [self.view addSubview:_bottomView];
}

#pragma mark -
- (void)didRefresh
{
    ;
}

- (void)didLoadMore
{
    ;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZGSDAudioCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZGSDAudioCommentCellReusedId"];
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZGSDCommentModel *commentModel = nil;//[self.shuosAry objectAtIndex:indexPath.row];
    if (commentModel.rowHeight > 0) {
        return commentModel.rowHeight;
    }
    commentModel.rowHeight = [ZGSDBaseComentCell tableView:tableView heightForRowAtIndexPath:indexPath withObject:commentModel];
    
    return commentModel.rowHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ZGSDTableSectionHeader *sh = [[ZGSDTableSectionHeader alloc] initWithFrame:CGRectMake(0, 0, 0, 68)];
    sh.titleLabel.text = @"评论 42";
    return sh;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 68;
}

#pragma mark - ZGSDBottomViewDelegate
- (void)bottomView:(ZGSDBottomView *)bottomView didRecordBtn:(UIButton *)btn
{
    ;
}

#pragma mark - ZGSDBaseComentCellDelegate
- (void)commentCell:(ZGSDBaseComentCell *)cell didTouchMoreBtn:(UIButton *)btn
{
    ZGSDMorePopView *popView = [[ZGSDMorePopView alloc] initWithCommentModel:cell.commentModel];
    [popView showInWindow:self.view.window moreBtn:btn];
}

- (void)commentCell:(ZGSDBaseComentCell *)cell didTouchHeaderWithModel:(ZGSDCommentModel *)model
{
    ;
}

- (void)commentCell:(ZGSDBaseComentCell *)cell didTouchContainViewWithModel:(ZGSDCommentModel *)model
{
    ;
}

@end
