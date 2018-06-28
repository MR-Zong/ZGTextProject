//
//  ZGNestBController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/6/26.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGNestPageBController.h"

#import "ZGNestPageDController.h"
#import "ZGNestScrollView.h"

@interface ZGNestPageBController () <UIScrollViewDelegate>

@property (nonatomic, strong) ZGNestPageDController *dVC1;
@property (nonatomic, strong) ZGNestPageDController *dVC2;
@property (nonatomic, strong) ZGNestPageDController *dVC3;

@end

@implementation ZGNestPageBController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"scrollView嵌套";
    self.view.backgroundColor = [UIColor whiteColor];
    
    /* 微博个人主页效果 （在另一个项目里写了）
     *  方案筛选
     *  1，两个UITableView 通过contentInset.top 的方法来实现
     *  但整个方案 很不完美
     *  2，直接一个大scrollView  然后里面 两个UITAbleView
     */
    
    // 现在是写 scrollView横向滚动嵌套
    [self setupViews];
}

- (void)setupViews
{
    _scrollView = [[ZGNestSubScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.backgroundColor = [UIColor redColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(3*_scrollView.frame.size.width, _scrollView.frame.size.height);
    [self.view addSubview:_scrollView];
    
    
    // vc
    _dVC1 = [[ZGNestPageDController alloc] init];
    _dVC1.cellText = @"11D";
    _dVC1.view.frame = CGRectMake(0, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
    [_scrollView addSubview:_dVC1.view];

    
    _dVC2 = [[ZGNestPageDController alloc] init];
    _dVC2.cellText = @"22D";
    _dVC2.view.frame = CGRectMake(CGRectGetMaxX(_dVC1.view.frame), 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
    [_scrollView addSubview:_dVC2.view];

    
    _dVC3 = [[ZGNestPageDController alloc] init];
    _dVC3.cellText = @"33D";
    _dVC3.view.frame = CGRectMake(CGRectGetMaxX(_dVC2.view.frame), 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
    [_scrollView addSubview:_dVC3.view];

    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    self.nestScrollView.scrollEnabled = NO;
    self.nestScrollView.shouldGestureBegin = YES;
    NSLog(@"subSV begindrag");
}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    self.nestScrollView.scrollEnabled = YES;
//    NSLog(@"subSV enddrag");
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"sub didScroll");
}


@end
