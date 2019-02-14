//
//  ZGTabBarController.m
//  ZGTextProj
//
//  Created by ali on 2019/2/13.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGTabBarController.h"
#import "ZGTabBarContentView.h"

@interface ZGTabBarController () <ZGTabBarContentViewDelegate>
@property (nonatomic, strong) ZGTabBarContentView *tabBarContentView;
@end

@implementation ZGTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tabBar addSubview:self.tabBarContentView];
}

#pragma mark - 添加子视图控制器
- (void)addController:(UIViewController *)controller withTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    
    controller.tabBarItem.title = title;
    controller.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self addChildViewController:controller];
    [self.tabBarContentView addButtonWithTabBarItem:controller.tabBarItem];
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    for (UIView *view in self.tabBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [view removeFromSuperview];
        }
    }

}

#pragma mark - ZGTabBarContentViewDelegate
- (void)zg_contentView:(ZGTabBarContentView *)contentView didSelectIndex:(NSInteger)index
{
    self.selectedIndex = index;
}

#pragma mark - getter
- (ZGTabBarContentView *)tabBarContentView
{
    if (!_tabBarContentView) {
        _tabBarContentView = [[ZGTabBarContentView alloc] init];
        _tabBarContentView.frame = self.tabBar.bounds;
        _tabBarContentView.delegate = self;
    }
    return _tabBarContentView;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
    self.tabBarContentView.selectedIndex = selectedIndex;
}


@end
