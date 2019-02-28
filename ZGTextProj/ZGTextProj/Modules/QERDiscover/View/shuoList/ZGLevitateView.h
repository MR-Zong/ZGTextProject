//
//  ZGLevitateView.h
//  ZGTextProj
//
//  Created by ali on 2019/2/27.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZGShuoModel.h"

NS_ASSUME_NONNULL_BEGIN

@class ZGLevitateView;

@protocol ZGLevitateViewDelegate <NSObject>

- (void)levitateView:(ZGLevitateView *)view didTouchCDithModel:(ZGShuoModel *)model;
- (void)levitateView:(ZGLevitateView *)view didNextWithModel:(ZGShuoModel *)model;
- (void)levitateView:(ZGLevitateView *)view didReplayWithModel:(ZGShuoModel *)model;

@end

@interface ZGLevitateView : UIView

@property (nonatomic, weak) id <ZGLevitateViewDelegate> delegate;
- (void)playWithShuoModel:(ZGShuoModel *)shuoModel;

@end

NS_ASSUME_NONNULL_END
