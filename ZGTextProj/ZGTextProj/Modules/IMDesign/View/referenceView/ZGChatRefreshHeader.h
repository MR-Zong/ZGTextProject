//
//  ZGChatRefreshHeader.h
//  ZGTextProj
//
//  Created by ali on 2019/2/21.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZGChatRefreshHeader : MJRefreshStateHeader

/** 菊花的样式 */
@property (assign, nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;
/** 停止菊花动画 */
- (void)stopActivityAnimation;

@end

NS_ASSUME_NONNULL_END
