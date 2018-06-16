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
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    UIImage *img = [UIImage imageWithColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.hidden = YES;
    
    _cellTeHeight = 144;
    
}

- (void)setupViews
{
    // tableView
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ZGAnimationsCellReusedId"];
    _tableView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_tableView];
    
    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZGAnimationsCellReusedId"];
    cell.textLabel.text = [NSString stringWithFormat:@"Cell - %zd",indexPath.row];
    
    if (indexPath.section == 0) {
        cell.backgroundColor = [UIColor orangeColor];
    }else {
        cell.backgroundColor = [UIColor redColor];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
    if (section == 0) {
        return 0;
    }
    return 42;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 364;
    }
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
    if (section == 0) {
        return nil;
    }
    UIView *sh = [[UIView alloc] init];
    
    sh.backgroundColor = [UIColor purpleColor];
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 32)];
    bg.backgroundColor = [UIColor greenColor];
    [sh addSubview:bg];
    
    UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 25, 260, 14)];
    countLabel.textColor = [UIColor blackColor];
    countLabel.font = [UIFont systemFontOfSize:14];
    countLabel.text = @"共3个故事";
    [sh addSubview:countLabel];
    
    return sh;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cellTeHeight == 144) {
        self.cellTeHeight = 200;
    }else {
        self.cellTeHeight = 144;
    }
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    NSLog(@"xxxx");
}
@end
