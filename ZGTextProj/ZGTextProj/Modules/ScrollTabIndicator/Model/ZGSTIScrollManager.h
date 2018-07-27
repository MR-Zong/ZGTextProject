//
//  ZGSTIScrollManager.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/7/27.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZGSTITabView;

@interface ZGSTIScrollManager : NSObject <UIScrollViewDelegate>

+ (instancetype)shareInstance;
@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) ZGSTITabView *tabBar;
- (void)tabBarDidSelectedIndex:(NSInteger)index;

@end
