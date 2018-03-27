//
//  ZGCalendarMonthCell.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/9/8.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import "ZGCalendarMonthCell.h"
#import "ZGCalendarCell.h"
#import "ZGCalendarManager.h"
#import "ZGDayModel.h"
#import "ZGMonthModel.h"

NSString *const ZGCalendarMonthCellReusedID = @"ZGCalendarMonthCellReusedID";

@interface ZGCalendarMonthCell () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *daysArray;


@end


@implementation ZGCalendarMonthCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    // collectionView
    CGRect collectionViewFrame = self.bounds;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(collectionViewFrame.size.width / 7.0, collectionViewFrame.size.height / 6);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:flowLayout];
    _collectionView.scrollEnabled = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[ZGCalendarCell class] forCellWithReuseIdentifier:ZGCalendarCellReusedID];
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_collectionView];

}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.daysArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZGCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZGCalendarCellReusedID forIndexPath:indexPath];

    cell.dayModel = self.daysArray[indexPath.item];;
    
    return cell;
}

#pragma mark - setter
- (void)setMonthModel:(ZGMonthModel *)monthModel
{
    _monthModel = monthModel;
    self.daysArray = monthModel.daysArray;
    [self.collectionView reloadData];

}



@end
