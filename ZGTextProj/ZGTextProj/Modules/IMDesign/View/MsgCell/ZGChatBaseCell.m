//
//  ZGChatBaseCell.m
//  ZGTextProj
//
//  Created by ali on 2019/2/18.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGChatBaseCell.h"

@interface ZGChatBaseCell ()

@end

@implementation ZGChatBaseCell


- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect frame = _headImageView.frame;
    frame.origin.x = _messageModel.isSender ? (self.bounds.size.width - _headImageView.frame.size.width - ZGCHAT_HEAD_CELL_SPACE) : ZGCHAT_HEAD_CELL_SPACE;
    _headImageView.frame = frame;
    
    _nameLabel.frame = CGRectMake(CGRectGetMaxX(_headImageView.frame) + 10, CGRectGetMinY(_headImageView.frame), ZGCHAT_NAME_LABEL_WIDTH, ZGCHAT_NAME_LABEL_HEIGHT);
}

- (void)setMessageModel:(ZGChatMessageModel *)messageModel {
    _messageModel = messageModel;
    
    _nameLabel.hidden = !messageModel.isChatGroup;
    NSString *imgaeName = nil;
    if (_messageModel.isSender) {
        imgaeName = @"receive_head.jpg";
    } else {
        imgaeName = @"send_head.jpg";
    }
    self.headImageView.image = [UIImage imageNamed:imgaeName];
}

#pragma mark - 事件监听
- (void)headImagePressed:(id)sender {
    // 头像点击处理
}



#pragma mark - public
- (id)initWithMessageModel:(ZGChatMessageModel *)model reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headImagePressed:)];
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ZGCHAT_HEAD_CELL_SPACE, 0, ZGCHAT_HEAD_SIZE, ZGCHAT_HEAD_SIZE)];
        [_headImageView addGestureRecognizer:tap];
        _headImageView.userInteractionEnabled = YES;
        _headImageView.multipleTouchEnabled = YES;
        _headImageView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_headImageView];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textColor = [UIColor grayColor];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_nameLabel];
        
        [self setupSubviewsForMessageModel:model];
    }
    return self;
}

- (void)setupSubviewsForMessageModel:(ZGChatMessageModel *)model {
    if (model.isSender) {
        self.headImageView.frame = CGRectMake(self.bounds.size.width - ZGCHAT_HEAD_SIZE - ZGCHAT_HEAD_CELL_SPACE, ZGCHAT_CELL_PADDING, ZGCHAT_HEAD_SIZE, ZGCHAT_HEAD_SIZE);
    } else {
        self.headImageView.frame = CGRectMake(0, ZGCHAT_CELL_PADDING, ZGCHAT_HEAD_SIZE, ZGCHAT_HEAD_SIZE);
    }
}

+ (NSString *)cellIdentifierForMessageModel:(ZGChatMessageModel *)model {
    NSString *identifier = @"ZGMessageCell";
    if (model.isSender) {
        identifier = [identifier stringByAppendingString:@"Sender"];
    } else {
        identifier = [identifier stringByAppendingString:@"Receiver"];
    }
    
    switch (model.type) {
        case ZGChatMessageType_Text: {
            identifier = [identifier stringByAppendingString:@"Text"];
            break;
        }
        case ZGChatMessageType_Audio: {
            identifier = [identifier stringByAppendingString:@"Image"];
            break;
        }
            
        default:
            break;
    }
    
    return identifier;
}

+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath withObject:(ZGChatMessageModel *)model {
    return ZGCHAT_HEAD_SIZE + ZGCHAT_CELL_PADDING;
}

@end
