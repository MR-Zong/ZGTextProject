//
//  ZGGradiantView.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2019/2/24.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZGGradiantView : UIView

@property (nonatomic, strong) UIColor *startColor;
@property (nonatomic, strong) UIColor *endColor;
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGPoint endPoint;

@property (nonatomic, assign) CGFloat cornerRadius_topRight;
@property (nonatomic, assign) CGFloat cornerRadius_topLeft;
@property (nonatomic, assign) CGFloat cornerRadius_bottomRight;
@property (nonatomic, assign) CGFloat cornerRadius_bottomLeft;

@end

NS_ASSUME_NONNULL_END
