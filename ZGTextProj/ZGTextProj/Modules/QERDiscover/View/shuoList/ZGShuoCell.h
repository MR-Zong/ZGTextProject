//
//  ZGDiscoverCell.h
//  ZGTextProj
//
//  Created by ali on 2019/2/27.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZGShuoModel.h"
#import "ZGShuoBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZGShuoCell : ZGShuoBaseCell

@property (nonatomic, strong) ZGShuoModel *shuoModel;
+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath withObject:(ZGShuoModel *)model;

@end

NS_ASSUME_NONNULL_END
