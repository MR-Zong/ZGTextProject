//
//  ZGScrollTabIndicatorController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/7/27.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGScrollTabIndicatorController.h"
#import "ZGSTIScrollManager.h"
#import "ZGSTITabView.h"
#import "ZGSTITabModel.h"

#import "ZGSTIHotController.h"
#import "ZGSTIDiscoveryController.h"
#import "ZGSTIStoryController.h"


@interface ZGScrollTabIndicatorController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) ZGSTITabView *mainTabBarView;
@property (nonatomic, strong) ZGSTIScrollManager *mainSVM;
@property (nonatomic, strong) NSArray *tabItemArray;

@end

@implementation ZGScrollTabIndicatorController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initialize];
    [self setupViews];
}

- (void)initialize
{
    ZGSTITabModel *tabItem0 = [ZGSTITabModel tabItemWithViewController:[[ZGSTIHotController alloc] init]];
    ZGSTITabModel *tabItem1 = [ZGSTITabModel tabItemWithViewController:[[ZGSTIDiscoveryController alloc] init]];
    ZGSTITabModel *tabItem2 = [ZGSTITabModel tabItemWithViewController:[[ZGSTIStoryController alloc] init]];
    
    
    _tabItemArray = @[tabItem0,tabItem1,tabItem2];
    
}

- (void)setupViews
{
    
    // _scrollView
    NSInteger pageCount = _tabItemArray.count;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    _scrollView.contentSize = CGSizeMake(pageCount * _scrollView.bounds.size.width, 0);
    //  _scrollView.backgroundColor = [UIColor kc_colorWithHexString:@"#242533"];
    _scrollView.backgroundColor = [UIColor whiteColor];
    // SMMainScrollManager
    _mainSVM = [ZGSTIScrollManager shareInstance];
    _mainSVM.scrollView = _scrollView;
    _scrollView.delegate = _mainSVM;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    //    [_scrollView addObserver:_mainSVM forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    
    // 设置scrollView 的子视图
    for (int i=0; i<_tabItemArray.count; i++) {
        ZGSTITabModel *tabItem = _tabItemArray[i];
        tabItem.vc.viewFrame = CGRectMake(_scrollView.bounds.size.width * i, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
        [_scrollView addSubview:tabItem.vc.view];
        [self addChildViewController:tabItem.vc];
    }
    [self.view addSubview:_scrollView];
    
    // SMMainTabBarView
    _mainTabBarView = [[ZGSTITabView alloc] initWithFrame:CGRectMake(0, 0, 224, 44)];
    self.navigationItem.titleView = _mainTabBarView;
    _mainSVM.tabBar = _mainTabBarView;
    
   
}



@end
