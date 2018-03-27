//
//  ZGTbBaseTableView.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/1/5.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZGNoDataView.h"

typedef NS_ENUM(NSInteger,ZGTbBaseTableViewActionType) {
    ZGTbBaseTableViewActionTypeDown, // 下拉
    ZGTbBaseTableViewActionTypeUp, // 上拉
};

@class ZGTbBaseTableView;
@protocol ZGTbBaseTableViewDelegate <NSObject>

/**
 * 上拉，下拉事件 回调
 */
- (void)zgTableView:(ZGTbBaseTableView *)tableView refreshWithActionType:(ZGTbBaseTableViewActionType)actionType;

/**
 * 点击noDataView 回调
 */
- (void)zgTableViewDidTouchNoDataView:(ZGTbBaseTableView *)tableView;

@end

@interface ZGTbBaseTableView : UITableView

/**
 * tableView 对 dataArrayCount 进行状态处理
 * 1，有数据 reloadData
 * 2，没数据，显示空
 */
- (void)reloadDataWithDataArrayCount:(NSInteger)dataArrayCount;

/**
 * noDataView
 */
@property (nonatomic,strong) ZGNoDataView *noDataView;

/**
 * 上拉，下拉事件 delegate
 */
@property (nonatomic,weak) id<ZGTbBaseTableViewDelegate> refreshDelegate;

@end
