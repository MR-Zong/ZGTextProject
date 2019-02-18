//
//  ZGChatBaseCell.h
//  ZGTextProj
//
//  Created by ali on 2019/2/18.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZGChatBaseBubbleView.h"
#import "ZGChatMessageModel.h"
#import "ZGChatConst.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZGChatBaseCell : UITableViewCell{
    UIImageView *_headImageView;
    UILabel *_nameLabel;
    ZGChatBaseBubbleView *_bubbleView;
}

@property (nonatomic, strong) UIImageView *headImageView;       //头像
@property (nonatomic, strong) UILabel *nameLabel;               //姓名（暂时不支持显示）
@property (nonatomic, strong) ZGChatBaseBubbleView *bubbleView;   //内容区域

@property (nonatomic, strong) ZGChatMessageModel *messageModel;

- (id)initWithMessageModel:(ZGChatMessageModel *)model reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setupSubviewsForMessageModel:(ZGChatMessageModel *)model;

+ (NSString *)cellIdentifierForMessageModel:(ZGChatMessageModel *)model;

+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath withObject:(ZGChatMessageModel *)model;

@end

NS_ASSUME_NONNULL_END
