//
//  ZGTextCollectionviewController.m
//  ZGTextProj
//
//  Created by ali on 2018/12/13.
//  Copyright © 2018 XuZonggen. All rights reserved.
//

#import "ZGTextCollectionviewController.h"
#import "ZGFixItemSpaceFlowLayout.h"

@interface ZGTextCollectionviewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ZGTextCollectionviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
}


- (void)setupViews
{
    ZGFixItemSpaceFlowLayout *flowLayout = [[ZGFixItemSpaceFlowLayout alloc] init];
    //    CGFloat itemW = [UIScreen mainScreen].bounds.size.width /3.0;
    //    CGFloat itemH = itemW / (119.0/160.0);
    //    flowLayout.itemSize = CGSizeMake(itemW, itemW);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.zg_colCount = 3;
//    flowLayout.headerReferenceSize = CGSizeMake(100, 142+22);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor blackColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"testUICollectionViewCellReusedId"];
    [self.view addSubview:_collectionView];
    
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSources
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"testUICollectionViewCellReusedId" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 100);
}
@end
