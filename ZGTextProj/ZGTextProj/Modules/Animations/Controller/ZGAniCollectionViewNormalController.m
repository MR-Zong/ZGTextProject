//
//  ZGAniCollectionViewNormalController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/6/21.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGAniCollectionViewNormalController.h"

@interface ZGAniCollectionViewNormalController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewCell *headerCell;
@property (nonatomic, assign) CGFloat headerCellHeight;

@end

@implementation ZGAniCollectionViewNormalController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initialize];
    [self setupViews];
}

- (void)initialize
{
    ;
}

- (void)setupViews
{
    
    //    _cellTeHeight = 364;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 3;
    flowLayout.minimumInteritemSpacing = 3;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor redColor];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"animationCollectCellReusedId"];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"ZGHeaderCollectionViewCellReusedId"];
    
    [self.view addSubview:_collectionView];
    
    // headerCell
    _headerCellHeight = 364;
    _headerCell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"ZGHeaderCollectionViewCellReusedId" forIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    _headerCell.backgroundColor = [UIColor purpleColor];
}


#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == 0) {
        // 如果 返回一个固定的。。会闪屏
//        return self.headerCell;
        
        UICollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"ZGHeaderCollectionViewCellReusedId" forIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        cell.backgroundColor = [UIColor purpleColor];
        NSLog(@"cell %@",cell);
        return cell;
    }
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"animationCollectCellReusedId" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.headerCellHeight == 364) {
        self.headerCellHeight = 396;
    }else {
        self.headerCellHeight = 364;
    }

    [collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]]];

}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == 0) {
        return CGSizeMake(self.view.bounds.size.width, self.headerCellHeight);
    }
    
    return CGSizeMake(self.view.bounds.size.width, 44);
}



@end
