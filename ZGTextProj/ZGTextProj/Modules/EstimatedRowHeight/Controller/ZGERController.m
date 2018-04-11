//
//  ZGERController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/4/11.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGERController.h"

@interface ZGERController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ZGERController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"estimateRowHeight";
    
    [self setupViews];
}


- (void)setupViews
{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    NSLog(@"estimatedRowHeight %f",_tableView.estimatedRowHeight);
    NSLog(@"UITableViewAutomaticDimension %f",UITableViewAutomaticDimension);
    NSLog(@"_tableView.hegith %f",_tableView.bounds.size.height);
    NSLog(@"realRowHeigth firstRowCount %zd",(NSInteger)(_tableView.bounds.size.height-64) / 20);
    NSLog(@"estimatedRowHeight firstRowCount %zd",(NSInteger)(_tableView.bounds.size.height-64) / 40);
    _tableView.estimatedRowHeight = 40;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"estimatedRowHeightCell"];
    
    //    UITableViewAutomaticDimension

    //    _tableView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_tableView];
    
}

#pragma mark -UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"estimatedRowHeightCell"];
    cell.backgroundColor = [UIColor orangeColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"heightForRow %zd",indexPath.row);
    NSLog(@"contentSize %@",NSStringFromCGSize(self.tableView.contentSize));
    return 20;
}

@end
