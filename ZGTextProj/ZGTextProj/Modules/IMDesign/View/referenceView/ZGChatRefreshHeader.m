//
//  ZGChatRefreshHeader.m
//  ZGTextProj
//
//  Created by ali on 2019/2/21.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGChatRefreshHeader.h"

@interface ZGChatRefreshHeader()

@property (weak, nonatomic) UIActivityIndicatorView *loadingView;
@end

@implementation ZGChatRefreshHeader
#pragma mark - 懒加载子控
- (UIActivityIndicatorView *)loadingView
{
    if (!_loadingView) {
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.activityIndicatorViewStyle];
        loadingView.hidesWhenStopped = YES;
        [self addSubview:_loadingView = loadingView];
    }
    return _loadingView;
}

#pragma mark - 公共方法
- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle
{
    _activityIndicatorViewStyle = activityIndicatorViewStyle;
    
    self.loadingView = nil;
    [self setNeedsLayout];
}

- (void)stopActivityAnimation
{
    [self.loadingView stopAnimating];
}

#pragma mark - 重写父类的方法
- (void)prepare
{
    [super prepare];
    
    self.stateLabel.hidden = YES;
    self.lastUpdatedTimeLabel.hidden = YES;

    self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    // 箭头的中心点
    CGFloat arrowCenterX = self.mj_w * 0.5;
    CGFloat arrowCenterY = self.mj_h * 0.5;
    CGPoint arrowCenter = CGPointMake(arrowCenterX, arrowCenterY);
    
    // 圈圈
    if (self.loadingView.constraints.count == 0) {
        self.loadingView.center = arrowCenter;
    }
    
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    // 根据状态做事情
    NSLog(@"refreshState %zd",state);
    if (state == MJRefreshStateIdle) {
        [self.loadingView startAnimating];

    }
    
}
@end
