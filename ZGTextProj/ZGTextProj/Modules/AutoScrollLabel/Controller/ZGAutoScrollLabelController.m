//
//  ZGAutoScrollLabelController.m
//  ZGTextProj
//
//  Created by ali on 2018/10/25.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGAutoScrollLabelController.h"
#import "AutoScrollLabel.h"
#import "ZGAutoScrollLabel.h"

@interface ZGAutoScrollLabelController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) ZGAutoScrollLabel *autoScrollLabel;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ZGAutoScrollLabelController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self testAutoScrollLabel];
    
//    [self testCellForRow];
    
}


- (void)testAutoScrollLabel
{
    _autoScrollLabel = [[ZGAutoScrollLabel alloc] initWithFrame:CGRectMake(100, 100, 200, 40)];
    _autoScrollLabel.scrollDirection = ZGAutoScrollDirectionRightToLeft;
    _autoScrollLabel.backgroundColor = [UIColor redColor];
    //    _autoScrollLabel.delayInterval = 5;
    //    _autoScrollLabel.pauseInterval = 5;
    _autoScrollLabel.spaceBetweenLabels = 50;
    _autoScrollLabel.text = @"繁华声 遁入空门 折煞了梦偏冷 辗转一生 情债又几 如你默认 生死枯等 枯等一圈 又一圈的 浮图塔 断了几层 断了谁的痛直奔 一盏残灯 倾塌的山门 容我再等 历史转身 等酒香醇 等你弹 一曲古筝";
    //    _autoScrollLabel.text = @"往事只能回味";
    [_autoScrollLabel strartAnimation];
    [self.view addSubview:_autoScrollLabel];

}

- (void)testCellForRow
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellfoRowReusedID"];
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath.row %zd",indexPath.row);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellfoRowReusedID"];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.tableView.bounds.size.height;
}

@end
