//
//  ZGIMBaseCell.h
//  ZGTextProj
//
//  Created by ali on 2019/1/24.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZGIMMessage;

@interface ZGIMBaseCell : UITableViewCell

@property (nonatomic, strong) ZGIMMessage *message;

@end

NS_ASSUME_NONNULL_END
