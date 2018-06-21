//
//  ZGAnimationsCellController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/6/16.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGAnimationsCellController.h"
#import "ZGHeaderCell.h"
#import "UIImage+ZGExtension.h"

@interface ZGAnimationsCellController () <UITableViewDelegate,UITableViewDataSource,SMTopicHeaderViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZGHeaderCell *headerCell;
@property (nonatomic, assign) CGFloat headerCellHeight;
@end

@implementation ZGAnimationsCellController


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
        
    // headerCell
    _headerCellHeight = SMTopicHeaderViewBaseHeight + SMTopicHeaderViewBaseTextHeight;
    _headerCell = [[ZGHeaderCell alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, _headerCellHeight)];
    _headerCell.hView.delegate = self;
    
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
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ZGAnimationsCellReusedId"];
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
        return self.headerCell;
    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZGAnimationsCellReusedId"];
    cell.textLabel.text = [NSString stringWithFormat:@"Cell - %zd",indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return self.headerCellHeight;
    }
    
    return 44;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return 0;
//    }
//    return 0;//42;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    return nil;
//    if (section == 0) {
//        return nil;
//    }
//
//    UIView *sh = [[UIView alloc] init];
//
//    sh.backgroundColor = [UIColor grayColor];
//
//    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width, 32)];
//    bg.backgroundColor = [UIColor whiteColor];
//    [sh addSubview:bg];
//
//    UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 25, 260, 14)];
//    countLabel.textColor = [UIColor blackColor];
//    countLabel.font = [UIFont systemFontOfSize:14];
//    countLabel.text = @"共3个故事";
//    [sh addSubview:countLabel];
//
//    return sh;
//}

#pragma mark - scrollviewDelegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if (scrollView.contentOffset.y >= -64 && scrollView.contentOffset.y <= 64) {
//        
//        CGFloat alpha = fabs(scrollView.contentOffset.y - 0) / 64.0;
//        UIImage *img = [UIImage imageWithColor:[[UIColor whiteColor] colorWithAlphaComponent:alpha]];
//        [self.navigationController.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
//    }
//}

#pragma mark - SMTopicHeaderViewDelegate
- (void)topicHeaderView:(SMTopicHeaderView *)view didExtendBtn:(UIButton *)btn
{
    NSString *text = @"所谓专题，是指针对某个特定对象而特别收集制作而成的一种集中作品，这个对象可以是具体的某个或某集所谓专题，是指针对某个特定对象而特别收集制作而成的一种集中作品，这个对象可以是具体的某个或某集";
    CGFloat textHeight = [text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 30, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
    textHeight = ceil(textHeight) + 1;
    
    if (textHeight < SMTopicHeaderViewBaseTextHeight) {
        textHeight = SMTopicHeaderViewBaseTextHeight;
    }
    self.headerCellHeight = SMTopicHeaderViewBaseHeight + textHeight;
    
    self.headerCell.hView.textHeight = textHeight;
    
    NSLog(@"headerCellHeight %f",self.headerCellHeight);
    
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)topicHeaderView:(SMTopicHeaderView *)view didDescLabelWithExtendBtn:(UIButton *)btn
{
    CGFloat textHeight = SMTopicHeaderViewBaseTextHeight;
    self.headerCellHeight = SMTopicHeaderViewBaseHeight + textHeight;
    
    self.headerCell.hView.textHeight = textHeight;
    

    NSLog(@"headerCellHeight %f",self.headerCellHeight);

    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    
}

@end
