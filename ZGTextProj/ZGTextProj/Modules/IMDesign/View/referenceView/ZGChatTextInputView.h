//
//  ZGChatTextInputView.h
//  ZGTextProj
//
//  Created by ali on 2019/2/18.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZGChatInputInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN CGFloat ZGChatTextInputView_H;

@interface ZGChatTextInputView : UIView

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, copy) void(^sendBlock)(ZGChatInputInfoModel *inputInfoModel);
- (void)hideKeyboard;

@end

NS_ASSUME_NONNULL_END
