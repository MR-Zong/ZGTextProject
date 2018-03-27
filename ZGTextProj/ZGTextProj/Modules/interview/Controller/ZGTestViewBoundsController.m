//
//  ZGTestViewBoundsController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/11/15.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import "ZGTestViewBoundsController.h"

@interface ZGTestViewBoundsController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ZGTestViewBoundsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
    NSLog(@"extendedLayoutIncludesOpaqueBars = %zd",self.extendedLayoutIncludesOpaqueBars);
    NSLog(@"edgesForExtendedLayout = %zd",self.edgesForExtendedLayout);
    
    self.navigationController.navigationBar.translucent = NO;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.edgesForExtendedLayout = UIRectEdgeTop;
    
    _tableView = [[UITableView alloc] init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor greenColor];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tttttCell"];
    _tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:_tableView];
    
     NSLog(@"%@",NSStringFromUIEdgeInsets(_tableView.contentInset));
    NSLog(@"offsetY %f",_tableView.contentOffset.y);
    NSLog(@"tableView %@",NSStringFromCGRect(_tableView.frame));
    NSLog(@"view %@",NSStringFromCGRect(self.view.frame));
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"\n\nviewWillAppear");
    NSLog(@"%@",NSStringFromUIEdgeInsets(_tableView.contentInset));
    NSLog(@"offsetY %f",_tableView.contentOffset.y);
    NSLog(@"tableView %@",NSStringFromCGRect(_tableView.frame));
    NSLog(@"view %@",NSStringFromCGRect(self.view.frame));

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"\n\nviewDidAppear");
     NSLog(@"%@",NSStringFromUIEdgeInsets(_tableView.contentInset));
    NSLog(@"offsetY %f",_tableView.contentOffset.y);
    NSLog(@"tableView %@",NSStringFromCGRect(_tableView.frame));
    NSLog(@"view %@",NSStringFromCGRect(self.view.frame));

}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tttttCell"];
    cell.backgroundColor = [UIColor blueColor];
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor orangeColor];
    }
    return cell;
}

@end
