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
- (UIActivityIndicatorView *)loadingView
{
    if (!_loadingView) {
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.activityIndicatorViewStyle];
        loadingView.hidesWhenStopped = YES;
        [self addSubview:_loadingView = loadingView];
    }
    return _loadingView;
}

#pragma mark -
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

#pragma mark - override
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
    
    CGFloat arrowCenterX = self.mj_w * 0.5;
    CGFloat arrowCenterY = self.mj_h * 0.5;
    CGPoint arrowCenter = CGPointMake(arrowCenterX, arrowCenterY);
    if (self.loadingView.constraints.count == 0) {
        self.loadingView.center = arrowCenter;
    }
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    if (state == MJRefreshStateIdle) {
        [self.loadingView startAnimating];
        
    }
}
@end
