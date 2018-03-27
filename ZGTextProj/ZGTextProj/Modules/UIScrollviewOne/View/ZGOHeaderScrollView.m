//
//  ZGOHeaderScrollView.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/1/11.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGOHeaderScrollView.h"
#import "ZGSubTabBarView.h"

@interface ZGOHeaderScrollView ()
@property (nonatomic,strong) ZGSubTabBarView *tabBar;
@end

@implementation ZGOHeaderScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.showsHorizontalScrollIndicator = NO;
        self.scrollEnabled = NO;

        _tabBar = [[ZGSubTabBarView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, 40)];
        _tabBar.tabCount = 3;
        [self addSubview:_tabBar];
    }
    return self;
}

- (void)pageToIndex:(NSInteger)index contentOffset:(CGPoint)contentOffset
{
    if (index == 0) {
         // 要跟随 移动
        self.contentOffset = contentOffset;
//        NSLog(@"self.contntOffset %@",NSStringFromCGPoint(contentOffset));
    }else if (index == 1 || index == 2 || index == 3){
        // 自己保持不动
        // 但要处理二级 tabBar
        [self.tabBar tabWithIndex:index-1 contentOffset:contentOffset];
    }
}

- (void)setTabCount:(NSInteger)tabCount
{
    _tabCount = tabCount;
    
    self.contentSize = CGSizeMake(self.bounds.size.width * tabCount, 0);
}


#pragma mark -
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    if (view == self) {
        return nil;
    }
    return view;
}

@end
