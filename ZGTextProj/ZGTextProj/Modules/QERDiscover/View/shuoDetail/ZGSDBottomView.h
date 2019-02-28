//
//  ZGSDBottomView.h
//  ZGTextProj
//
//  Created by ali on 2019/2/27.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZGSDBottomView;

@protocol ZGSDBottomViewDelegate <NSObject>

- (void)bottomView:(ZGSDBottomView *)bottomView didRecordBtn:(UIButton *)btn;

@end

@interface ZGSDBottomView : UIView

@property (nonatomic, weak) id <ZGSDBottomViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
