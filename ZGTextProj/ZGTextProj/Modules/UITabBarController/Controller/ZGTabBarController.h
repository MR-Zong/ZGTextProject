//
//  ZGTabBarController.h
//  ZGTextProj
//
//  Created by ali on 2019/2/13.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZGTabBarController : UITabBarController

#pragma mark - 添加子视图控制器
- (void)addController:(UIViewController *)controller withTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName;

@end

NS_ASSUME_NONNULL_END
