//
//  ZGFixItemSpaceFlowLayout.m
//  ZGTextProj
//
//  Created by ali on 2018/12/13.
//  Copyright © 2018 XuZonggen. All rights reserved.
//

#import "ZGFixItemSpaceFlowLayout.h"

@implementation ZGFixItemSpaceFlowLayout

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    NSInteger cellCount = 0;
    for (UICollectionViewLayoutAttributes *layoutAttr in attributes) {
        if (layoutAttr.representedElementCategory == UICollectionElementCategoryCell) {
            cellCount++;
        }
        
    }
    if (cellCount < _zg_colCount && cellCount > 1) {
        
        
        NSMutableArray *cellLayoutAttributes = [NSMutableArray arrayWithCapacity:attributes.count];
        for (UICollectionViewLayoutAttributes *layoutAttr in attributes) {
            if (layoutAttr.representedElementCategory == UICollectionElementCategoryCell) {
                [cellLayoutAttributes addObject:layoutAttr];
            }
            
        }
        
        for(int i = 1; i < [cellLayoutAttributes count]; ++i) {
            UICollectionViewLayoutAttributes *currentLayoutAttributes = cellLayoutAttributes[i];
            UICollectionViewLayoutAttributes *prevLayoutAttributes = cellLayoutAttributes[i - 1];
            CGFloat maximumSpacing = 1;
            CGFloat origin = CGRectGetMaxX(prevLayoutAttributes.frame);
            // 如果当前一个cell的最右边加上我们想要的间距加上当前cell的宽度依然在contentSize中，我们改变当前cell的原点位置
            //            NSNumber *curLayoutY = [NSNumber numberWithFloat:currentLayoutAttributes.frame.origin.y];
            //            NSNumber *preLayoutY = [NSNumber numberWithFloat:prevLayoutAttributes.frame.origin.y];
            if(origin + maximumSpacing + currentLayoutAttributes.frame.size.width < self.collectionViewContentSize.width) {
                CGRect frame = currentLayoutAttributes.frame;
                frame.origin.x = origin + maximumSpacing;
                currentLayoutAttributes.frame = frame;
            }
            
        }
        
    }
    
    return attributes;
}

// 如果当前一个cell的最右边加上我们想要的间距加上当前cell的宽度依然在contentSize中，我们改变当前cell的原点位置
// 不加这个判断的后果是，UICollectionView只显示一行，原因是下面所有cell的x值都被加到第一行最后一个元素的后面了
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [super layoutAttributesForItemAtIndexPath:indexPath];
}

@end
