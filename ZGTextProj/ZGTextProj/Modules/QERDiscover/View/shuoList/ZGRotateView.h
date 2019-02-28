//
//  ZGRotateView.h
//  ZGTextProj
//
//  Created by ali on 2019/2/28.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZGRotateView : UIView

- (void)startRotating;
- (void)stopRotating;
- (void)resumeRotate;
- (void)reset;
@property (nonatomic, strong) UIImageView *coverImgView;


@end

NS_ASSUME_NONNULL_END
