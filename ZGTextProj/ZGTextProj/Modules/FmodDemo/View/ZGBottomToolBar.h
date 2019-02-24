//
//  ZGBottomToolBar.h
//  AudioProgress
//
//  Created by ali on 2019/1/16.
//  Copyright © 2019 赵成峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZGBottomToolBar;

@protocol ZGBottomToolBarDelegate <NSObject>

- (void)toolBar:(ZGBottomToolBar *)toolBar didClickRouteBtn:(UIButton *)btn;
- (void)toolBar:(ZGBottomToolBar *)toolBar didClickRecBtn:(UIButton *)btn;
- (void)toolBar:(ZGBottomToolBar *)toolBar didClickPlayeBtn:(UIButton *)btn;


@end

@interface ZGBottomToolBar : UIView

@property (nonatomic, strong) UIButton *routeBtn;
@property (nonatomic, strong) UIButton *recBtn;
@property (nonatomic, strong) UIButton *playBtn;

@property (weak, nonatomic) id <ZGBottomToolBarDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
