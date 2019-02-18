//
//  ZGMsgBottomView.h
//  ZGTextProj
//
//  Created by ali on 2019/2/15.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZGMsgBottomView;

@protocol ZGMsgBottomViewDelegate <NSObject>

- (void)bottomView:(ZGMsgBottomView *)bottomView didRecordBtn:(UIButton *)btn;

@end

@interface ZGMsgBottomView : UIView

@property (nonatomic, weak) id <ZGMsgBottomViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
