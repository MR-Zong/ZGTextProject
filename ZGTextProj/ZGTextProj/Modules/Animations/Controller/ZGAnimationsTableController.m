//
//  ZGAnimationsTableController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/6/15.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGAnimationsTableController.h"
#import "SMTopicHeaderView.h"

@interface ZGAnimationsTableController () <UITableViewDelegate,UITableViewDataSource,SMTopicHeaderViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SMTopicHeaderView *headerView;
@end

@implementation ZGAnimationsTableController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialize];
    [self setupViews];
    
}

- (void)initialize
{
    self.title = @"";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupViews
{
    // tableView
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ZGAnimationsCellReusedId"];
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    
    
    // headerView
    CGFloat headerViewHeight = SMTopicHeaderViewBaseHeight + SMTopicHeaderViewBaseTextHeight;
    _headerView = [[SMTopicHeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, headerViewHeight)];
    _headerView.delegate = self;
    _tableView.tableHeaderView = _headerView;
    
}




#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZGAnimationsCellReusedId"];
    cell.textLabel.text = @"xxxx";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 42;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sh = [[UIView alloc] init];
    
    sh.backgroundColor = [UIColor grayColor];
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width, 32)];
    bg.backgroundColor = [UIColor whiteColor];
    [sh addSubview:bg];
    
    UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 25, 260, 14)];
    countLabel.textColor = [UIColor blackColor];
    countLabel.font = [UIFont systemFontOfSize:14];
    countLabel.text = @"共3个故事";
    [sh addSubview:countLabel];
    
    return sh;
}

#pragma mark - SMTopicHeaderViewDelegate
- (void)topicHeaderView:(SMTopicHeaderView *)view didExtendBtn:(UIButton *)btn
{
    NSString *text = @"所谓专题，是指针对某个特定对象而特别收集制作而成的一种集中作品，这个对象可以是具体的某个或某集所谓专题，是指针对某个特定对象而特别收集制作而成的一种集中作品，这个对象可以是具体的某个或某集";
    CGFloat textHeight = [text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 30, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
    textHeight = ceil(textHeight) + 1;
    
    if (textHeight < SMTopicHeaderViewBaseTextHeight) {
        textHeight = SMTopicHeaderViewBaseTextHeight;
    }
    CGFloat headerViewHeight = SMTopicHeaderViewBaseHeight + textHeight;
    
    CGRect tmpF = self.headerView.frame;
    tmpF.size.height = headerViewHeight;
    self.headerView.frame = tmpF;
    
    self.headerView.textHeight = textHeight;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.tableView.tableHeaderView = self.headerView;
    }];
    
}

- (void)topicHeaderView:(SMTopicHeaderView *)view didDescLabelWithExtendBtn:(UIButton *)btn
{
    CGFloat textHeight = SMTopicHeaderViewBaseTextHeight;
    CGFloat headerViewHeight = SMTopicHeaderViewBaseHeight + textHeight;
    
    CGRect tmpF = self.headerView.frame;
    tmpF.size.height = headerViewHeight;
    self.headerView.frame = tmpF;
    
    self.headerView.textHeight = textHeight;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.tableView.tableHeaderView = self.headerView;
    }];
}

@end
