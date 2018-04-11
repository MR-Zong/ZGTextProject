//
//  ZGExtendLayoutController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/4/10.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGExtendLayoutController.h"

@interface ZGExtendLayoutController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ZGExtendLayoutController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"extendLayout";
    self.view.backgroundColor = [UIColor greenColor];
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.extendedLayoutIncludesOpaqueBars = YES;
//    self.automaticallyAdjustsScrollViewInsets = YES;
    
    [self setupViews];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];


    NSLog(@"self.tableView.frame %@",NSStringFromCGRect(self.tableView.frame));
    NSLog(@"top %f,left %f,bottom %f,right %f",self.tableView.contentInset.top,self.tableView.contentInset.left,self.tableView.contentInset.bottom,self.tableView.contentInset.right);
    NSLog(@"contentOffset.y %f",self.tableView.contentOffset.y);
    NSLog(@"self.view.frame %@",NSStringFromCGRect(self.view.frame));
}

- (void)setupViews
{
    UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    v1.backgroundColor = [UIColor redColor];
    [self.view addSubview:v1];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"extendLayoutCell"];
    _tableView.rowHeight = 50;
    
//    UITableViewAutomaticDimension
    // ios11 新属性
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"extendLayoutCell"];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}


@end
