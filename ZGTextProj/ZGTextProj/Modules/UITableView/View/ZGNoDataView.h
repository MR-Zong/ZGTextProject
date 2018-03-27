//
//  ZGNoDataView.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/1/5.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZGNoDataView;

@protocol ZGNoDataViewDelegate <NSObject>

- (void)noDataViewDidTap:(ZGNoDataView *)noDataView;

@end

@interface ZGNoDataView : UIView

#pragma mark - 点击回调
@property (nonatomic, copy) void (^didTapBlock)(ZGNoDataView *noDataView);
@property (nonatomic, weak) id <ZGNoDataViewDelegate> delegate;

#pragma mark - 设置图片，文本方法
- (void)setIconImgViewWidth:(CGFloat)width iconImgViewHeight:(CGFloat)height;
- (void)setImage:(UIImage *)image text:(NSString *)text;
- (void)setImage:(UIImage *)image attributeText:(NSAttributedString *)attributeText;

@end
