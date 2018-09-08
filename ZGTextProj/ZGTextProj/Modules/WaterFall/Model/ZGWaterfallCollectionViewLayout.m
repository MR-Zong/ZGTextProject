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

@property (nonatomic, assign) CGFloat collectionViewMarginLeft;
@property (nonatomic, assign) CGFloat  collectionViewMarginRight;
@property (nonatomic, assign) CGFloat  itemHorizontalGap;
@property (nonatomic, assign) CGFloat  itemVerticalGap;
@property (nonatomic, assign) CGFloat  itemWidth;


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
        _numbersOfColumn = 3;
        [self setupColumnMaxYs];
//        _columnMaxYs = [NSMutableArray arrayWithArray:@[@0,@0,@0]];
//        self.rowSpacing = 10.0f;
//        2self.lineSpacing = 10.0f;
//        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _itemsAttributes = [NSMutableArray array];
        
        
        _collectionViewMarginLeft = 0;
        _collectionViewMarginRight = _collectionViewMarginLeft;
        _itemHorizontalGap = 5;
        _itemVerticalGap = 5;
    }
    
    return self;
}

- (void)setupColumnMaxYs
{
    _columnMaxYs = [NSMutableArray arrayWithCapacity:_numbersOfColumn];
    for (int i=0;i<_numbersOfColumn; i++) {
        [_columnMaxYs addObject:@0];
    }
}

- (void)setNumbersOfColumn:(NSInteger)numbersOfColumn
{
    _numbersOfColumn = numbersOfColumn;
    [self setupColumnMaxYs];
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    _itemWidth = (self.collectionView.frame.size.width - _collectionViewMarginLeft - _collectionViewMarginRight - (_numbersOfColumn - 1) * _itemHorizontalGap) / _numbersOfColumn;

    
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


    if (layoutAttributes.frame.size.width > 0) {
        return self.itemsAttributes[indexPath.item];
    }
    
    CGFloat itemHeight = 100;
    if (self.delegate && [self.delegate respondsToSelector:@selector(zg_waterfallCollectionViewLayout:heightForItemAtIndexPath:)]) {
        itemHeight = [self.delegate zg_waterfallCollectionViewLayout:self heightForItemAtIndexPath:indexPath];
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
    
    CGFloat itemX = self.collectionViewMarginLeft + columnOfMinMaxY * (self.itemWidth + self.itemHorizontalGap);
    CGFloat itemY = minMaxY + self.itemVerticalGap;
    layoutAttributes.frame = CGRectMake(itemX, itemY, self.itemWidth, itemHeight);
    
    // 更新存放每列maxY的数组
    _columnMaxYs[columnOfMinMaxY] = @([_columnMaxYs[columnOfMinMaxY] floatValue] + itemHeight + self.itemVerticalGap);
    
    return layoutAttributes;
}

- (CGSize)collectionViewContentSize
{
    // 算出最高的那一列
    CGFloat maxY = [_columnMaxYs[0] floatValue];
    for (int i= 0; i<_columnMaxYs.count; i++) {
        if (maxY < [_columnMaxYs[i] floatValue]) {
            maxY = [_columnMaxYs[i] floatValue];
        }
    }

    return CGSizeMake(self.collectionView.frame.size.width, maxY + self.itemVerticalGap);
}

@end
