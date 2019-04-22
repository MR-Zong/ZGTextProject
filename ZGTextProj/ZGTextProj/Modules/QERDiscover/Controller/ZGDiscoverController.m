//
//  ZGDiscoverController.m
//  ZGTextProj
//
//  Created by ali on 2019/2/27.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGDiscoverController.h"
#import <MJRefresh/MJRefresh.h>
#import "ZGShuoCell.h"
#import "ZGLevitateView.h"
#import "ZGDiscoverConst.h"
#import "ZGShuoModel.h"
#import "ZGDiscoverConst.h"

#import "ZGShuoDetailController.h"
#import "ZGLevitateView.h"

@interface ZGDiscoverController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *shuosAry;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, strong) ZGLevitateView *levitateView;

@end

@implementation ZGDiscoverController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(doTimer) userInfo:nil repeats:YES];
    
    SEL sl = @selector(viewDidDisappear:);
    NSLog(@"sl %d",sl);
    [self initialze];
    [self setupViews];
}

- (void)initialze
{
    self.view.backgroundColor = [UIColor whiteColor];
    _shuosAry = [NSMutableArray array];
    for (int i=0; i<2; i++) {
        ZGShuoModel *shuoModel = [[ZGShuoModel alloc] init];
        shuoModel.content = @"拉大锯垃圾地方阿里积分滤镜的疯狂夺金了圣诞节疯狂了的设计费两地分居施蒂利克福建省的楼上的减肥的酸辣粉";
        shuoModel.hashTag = @"#我想听你说晚安";
        [_shuosAry addObject:shuoModel];
    }
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
    [_tableView registerClass:[ZGShuoCell class] forCellReuseIdentifier:@"ZGDiscoverCellReusedId"];
    MJRefreshHeader *header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(didRefresh)];
    _tableView.mj_header = header;
    _tableView.mj_footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(didLoadMore)];
    [self.view addSubview:_tableView];
    
    _levitateView = [[ZGLevitateView alloc] initWithFrame:CGRectMake(10, ZG_SCREEN_H-52-44-8, 187, 52)];
    [self.view addSubview:_levitateView];
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
    return self.shuosAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZGShuoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZGDiscoverCellReusedId"];
    cell.shuoModel = self.shuosAry[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZGShuoModel *shuoModel = [self.shuosAry objectAtIndex:indexPath.row];
    if (shuoModel.rowHeight > 0) {
        return shuoModel.rowHeight;
    }
    shuoModel.rowHeight = [ZGShuoCell tableView:tableView heightForRowAtIndexPath:indexPath withObject:shuoModel];
    
    return shuoModel.rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    ZGShuoModel *shuoModel = [self.shuosAry objectAtIndex:indexPath.row];

    ZGShuoDetailController *shuoDetailVC = [[ZGShuoDetailController alloc] init];
    shuoDetailVC.shuo_id = shuoModel.shuo_id;
    [self.navigationController pushViewController:shuoDetailVC animated:YES];
}

#pragma mark - doTimer
- (void)doTimer
{
    self.progress += 0.05;
    NSLog(@"progress %f",self.progress);
    ZGShuoCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.progress = self.progress;
}

@end
