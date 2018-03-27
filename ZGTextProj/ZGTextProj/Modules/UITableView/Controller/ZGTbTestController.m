//
//  ZGTbTestController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/1/5.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGTbTestController.h"
#import "ZGTbBaseTableView.h"

@interface ZGTbTestController () <UITableViewDelegate,UITableViewDataSource,ZGTbBaseTableViewDelegate>

@property (nonatomic,strong) ZGTbBaseTableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;


@end

@implementation ZGTbTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"tableView 相关测试";
    
    [self setupViews];
    
}


- (void)setupViews
{
    _tableView = [[ZGTbBaseTableView alloc] initWithFrame:self.view.bounds];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.refreshDelegate = self;
    _tableView.backgroundColor = [UIColor blackColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ZGTbtestCellID"];
    [self.view addSubview:_tableView];
    [_tableView reloadDataWithDataArrayCount:0];
}

#pragma mark - ZGTbBaseTableViewDelegate
- (void)ZGtableView:(ZGTbBaseTableView *)tableView refreshWithActionType:(ZGTbBaseTableViewActionType)actionType
{
    [tableView reloadDataWithDataArrayCount:0];
}

- (void)zgTableViewDidTouchNoDataView:(ZGTbBaseTableView *)tableView
{
    NSLog(@"tap noDataView");
}

#pragma mark -UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZGTbtestCellID"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0;
}



@end
