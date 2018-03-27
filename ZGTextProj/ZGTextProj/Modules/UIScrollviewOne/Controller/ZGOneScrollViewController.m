//
//  ZGOneScrollViewController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/1/11.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGOneScrollViewController.h"
#import "ZGOBaseScrollView.h"
#import "ZGOHeaderScrollView.h"
#import "ZGOScrollManager.h"

@interface ZGOneScrollViewController ()

@property (nonatomic,strong) ZGOBaseScrollView *scrollView;
@property (nonatomic,strong) ZGOHeaderScrollView *headerScrollView;
@property (nonatomic,strong) ZGOScrollManager *scrollManager;

@end

@implementation ZGOneScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupViews];
}


- (void)setupViews
{
    _scrollManager = [[ZGOScrollManager alloc] init];
    
    NSInteger pageCount = 4;
    _scrollView = [[ZGOBaseScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64)];
    _scrollView.contentSize = CGSizeMake(pageCount * _scrollView.bounds.size.width, 0);
    _scrollView.backgroundColor = [UIColor orangeColor];
    _scrollView.delegate = _scrollManager;
    _scrollView.pagingEnabled = YES;
    
    for (int i=0; i<pageCount; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(_scrollView.bounds.size.width * i, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height)];
        UILabel *label = [[UILabel alloc] initWithFrame:view.bounds];
        label.text = [NSString stringWithFormat:@"%zd",i];
        label.font = [UIFont systemFontOfSize:50];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        [_scrollView addSubview:view];
    }
    [self.view addSubview:_scrollView];
    
    
    _headerScrollView = [[ZGOHeaderScrollView alloc] initWithFrame:CGRectMake(0, 64, _scrollView.bounds.size.width, 40)];
    _headerScrollView.tabCount = 2;
    [self.view addSubview:_headerScrollView];
    
    _scrollManager.headerSV = _headerScrollView;
    
}


@end
