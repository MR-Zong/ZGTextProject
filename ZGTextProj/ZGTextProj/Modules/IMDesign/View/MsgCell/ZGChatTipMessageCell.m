//
//  ZGChatTipMessageCell.m
//  ZGTextProj
//
//  Created by ali on 2019/2/21.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGChatTipMessageCell.h"
#import <Masonry.h>

@interface ZGChatTipMessageCell ()

@property (nonatomic, strong) UILabel *tipLabel;

@end

@implementation ZGChatTipMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = [UIFont systemFontOfSize:14];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.numberOfLines = 0;
        [self.contentView addSubview:_tipLabel];
        
        // auto layout
        [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10.f);
            make.right.equalTo(self.contentView).offset(-10.f);
            make.centerY.equalTo(self.contentView);
        }];
    }
    return self;
}

#pragma mark - setter
- (void)setTipModel:(ZGChatTipMesageModel *)tipModel
{
    _tipModel = tipModel;
    
    if (tipModel.tipType == ZGChatTipMesageType_Be_Deleted_Friend) {
        self.tipLabel.text = @"发送失败，你已经被对方删除";
    }else if (tipModel.tipType == ZGChatTipMesageType_DrawInto_Blacklist) {
        self.tipLabel.text = @"你已经被对方拉黑，不能发送消息";
    }
}

+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath withObject:(ZGChatTipMesageModel *)model
{
    return 40;
}


@end
