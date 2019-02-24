//
//  ZGTabBarButton.h
//  ZGTextProj
//
//  Created by ali on 2019/2/13.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,ZGTabBarButtonState) {
    ZGTabBarButtonStateNormal,
    ZGTabBarButtonStateSelected,
};

@interface ZGTabBarButton : UIView

@property (nonatomic, strong) UITabBarItem *tabBarItem;
@property (nonatomic, assign) BOOL isSelected;
- (void)addTarget:(nullable id)target action:(SEL)action;
- (void)setColor:(UIColor *)color state:(ZGTabBarButtonState)state;

@end

NS_ASSUME_NONNULL_END
