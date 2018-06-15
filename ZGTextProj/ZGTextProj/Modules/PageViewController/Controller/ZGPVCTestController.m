//
//  ZGPVCTestController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/6/13.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGPVCTestController.h"
#import "ZGPageAController.h"
#import "ZGPageBController.h"
#import "ZGPageCController.h"
#import "ZGPageDController.h"

@interface ZGPVCTestController () <UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) UIViewController *pendingViewController;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSArray *vcsAry;

@end

@implementation ZGPVCTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"UIPageViewController";
    self.view.backgroundColor = [UIColor whiteColor];
    
    ZGPageAController *a = [[ZGPageAController alloc] init];
    ZGPageBController *b = [[ZGPageBController alloc] init];
    ZGPageCController *c = [[ZGPageCController alloc] init];
    ZGPageDController *d = [[ZGPageDController alloc] init];
    _vcsAry = @[b,c,d];
    
    
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    _pageViewController.dataSource = self;
    _pageViewController.delegate = self;
    _pageViewController.view.frame = self.view.bounds;
    [self.view addSubview:_pageViewController.view];
    [self addChildViewController:_pageViewController];
    
    [_pageViewController setViewControllers:@[_vcsAry.firstObject] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
        NSLog(@"complete");
    }];
}

#pragma mark - UIPageViewControllerDelegate,UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger beforeIndex = self.currentIndex - 1;
    if (beforeIndex < 0) {
        return nil;
        // 无限轮播
//        return self.vcsAry.lastObject;
    }
    return self.vcsAry[beforeIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger afterIndex = self.currentIndex + 1;
    if (afterIndex > self.vcsAry.count - 1) {
        return nil;
        // 无限轮播
//        return self.vcsAry.firstObject;
    }
    return self.vcsAry[afterIndex];
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    //pendingViewControllers虽然是一个数组，但经测试证明该数组始终只包含一个对象
    _pendingViewController = pendingViewControllers.firstObject;
}

//跳转动画完成时触发，配合上面的代理方法可以定位到具体的跳转界面，此方法有利于定位具体的界面位置（childViewControllersArray），便于日后的管理
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    //previousViewControllers虽然是一个数组，但经测试证明该数组始终只包含一个对象
    if (completed) {
        
        [self.vcsAry enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (_pendingViewController == obj) {
                
                _currentIndex = idx;
                *stop = YES;
            }
        }];
    }
}
@end
