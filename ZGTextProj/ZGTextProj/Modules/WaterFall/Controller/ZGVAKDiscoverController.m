//
//  ZGVAKDiscoverController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/9/9.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGVAKDiscoverController.h"
#import "ZGVAKDiscoverReusableViewHeader.h"
#import "ZGVAKDiscoverReusableViewFooter.h"

@interface ZGVAKDiscoverController () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ZGVAKDiscoverController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupViews];
}

- (void)setupViews
{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemWidth = ([UIScreen mainScreen].bounds.size.width - 2*10 - 2*15) / 3.0;
    CGFloat itemHeight = itemWidth;
    flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
    flowLayout.headerReferenceSize = CGSizeMake(100, 22);
    flowLayout.footerReferenceSize = CGSizeMake(100, 5);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor blackColor];
    _collectionView.dataSource = self;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"vakDiscoverCell"];
    [_collectionView registerClass:[ZGVAKDiscoverReusableViewHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"vakDiscoverHeader"];
    [_collectionView registerClass:[ZGVAKDiscoverReusableViewFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"vakDiscoverFooter"];
    [self.view addSubview:_collectionView];
}


#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 20;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"vakDiscoverCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"vakDiscoverHeader" forIndexPath:indexPath];
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"vakDiscoverFooter" forIndexPath:indexPath];
    }
    
    return reusableview;
}

@end
