//
//  ZGTabBarContentView.m
//  ZGTextProj
//
//  Created by ali on 2019/2/13.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGTabBarContentView.h"
#import "ZGTabBarButton.h"

#define zg_tabBar_indicatorView_w 5

@interface ZGTabBarContentView ()

@property (nonatomic, strong) NSMutableArray *tabBarButtonAry;
@property (nonatomic, strong) UIView *indicatorView;

@end

@implementation ZGTabBarContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _tabBarButtonAry = [NSMutableArray arrayWithCapacity:6];
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    self.backgroundColor = [UIColor whiteColor];
    
    _indicatorView = [[UIView alloc] init];
    _indicatorView.layer.cornerRadius = zg_tabBar_indicatorView_w/2.0;
    _indicatorView.layer.masksToBounds = YES;
    _indicatorView.backgroundColor = [UIColor blackColor];
    [self addSubview:_indicatorView];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnW = [UIScreen mainScreen].bounds.size.width / self.tabBarButtonAry.count;
    CGFloat btnH = 44;
    for (ZGTabBarButton *btn in self.tabBarButtonAry) {

        if (btn.tag == self.selectedIndex) {
            btn.isSelected = YES;
        }
        btn.frame = CGRectMake(btn.tag * btnW, 0, btnW, btnH);
    }

    ZGTabBarButton *selectBtn = self.tabBarButtonAry[self.selectedIndex];
    CGFloat indicatoreViewX = selectBtn.center.x - (zg_tabBar_indicatorView_w/2.0);
    _indicatorView.frame = CGRectMake(indicatoreViewX, self.bounds.size.height - zg_tabBar_indicatorView_w - 5, zg_tabBar_indicatorView_w, zg_tabBar_indicatorView_w);
}

#pragma mark -
- (void)addButtonWithTabBarItem:(UITabBarItem *)tabBarItem
{
    
    NSInteger btnIndex = self.tabBarButtonAry.count;
    
    ZGTabBarButton *button = [[ZGTabBarButton alloc]init];
    button.tabBarItem = tabBarItem;
    button.tag = btnIndex;
    [button setColor:[UIColor blueColor] state:ZGTabBarButtonStateNormal];
    [button setColor:[UIColor greenColor] state:ZGTabBarButtonStateSelected];
    [button addTarget:self action:@selector(btnClick:)];
    [self addSubview:button];
    [self.tabBarButtonAry addObject:button];
}

- (void)btnClick:(ZGTabBarButton *)btn
{
    ZGTabBarButton *preSelectedBtn = self.tabBarButtonAry[self.selectedIndex];
    preSelectedBtn.isSelected = NO;
    self.selectedIndex = btn.tag;
    btn.isSelected = YES;
    
    ZGTabBarButton *selectBtn = self.tabBarButtonAry[self.selectedIndex];
    CGFloat indicatoreViewX = selectBtn.center.x - (zg_tabBar_indicatorView_w/2.0);
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.indicatorView.frame = CGRectMake(indicatoreViewX, self.bounds.size.height - zg_tabBar_indicatorView_w - 5, zg_tabBar_indicatorView_w, zg_tabBar_indicatorView_w);
    } completion:nil];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(zg_contentView:didSelectIndex:)]) {
        [self.delegate zg_contentView:self didSelectIndex:btn.tag];
    }
}
@end
