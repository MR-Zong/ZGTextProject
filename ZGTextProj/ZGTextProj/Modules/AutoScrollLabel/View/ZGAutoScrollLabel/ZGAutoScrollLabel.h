//
//  ZGAutoScrollLabel.h
//  ZGTextProj
//
//  Created by ali on 2018/10/25.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,ZGAutoScrollDirection) {
    ZGAutoScrollDirectionLeftToRight, // 从左往右
    ZGAutoScrollDirectionRightToLeft, // 从右往左
};


/**
 * 注意 ： 目前只支持frame 布局 不支持 auto layout
 */
@interface ZGAutoScrollLabel : UIScrollView

/**
 * 滚动方向
 */
@property (nonatomic, assign) ZGAutoScrollDirection scrollDirection;
/**
 * 文本 相关属性
 */
@property (nonatomic, strong) NSString *text;
@property(null_resettable, nonatomic,strong) UIFont *font;
@property(null_resettable, nonatomic,strong) UIColor *textColor;
/**
 * 滚动动画间隔
 */
@property (nonatomic, assign) float pauseInterval;
/**
 * 延迟开始动画时间
 */
@property (nonatomic, assign) float delayInterval;

/**
 * text 之间间隔
 */
@property (nonatomic, assign) float spaceBetweenLabels;

/**
 * 滚动速度 取值：1-100 默认 50
 */
@property(nonatomic, assign) float scrollSpeed;

/**
 * 开始滚动动画
 */
- (void)strartAnimation;
/**
 * 开始滚动动画 with text
 */
- (void)startAnimationWithText:(NSString *)text;
/**
 * 继续动画
 */
- (void)continueAnimation;

/**
 * 停止动画
 */
- (void)stopAnimation;

-(void)reset;

@end

NS_ASSUME_NONNULL_END
