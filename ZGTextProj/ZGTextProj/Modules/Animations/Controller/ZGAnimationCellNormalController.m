//
//  ZGAnimationCellNormalController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/6/16.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGAnimationCellNormalController.h"
#import "UIImage+ZGExtension.h"

@interface ZGAnimationCellNormalController () <UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) CGFloat cellTeHeight;


@end

@implementation ZGAnimationCellNormalController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialize];
    [self setupViews];
    
}

- (void)initialize
{
    self.title = @"";
    self.view.backgroundColor = [UIColor greenColor];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    UIImage *img = [UIImage imageWithColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.hidden = YES;
    
    _cellTeHeight = 200;
    
}

- (void)setupViews
{
    // tableView
//    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -500, self.view.bounds.size.width, self.view.bounds.size.height + 500) style:UITableViewStylePlain];
//    // 设置contentInset
//    _tableView.contentInset = UIEdgeInsetsMake(500, 0, 0, 0);
    
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    
    
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ZGAnimationsCellReusedId"];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ZGAnimationsCellTopicReusedId"];
    _tableView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_tableView];
    
    
}


#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (section == 0) {
        return 1;
    }
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:@"ZGAnimationsCellTopicReusedId"];
        cell.backgroundColor = [UIColor orangeColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"topic";
        return cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZGAnimationsCellReusedId"];
        cell.textLabel.text = [NSString stringWithFormat:@"Cell - %zd",indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor redColor];
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sh = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 80)];
    sh.backgroundColor = [UIColor purpleColor];
    
    NSLog(@"section header");
    return sh;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 0;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return self.cellTeHeight;
    }
    return 44;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (self.cellTeHeight == 200) {
        self.cellTeHeight = 396;
    }else {
        self.cellTeHeight = 200;
    }
    
//    NSLog(@"cellTeHeight %f",self.cellTeHeight);

//    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    // 测试了 以下两种方法 都无法解决问题
//        [tableView reloadData];
    
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
    
//    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}
@end
