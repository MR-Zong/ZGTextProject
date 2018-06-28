//
//  ZGScrollViewNestingController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/5/13.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGScrollViewNestingController.h"
#import "ZGNestScrollView.h"

#import "ZGNestPageAController.h"
#import "ZGNestPageBController.h"
#import "ZGNestPageCController.h"

@interface ZGScrollViewNestingController () <UIScrollViewDelegate>

@property (nonatomic, strong) ZGNestScrollView *nestScrollView;

@property (nonatomic, strong) ZGNestPageAController *aVC;
@property (nonatomic, strong) ZGNestPageBController *bVC;
@property (nonatomic, strong) ZGNestPageCController *cVC;

@end

@implementation ZGScrollViewNestingController

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
    _nestScrollView = [[ZGNestScrollView alloc] initWithFrame:self.view.bounds];
    _nestScrollView.backgroundColor = [UIColor redColor];
    _nestScrollView.pagingEnabled = YES;
    _nestScrollView.bounces = NO;
    _nestScrollView.delegate = self;
    _nestScrollView.contentSize = CGSizeMake(3*_nestScrollView.frame.size.width, _nestScrollView.frame.size.height);
    [self.view addSubview:_nestScrollView];
//    NSLog(@"panGestureRecognizer %@",_nestScrollView.panGestureRecognizer.delegate);
    
    
    // vc
    _aVC = [[ZGNestPageAController alloc] init];
    _aVC.view.frame = CGRectMake(0, 0, _nestScrollView.frame.size.width, _nestScrollView.frame.size.height);
    [_nestScrollView addSubview:_aVC.view];
    
    _bVC = [[ZGNestPageBController alloc] init];
    _bVC.nestScrollView = _nestScrollView;
    _bVC.view.frame = CGRectMake(CGRectGetMaxX(_aVC.view.frame), 0, _nestScrollView.frame.size.width, _nestScrollView.frame.size.height);
    [_nestScrollView addSubview:_bVC.view];

    
    _cVC = [[ZGNestPageCController alloc] init];
    _cVC.view.frame = CGRectMake(CGRectGetMaxX(_bVC.view.frame), 0, _nestScrollView.frame.size.width, _nestScrollView.frame.size.height);
    [_nestScrollView addSubview:_cVC.view];

}

#pragma mark - scrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    self.nestScrollView.shouldGestureBegin = YES;
    NSLog(@"nest begindrag");
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.nestScrollView.shouldGestureBegin = NO;
     NSLog(@"nest enddrag");
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"nest didScroll");
}

@end
