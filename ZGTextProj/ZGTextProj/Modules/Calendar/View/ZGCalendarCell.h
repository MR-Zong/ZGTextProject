//
//  ZGCalendarCell.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/9/8.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const ZGCalendarCellReusedID;

@class ZGDayModel;

@interface ZGCalendarCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *dateLable;
@property (nonatomic, strong) UILabel *chineseLable;
@property (nonatomic, strong) ZGDayModel *dayModel;


@end
