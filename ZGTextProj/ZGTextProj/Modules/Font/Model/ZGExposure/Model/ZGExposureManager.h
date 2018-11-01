//
//  ZGRectUtil.h
//  ZGTextProj
//
//  Created by ali on 2018/10/31.
//  Copyright © 2018 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


UIKIT_EXTERN NSString *const ZGExposure_scrollViewBounds_key;
UIKIT_EXTERN NSString *const ZGExposure_indexPath_key;


typedef void(^ZGRectUtilExposureBlock)(void);

@interface ZGExposureDataModel : NSObject

@property (nonatomic, assign) float exposure_persent;
@property (nonatomic, assign) BOOL appear;
@property (nonatomic, assign) BOOL disappear;
@property (nonatomic, assign) BOOL moreHalfPercent;
@property (nonatomic, strong) NSDate *moreHalfDate;
@property (nonatomic, assign) NSInteger keepTimeSum;
@property (nonatomic, assign) BOOL isImageDisplay;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) BOOL alreadyExposured;

@end



@interface ZGExposureManager : NSObject

/**
 * uniqueID:一般用控制器的类名就可以了
 * 特别强调 uniqueID 是为生成唯一的通知名，所以特别重要
 */
+ (instancetype)managerWithUniqueID:(NSString *)uniqueID;
+ (NSString *const)zg_exposure_contentOffsetChangeNotifyNameWithUniqueID:(NSString *)uniqueID;
+ (NSString *const)zg_exposure_statisticNotifyNameWithUniqueID:(NSString *)uniqueID;

#pragma mark - 提供给cell，收到通知调用的方法
- (void)zg_exposureWithDataModel:(ZGExposureDataModel *)dataModel scrollViewBounds:(CGRect)scrollViewBounds cellFrame:(CGRect)cellFrame exposureBlock:(ZGRectUtilExposureBlock)exposureBlock;
- (void)zg_exposure_statisticWithDataModel:(ZGExposureDataModel *)dataModel exposureBlock:(ZGRectUtilExposureBlock)exposureBlock;

#pragma mark - 提供给，控制器，scrollView状态调用
- (void)zg_exposure_scrollViewDidScrollWithScrollViewBounds:(CGRect)scrollViewBounds;
- (void)zg_exposure_scrollDidEnd;
- (void)zg_exposure_statisticWithIndexPath:(NSIndexPath *)indexPath;
- (void)zg_exposure_viewDidAppearWithScrollViewBounds:(CGRect)scrollViewBounds;


@end



NS_ASSUME_NONNULL_END
