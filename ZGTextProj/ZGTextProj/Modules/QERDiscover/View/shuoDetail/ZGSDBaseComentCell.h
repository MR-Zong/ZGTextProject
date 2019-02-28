//
//  ZGSDBaseComentCell.h
//  ZGTextProj
//
//  Created by ali on 2019/2/27.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZGSDCommentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZGSDBaseComentCellBottomView : UIView

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIButton *moreBtn;

@end

@class ZGSDBaseComentCell;
@protocol ZGSDBaseComentCellDelegate <NSObject>

- (void)commentCell:(ZGSDBaseComentCell *)cell didTouchMoreBtn:(UIButton *)btn;
- (void)commentCell:(ZGSDBaseComentCell *)cell didTouchHeaderWithModel:(ZGSDCommentModel *)model;
- (void)commentCell:(ZGSDBaseComentCell *)cell didTouchContainViewWithModel:(ZGSDCommentModel *)model;

@end

@interface ZGSDBaseComentCell : UITableViewCell

@property (nonatomic, strong) ZGSDCommentModel *commentModel;

@property (nonatomic, strong) UIImageView *headerImgView;
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) ZGSDBaseComentCellBottomView *bottomView;

@property (nonatomic, weak) id <ZGSDBaseComentCellDelegate> delegate;

+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath withObject:(ZGSDCommentModel *)model;
+ (CGSize)containViewSizeWithObject:(ZGSDCommentModel *)model;

@end

NS_ASSUME_NONNULL_END
