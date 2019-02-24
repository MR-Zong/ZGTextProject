
//
//  ZGNoDataView.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/1/5.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZGWKWebNoDataView;

@interface ZGWKWebNoDataViewModel : NSObject
+ (instancetype)noDataViewModelWithCode:(NSInteger)code message:(NSString *)message error:(NSError *)error;
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSError *error;
@end

#pragma mark - - ---- - ------ ----- ------
@protocol ZGWKWebNoDataViewDelegate <NSObject>

- (void)noDataViewDidTap:(ZGWKWebNoDataView *)noDataView;

@end

@interface ZGWKWebNoDataView : UIView

#pragma mark - 点击回调
@property (nonatomic, copy) void (^didTapBlock)(ZGWKWebNoDataView *noDataView);
@property (nonatomic, weak) id <ZGWKWebNoDataViewDelegate> delegate;

#pragma mark - 设置图片，文本方法
- (void)setIconImgViewWidth:(CGFloat)width iconImgViewHeight:(CGFloat)height;
- (void)setImage:(UIImage *)image text:(NSString *)text;
- (void)setImage:(UIImage *)image attributeText:(NSAttributedString *)attributeText;

#pragma mark - animateImgView
- (void)showAnimateImgViewWithIsEmpty:(BOOL)isEmpty;
- (void)hiddenAnimateImgView;

#pragma mark - Update noDataView
- (void)updateWithTotalCount:(NSInteger)totalCount model:(ZGWKWebNoDataViewModel *)model;

@end
