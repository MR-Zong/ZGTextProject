//
//  ZGExposureCell.h
//  ZGTextProj
//
//  Created by ali on 2018/10/31.
//  Copyright © 2018 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZGExposureManager;
@class ZGExposureDataModel;

UIKIT_EXTERN NSString *const ZGExposureContentOffsetChangeNotify;
UIKIT_EXTERN NSString *const ZGExposureStatisticNotify;

@interface ZGExposureCell : UICollectionViewCell

@property (nonatomic, strong) ZGExposureDataModel *exp_dataModel;
@property (nonatomic, weak) ZGExposureManager *exposureMgr;

@end

NS_ASSUME_NONNULL_END
