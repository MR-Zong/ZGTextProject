//
//  ZGCalendarMonthCell.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/9/8.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const ZGCalendarMonthCellReusedID;

@class ZGMonthModel;

@interface ZGCalendarMonthCell : UICollectionViewCell

@property (nonatomic, strong) ZGMonthModel *monthModel;

@end
