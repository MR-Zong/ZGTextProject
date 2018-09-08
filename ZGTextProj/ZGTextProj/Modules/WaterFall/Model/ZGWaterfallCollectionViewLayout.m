//
//  ZGWaterfallCollectionViewLayout.m
//  ZGWaterfallCollectionViewLayout
//
//  Created by Zong on 16/3/7.
//  Copyright © 2016年 Zong. All rights reserved.
//

#import "ZGWaterfallCollectionViewLayout.h"

@interface ZGWaterfallCollectionViewLayout ()

@property (strong, nonatomic) NSMutableArray *itemsAttributes;

@property (strong, nonatomic) NSMutableArray *columnMaxYs;


@end

@implementation ZGWaterfallCollectionViewLayout

- (instancetype)init
{
    if (self = [super init]) {
        
        //对默认属性进行设置
        /**
         默认行数 3行
         默认行间距 10.0f
         默认列间距 10.0f
         默认内边距 top:10 left:10 bottom:10 right:10
         */
        self.numbersOfColumn = 3;
//        self.rowSpacing = 10.0f;
//        2self.lineSpacing = 10.0f;
//        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _itemsAttributes = [NSMutableArray array];
        _columnMaxYs = [NSMutableArray arrayWithArray:@[@0,@0,@0]];
    }
    
    return self;
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (int i=0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [_itemsAttributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return _itemsAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat collectionViewMarginLeft = 0;
    CGFloat collectionViewMarginRight = collectionViewMarginLeft;
    CGFloat itemHorizontalGap = 5;
    CGFloat itemVerticalGap = 5;
    
    CGFloat itemWidth = (self.collectionView.frame.size.width - collectionViewMarginLeft - collectionViewMarginRight -
                         (_numbersOfColumn - 1) * itemHorizontalGap) / _numbersOfColumn;
    
    CGFloat itemHeight = 100;
    if (self.delegate && [self.delegate respondsToSelector:@selector(waterfallCollectionViewLayout:heightForItemAtIndexPath:)]) {
        itemHeight = [self.delegate waterfallCollectionViewLayout:self heightForItemAtIndexPath:indexPath];
    }
    
    // 算出最短的那一列
    CGFloat minMaxY = [_columnMaxYs[0] floatValue];
    NSInteger columnOfMinMaxY = 0;
    for (int i= 0; i<_columnMaxYs.count; i++) {
        if (minMaxY > [_columnMaxYs[i] floatValue]) {
            minMaxY = [_columnMaxYs[i] floatValue];
            columnOfMinMaxY = i;
        }
    }
    
    
    CGFloat itemX = collectionViewMarginLeft + columnOfMinMaxY * (itemWidth + itemHorizontalGap);
    CGFloat itemY = minMaxY + itemVerticalGap;
    
    layoutAttributes.frame = CGRectMake(itemX, itemY, itemWidth, itemHeight);
    
    // 更新存放每列maxY的数组
    _columnMaxYs[columnOfMinMaxY] = @([_columnMaxYs[columnOfMinMaxY] floatValue] + itemHeight + itemVerticalGap);
    
    return layoutAttributes;
}

- (CGSize)collectionViewContentSize
{
    CGFloat itemVerticalGap = 5;
    // 算出最高的那一列
    CGFloat maxY = [_columnMaxYs[0] floatValue];
    for (int i= 0; i<_columnMaxYs.count; i++) {
        if (maxY < [_columnMaxYs[i] floatValue]) {
            maxY = [_columnMaxYs[i] floatValue];
        }
    }

    return CGSizeMake(self.collectionView.frame.size.width, maxY + itemVerticalGap);
}

@end
