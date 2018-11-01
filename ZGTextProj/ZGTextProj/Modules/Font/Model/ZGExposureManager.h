//
//  ZGRectUtil.h
//  ZGTextProj
//
//  Created by ali on 2018/10/31.
//  Copyright © 2018 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ZGRectUtilExposureBlock)(void);

@interface ZGExposureDataModel : NSObject

@property (nonatomic, assign) float exposure_persent;
@property (nonatomic, assign) BOOL appear;
@property (nonatomic, assign) BOOL disappear;
@property (nonatomic, assign) BOOL moreHalfPercent;
@property (nonatomic, strong) NSDate *moreHalfDate;
@property (nonatomic, assign) NSInteger keepTimeSum;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) BOOL alreadyExposured;

@end



@interface ZGExposureManager : NSObject

- (void)zg_exposureWithDataModel:(ZGExposureDataModel *)dataModel scrollViewBounds:(CGRect)scrollViewBounds cellFrame:(CGRect)cellFrame exposureBlock:(ZGRectUtilExposureBlock)exposureBlock;
- (void)zg_exposureStatisticWithDataModel:(ZGExposureDataModel *)dataModel exposureBlock:(ZGRectUtilExposureBlock)exposureBlock;

@end



NS_ASSUME_NONNULL_END
