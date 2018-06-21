//
//  ZGAnimationsCollectionViewController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/6/20.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGAnimationsCollectionViewController.h"
#import "ZGHeaderCollectionViewCell.h"

@interface ZGAnimationsCollectionViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ZGTopicHeaderViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) CGFloat headerCellHeight;
@property (nonatomic, assign) BOOL isExtend;

@end

@implementation ZGAnimationsCollectionViewController

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
    _collectionView.backgroundColor = [UIColor blueColor];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"animationCollectCellReusedId"];
    [_collectionView registerClass:[ZGHeaderCollectionViewCell class] forCellWithReuseIdentifier:@"ZGHeaderCollectionViewCellReusedId"];

    [self.view addSubview:_collectionView];
    
    // headerCell
    _headerCellHeight = ZGTopicHeaderViewBaseHeight + ZGTopicHeaderViewBaseTextHeight;
    _isExtend = NO;
}


#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.item == 0) {
         ZGHeaderCollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"ZGHeaderCollectionViewCellReusedId" forIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        cell.desc = @"所谓专题，是指针对某个特定对象而特别收集制作而成的一种集中作品，这个对象可以是具体的某个或某集所谓专题，是指针对某个特定对象而特别收集制作而成的一种集中作品，这个对象可以是具体的某个或某集";
        cell.isExtend = self.isExtend;
        cell.hView.delegate = self;
        
        // 不明白 为什么会两个headerCell 实例
//        NSLog(@"cell %@",cell);
        
        return cell;
    }
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"animationCollectCellReusedId" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}


#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == 0) {
        return CGSizeMake(self.view.bounds.size.width, self.headerCellHeight);
    }
    
    return CGSizeMake(self.view.bounds.size.width, 44);
}


#pragma mark - SMTopicHeaderViewDelegate
- (void)topicHeaderView:(ZGTopicHeaderView *)view didExtendBtn:(UIButton *)btn
{

    self.headerCellHeight = ZGTopicHeaderViewBaseHeight + view.textHeight;
    
    self.isExtend = YES;
    
    [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]]];
}

- (void)topicHeaderView:(ZGTopicHeaderView *)view didDescLabelWithExtendBtn:(UIButton *)btn
{
    CGFloat textHeight = ZGTopicHeaderViewBaseTextHeight;
    self.headerCellHeight = ZGTopicHeaderViewBaseHeight + textHeight;
    
    self.isExtend = NO;
    
    [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]]];
    
}

@end
