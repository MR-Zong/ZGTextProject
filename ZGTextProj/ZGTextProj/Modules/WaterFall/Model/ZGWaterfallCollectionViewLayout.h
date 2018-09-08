//
//  ZGWaterfallCollectionViewLayout.h
//  ZGWaterfallCollectionViewLayout
//
//  Created by Zong on 16/3/7.
//  Copyright © 2016年 Zong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZGWaterfallCollectionViewLayout;

@protocol ZGWaterfallCollectionViewLayoutDelegate <NSObject>

@required
- (CGFloat)zg_waterfallCollectionViewLayout:(ZGWaterfallCollectionViewLayout *)waterfallCollectionViewLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface ZGWaterfallCollectionViewLayout : UICollectionViewLayout

@property (assign, nonatomic) NSInteger numbersOfColumn;
@property (weak, nonatomic) id <ZGWaterfallCollectionViewLayoutDelegate>delegate;

@end
