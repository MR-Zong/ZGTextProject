//
//  ZGNestCController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/6/26.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGNestPageCController.h"

@interface ZGNestPageCController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ZGNestPageCController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupViews];
}

- (void)setupViews
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.showsVerticalScrollIndicator= NO;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ZGNestPageCCellReusedId"];
    [self.view addSubview:_tableView];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZGNestPageCCellReusedId"];
    cell.textLabel.text = [NSString stringWithFormat:@"CCC - %zd",indexPath.row];
    cell.backgroundColor = [UIColor redColor];
    return cell;
    
}

@end
