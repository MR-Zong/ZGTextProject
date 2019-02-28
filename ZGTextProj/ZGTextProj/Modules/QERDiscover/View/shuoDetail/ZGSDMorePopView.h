//
//  ZGSDMorePopView.h
//  ZGTextProj
//
//  Created by ali on 2019/2/28.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZGSDCommentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZGSDMorePopView : UIView

- (instancetype)initWithCommentModel:(ZGSDCommentModel *)commentModel;
@property (nonatomic, copy) void(^selectedBlock)(ZGSDCommentModel *commentModel, NSString *selectedOption);

- (void)showInWindow:(UIView *)window moreBtn:(UIButton *)moreBtn;

@end

NS_ASSUME_NONNULL_END
