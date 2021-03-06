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
#import "UIImage+zgExtension.h"

@interface ZGWaterFallController () <UICollectionViewDataSource,ZGWaterfallCollectionViewLayoutDelegate>

@end

@implementation ZGWaterFallController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor blackColor];
    // 测试 画中间透明的图片
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, 100, 100)];
//    imgView.image = [UIImage imageWithColor:[UIColor blueColor] rect:imgView.bounds cornerRadius:50];

    imgView.image = [UIImage imageUsePathWithColor:[UIColor whiteColor] rect:imgView.bounds cornerRadius:50];
    [self.view addSubview:imgView];
    
    return;
    
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
//    NSLog(@"indexPath.item %zd",indexPath.item);
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
