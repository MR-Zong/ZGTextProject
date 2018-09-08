//
//  ZGWaterFallController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/9/8.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGWaterFallController.h"
#import "ZGWaterfallCollectionViewLayout.h"
#import "ZGTestCollectionViewCell.h"

@interface ZGWaterFallController () <UICollectionViewDataSource,ZGWaterfallCollectionViewLayoutDelegate>

@end

@implementation ZGWaterFallController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ZGWaterfallCollectionViewLayout *waterfallLayout = [[ZGWaterfallCollectionViewLayout alloc] init];
    waterfallLayout.delegate = self;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:waterfallLayout];
    
    collectionView.backgroundColor = [UIColor blackColor];
    
    collectionView.dataSource = self;
    [collectionView registerClass:[ZGTestCollectionViewCell class] forCellWithReuseIdentifier:@"testCell"];
    [self.view addSubview:collectionView];
    
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZGTestCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"testCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor yellowColor];
    cell.titleLabel.text = [NSString stringWithFormat:@"%zd-%zd",indexPath.section,indexPath.item];
    [cell.titleLabel sizeToFit];
    
    return cell;
}

#pragma mark - <ZGWaterfallCollectionViewLayoutDelegate>
- (CGFloat)zg_waterfallCollectionViewLayout:(ZGWaterfallCollectionViewLayout *)waterfallCollectionViewLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (arc4random() % 101) + 100;
}

@end
