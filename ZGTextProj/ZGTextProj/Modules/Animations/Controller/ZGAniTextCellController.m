//
//  ZGAniTextCellController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/6/23.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGAniTextCellController.h"
#import "ZGAniTextCell.h"

@interface ZGAniTextCellController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewCell *headerCell;
@property (nonatomic, assign) BOOL isExtend;
@property (nonatomic, strong) ZGAniTextCellModel *model;

@end

@implementation ZGAniTextCellController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initialize];
    [self setupViews];
}

- (void)initialize
{
    _model = [[ZGAniTextCellModel alloc] init];
    _model.miniHeight = 70;
    _model.text = @"所谓专题，是指针对某个特定对象而特别收集制作而成的一种集中作品，这个对象可以是具体的某个或某集所谓专题，是指针对某个特定对象而特别收集制作而成的一种集中作品，这个对象可以是具体的某个或某集所谓专题，是指针对某个特定对象而特别收集制作而成的一种集中作品，这个对象可以是具体的某个或某集所谓专题，是指针对某个特定对象而特别收集制作而成的一种集中作品，这个对象可以是具体的某个或某集定对象而特别收集制作而成的一种集中作品，这个对象可以是具体的某个或某集所谓专题，是指针对某个特定对象而特别收集制作而成的一种集中作品，这个对象可以是具体的某个或某集所谓专题，是指针对某个特定对象而特别收集制作而成的一种集中作品，这个对象可以是具体的某个或某集定对象而特别收集制作而成的一种集中作品，这个对象可以是具体的某个或某集所谓专题，是指针对某个特定对象而特别收集制作而成的一种集中作品，这个对象可以是具体的某个或某集所谓专题，是指针对某个特定对象而特别收集制作而成的一种集中作品，这个对象可以是具体的某个或某集";
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
    [_collectionView registerClass:[ZGAniTextCell class] forCellWithReuseIdentifier:@"ZGAniTextCellReusedId"];
    
    [self.view addSubview:_collectionView];

}


#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == 2) {
        // 如果 返回一个固定的。。会闪屏
        //        return self.headerCell;
        
        ZGAniTextCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"ZGAniTextCellReusedId" forIndexPath:indexPath];
        cell.model = self.model;
//        NSLog(@"cell %@",cell);
        return cell;
    }
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"animationCollectCellReusedId" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    
    ZGAniTextCellModel *model = self.model;
    model.isExtend = !model.isExtend;
    
    [collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:2 inSection:0]]];
    
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    ;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == 2) {
        ZGAniTextCellModel *model = self.model;
        CGFloat cellHeight = model.miniHeight;
        if (model.isExtend) {
            cellHeight = model.textHeight;
        }
        return CGSizeMake(self.view.bounds.size.width, cellHeight);
    }
    
    return CGSizeMake(self.view.bounds.size.width, 44);
}



@end
