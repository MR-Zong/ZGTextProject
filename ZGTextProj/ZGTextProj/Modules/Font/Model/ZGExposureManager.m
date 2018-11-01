//
//  ZGRectUtil.m
//  ZGTextProj
//
//  Created by ali on 2018/10/31.
//  Copyright © 2018 XuZonggen. All rights reserved.
//

#import "ZGExposureManager.h"


typedef NS_ENUM(NSInteger,ZGCellAppearBeginType) {
    ZGCellAppearBeginTypeTop, // 从cell的top开始出现
    ZGCellAppearBeginTypeBottm,
    ZGCellAppearBeginTypeLeft,
    ZGCellAppearBeginTypeRight,
};

@implementation ZGExposureDataModel

@end


#pragma mark - - - - manager - -  - - -
@interface ZGExposureManager ()

@end

@implementation ZGExposureManager

- (void)zg_exposureWithDataModel:(ZGExposureDataModel *)dataModel scrollViewBounds:(CGRect)scrollViewBounds cellFrame:(CGRect)cellFrame exposureBlock:(ZGRectUtilExposureBlock)exposureBlock
{
    if (dataModel.alreadyExposured) {
        return;
    }
    
    CGFloat cellMaxY = CGRectGetMaxY(cellFrame);
    CGFloat scrollMaxY = CGRectGetMaxY(scrollViewBounds);
    
    // appear
    if (cellFrame.origin.y < scrollMaxY && cellFrame.origin.y >= scrollViewBounds.origin.y) {
        dataModel.appear = YES;
        [self processAppearType:ZGCellAppearBeginTypeTop scrollViewBounds:scrollViewBounds cellFrame:cellFrame dataModel:dataModel exposureBlock:exposureBlock];
    }
    
    if (cellMaxY > scrollViewBounds.origin.y && cellMaxY < scrollMaxY) {
        dataModel.appear = YES;
        [self processAppearType:ZGCellAppearBeginTypeBottm scrollViewBounds:scrollViewBounds cellFrame:cellFrame dataModel:dataModel exposureBlock:exposureBlock];
    }
    
    
    // disappear
    if (dataModel.appear) {
        if (cellFrame.origin.y >= scrollMaxY || cellMaxY <= scrollViewBounds.origin.y) {
            dataModel.alreadyExposured = NO;
            dataModel.appear = NO;
            dataModel.disappear = YES;
            dataModel.exposure_persent = 0;
            [self processExposureTimeWithDataModel:dataModel exposureBlock:exposureBlock];
        }
    }
}


- (void)processAppearType:(ZGCellAppearBeginType)appearType scrollViewBounds:(CGRect)scrollViewBounds cellFrame:(CGRect)cellFrame dataModel:(ZGExposureDataModel *)dataModel exposureBlock:(ZGRectUtilExposureBlock)exposureBlock
{
    // 计算percent
    float apperLen = 0;
    if (appearType == ZGCellAppearBeginTypeTop) {
        apperLen = CGRectGetMaxY(scrollViewBounds) - cellFrame.origin.y;
    }else {
        apperLen = CGRectGetMaxY(cellFrame) - scrollViewBounds.origin.y;
    }
    dataModel.exposure_persent = apperLen / cellFrame.size.height;
//    NSLog(@"exposure_persent %f, item %zd",dataModel.exposure_persent,dataModel.indexPath.item);
    [self processExposureTimeWithDataModel:dataModel exposureBlock:exposureBlock];
}

- (void)processExposureTimeWithDataModel:(ZGExposureDataModel *)dataModel exposureBlock:(ZGRectUtilExposureBlock)exposureBlock
{
    // 计算 曝光时间
    
    if (dataModel.exposure_persent >= 0.5) {
        if (!dataModel.moreHalfPercent) {
            dataModel.moreHalfPercent = YES;
            dataModel.moreHalfDate = [NSDate date];
        }
    }else {
        if (dataModel.moreHalfPercent) {
            dataModel.moreHalfPercent = NO;
            
            // 累加时间 累加超过500ms就，直接调用exposureBlock
            NSDate *noMoreHalfDate = [NSDate date];
            long long exposureKeepTime = (long long)[noMoreHalfDate timeIntervalSince1970]*1000 - (long long)[dataModel.moreHalfDate timeIntervalSince1970]*1000;
            NSLog(@"exposureKeepTime %lld",exposureKeepTime);
            dataModel.keepTimeSum += exposureKeepTime;
            if (dataModel.keepTimeSum >= 500) {
                dataModel.alreadyExposured = YES;
                NSLog(@"xxxxxxxxxxxxxxxxxxxx");
                if (exposureBlock) {
                    exposureBlock();
                }
            }
        }// end if (dataModel.moreHalfPercent)

    }
    
    
    
    if (dataModel.disappear) {
        
        if (dataModel.moreHalfPercent) {
            NSDate *disappearDate = [NSDate date];
            long long exposureKeepTime = (long long)[disappearDate timeIntervalSince1970]*1000 - (long long)[dataModel.moreHalfDate timeIntervalSince1970]*1000;
            
            if (dataModel.keepTimeSum > 0) {
                dataModel.keepTimeSum += exposureKeepTime;
            }else {
                dataModel.keepTimeSum = exposureKeepTime;
            }
            
            if (dataModel.keepTimeSum >= 500) {
                dataModel.alreadyExposured = YES;
                if (exposureBlock) {
                    exposureBlock();
                }
            }
        }// end if (_dataModel.moreHalfPercent)
    }
    
}

#pragma mark - 500ms到，统一一次曝光
- (void)zg_exposureStatisticWithDataModel:(ZGExposureDataModel *)dataModel exposureBlock:(ZGRectUtilExposureBlock)exposureBlock
{
    if (dataModel.exposure_persent > 0.5 && !dataModel.alreadyExposured) {
        dataModel.alreadyExposured = YES;
        if (exposureBlock) {
            exposureBlock();
        }
    }
}

@end
