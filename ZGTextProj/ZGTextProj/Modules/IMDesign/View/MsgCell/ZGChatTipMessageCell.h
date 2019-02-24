//
//  ZGChatTipMessageCell.h
//  ZGTextProj
//
//  Created by ali on 2019/2/21.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZGChatTipMesageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZGChatTipMessageCell : UITableViewCell

@property (nonatomic, strong) ZGChatTipMesageModel *tipModel;
+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath withObject:(ZGChatTipMesageModel *)model;

@end

NS_ASSUME_NONNULL_END
