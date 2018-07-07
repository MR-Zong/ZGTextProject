//
//  ZGSTestDragingController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/7/7.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGSTestDragingController.h"

@interface ZGSTestDragingController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ZGSTestDragingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupViews];
}

- (void)setupViews
{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width * 3, 0);
//    _scrollView.pagingEnabled = YES;
    _scrollView.decelerationRate = 0.5;
//    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height)];
    v1.backgroundColor = [UIColor redColor];
    [_scrollView addSubview:v1];
    
    UIView *v2 = [[UIView alloc] initWithFrame:CGRectMake(_scrollView.bounds.size.width, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height)];
    v2.backgroundColor = [UIColor blueColor];
    [_scrollView addSubview:v2];

    
    UIView *v3 = [[UIView alloc] initWithFrame:CGRectMake(2*_scrollView.bounds.size.width, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height)];
    v3.backgroundColor = [UIColor orangeColor];
    [_scrollView addSubview:v3];

    
}


#pragma mark - UIScrollViewDelegate
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    NSLog(@"beginDrag %@",self.scrollView.dragging?@"YES":@"NO");
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    NSLog(@"endDrag %@",self.scrollView.dragging?@"YES":@"NO");
//    NSLog(@"endDrag decelerate %@",decelerate?@"YES":@"NO");
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"dragging %@",self.scrollView.dragging?@"YES":@"NO");
    NSLog(@"decelerate %@",self.scrollView.decelerating?@"YES":@"NO");
    if (self.scrollView.dragging == NO) {
        NSLog(@"******************************");
    }
    
}


@end
