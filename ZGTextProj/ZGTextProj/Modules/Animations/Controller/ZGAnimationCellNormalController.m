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
@property (nonatomic, strong) UITableViewCell *topicCell;


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
    
    _cellTeHeight = 364;
    
}

- (void)setupViews
{
    // tableView
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
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
    
//    _topicCell = [_tableView dequeueReusableCellWithIdentifier:@"ZGAnimationsCellTopicReusedId"];
    _topicCell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 144)];
    _topicCell.backgroundColor = [UIColor orangeColor];
    _topicCell.selectionStyle = UITableViewCellSelectionStyleNone;
    _topicCell.textLabel.text = @"topic";
    
    
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
        return self.topicCell;
        
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
    if (self.cellTeHeight == 364) {
        self.cellTeHeight = 396;
    }else {
        self.cellTeHeight = 364;
    }
    
    NSLog(@"cellTeHeight %f",self.cellTeHeight);

    // 测试了 以下两种方法 都无法解决问题
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}
@end
