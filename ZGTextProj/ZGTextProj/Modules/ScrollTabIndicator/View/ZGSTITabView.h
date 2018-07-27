//
//  ZGSTITabView.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/7/27.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZGSTITabView : UIView

@property  (nonatomic,assign) NSInteger selectedIndex;
- (void)tabIndicatorWithSrollView:(UIScrollView *)scrollView contentOffset:(CGPoint)contentOffset;
- (void)tabIndicatorWithSrollView:(UIScrollView *)scrollView change:(NSDictionary<NSKeyValueChangeKey,id> *)change;
@end
