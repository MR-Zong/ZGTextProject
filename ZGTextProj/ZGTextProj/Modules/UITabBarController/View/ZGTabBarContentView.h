//
//  ZGTabBarContentView.h
//  ZGTextProj
//
//  Created by ali on 2019/2/13.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZGTabBarContentView;

@protocol ZGTabBarContentViewDelegate <NSObject>

- (void)zg_contentView:(ZGTabBarContentView *)contentView didSelectIndex:(NSInteger)index;

@end

@interface ZGTabBarContentView : UIView

@property (nonatomic, assign) NSInteger selectedIndex;
- (void)addButtonWithTabBarItem:(UITabBarItem *)tabBarItem;
@property (nonatomic, weak) id <ZGTabBarContentViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
