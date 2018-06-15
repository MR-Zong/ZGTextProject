//
//  ZGPageDController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/6/13.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGPageDController.h"

@interface ZGPageDController () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ZGPageDController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor grayColor];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _collectionView.pagingEnabled = YES;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"pageCCell"];
    [self.view addSubview:_collectionView];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"pageCCell" forIndexPath:indexPath];
    if (indexPath.item == 0) {
        cell.backgroundColor = [UIColor redColor];
    }else if (indexPath.item == 1) {
        cell.backgroundColor = [UIColor yellowColor];
    }else if (indexPath.item == 2) {
        cell.backgroundColor = [UIColor greenColor];
    }
    return cell;
}


@end
