//
//  ZGAlertPopView.h
//  ZGTextProj
//
//  Created by ali on 2019/2/16.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZGAlertPopView : UIView

- (void)showInView:(UIView *)view title:(NSString *)title;
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
