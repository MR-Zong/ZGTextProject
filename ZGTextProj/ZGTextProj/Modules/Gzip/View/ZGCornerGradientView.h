//
//  ZGCornerGradientView.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2019/2/24.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZGCornerGradientView : UIView

@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) CGFloat cornerRadius_topRight;
@property (nonatomic, assign) CGFloat cornerRadius_topLeft;
@property (nonatomic, assign) CGFloat cornerRadius_bottomRight;
@property (nonatomic, assign) CGFloat cornerRadius_bottomLeft;

@end

NS_ASSUME_NONNULL_END
