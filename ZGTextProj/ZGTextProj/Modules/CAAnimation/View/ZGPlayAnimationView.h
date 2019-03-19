//
//  ZGPlayAnimationView.h
//  QianEr
//
//  Created by ali on 2019/3/19.
//  Copyright © 2019 com.alibaba-inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZGPlayAnimationView : UIView
@property (nonatomic, assign) CGFloat radius1;
@property (nonatomic, assign) CGFloat radius2;
@property (nonatomic, assign) CGFloat duration1;
@property (nonatomic, assign) CGFloat duration2;
- (void)startAnimation;
- (void)stopAnimation;
@end

NS_ASSUME_NONNULL_END
