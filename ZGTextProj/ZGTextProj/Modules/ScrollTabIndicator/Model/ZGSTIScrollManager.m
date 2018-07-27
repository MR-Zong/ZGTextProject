//
//  ZGSTIScrollManager.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/7/27.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGSTIScrollManager.h"
#import "ZGSTITabView.h"

@interface ZGSTIScrollManager ()

@property (nonatomic, assign) NSInteger selectedPageIndex; // 就为了 统计事件

@end

@implementation ZGSTIScrollManager

- (void)dealloc
{
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    static ZGSTIScrollManager *_stiScrollViewManager_;
    dispatch_once(&onceToken, ^{
        _stiScrollViewManager_ = [[ZGSTIScrollManager alloc] init];
    });
    
    return _stiScrollViewManager_;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    [self.tabBar tabIndicatorWithSrollView:self.scrollView change:change];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    if (self.selectedPageIndex == 0 && index != 0) {
        //        [SMStatistics event:@"V100_home_helpsleep"];
    }
    
    self.selectedPageIndex = index; // 就为了 统计事件
    
    //    NSLog(@"index %zd",index);
    //    NSLog(@"self.contntOffset %@",NSStringFromCGPoint(scrollView.contentOffset));
//    [self dealWithDrawViewControllerWithIndex:index];
    [self.tabBar tabIndicatorWithSrollView:scrollView contentOffset:scrollView.contentOffset];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    // 处理mainTabBAr
    self.tabBar.selectedIndex = index;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    // 处理mainTabBAr
    self.tabBar.selectedIndex = index;
}

- (void)tabBarDidSelectedIndex:(NSInteger)index
{
    [self.scrollView setContentOffset:CGPointMake(index*self.scrollView
                                                  .bounds.size.width, 0) animated:YES];
}

//- (void)dealWithDrawViewControllerWithIndex:(NSInteger)index
//{
//    [SMViewControllerManager shareInstance].drawController.canDraw = (index == 0);
//}

@end
