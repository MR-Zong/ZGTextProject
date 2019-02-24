//
//  ZGPhotoPickController.m
//  ZGTextProj
//
//  Created by ali on 2018/11/7.
//  Copyright © 2018 XuZonggen. All rights reserved.
//

#import "ZGPhotoPickController.h"
#import "ZGPHVideoCell.h"
#import "ZGPHResourceManager.h"

@interface ZGPhotoPickController () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *assetAry;
@property (nonatomic, strong) PHCachingImageManager *imageManager;
@property (nonatomic, assign) CGFloat itemWidth;

@end

@implementation ZGPhotoPickController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _assetAry = [NSMutableArray array];
    _imageManager = [[PHCachingImageManager alloc] init];
    
    [self setupViews];
    [self loadData];
}

- (void)setupViews
{
    _itemWidth = ([UIScreen mainScreen].bounds.size.width - 2*1) /3.0;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(_itemWidth, _itemWidth);
    flowLayout.minimumLineSpacing = 1;
    flowLayout.minimumInteritemSpacing  = 1;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:[ZGPHVideoCell class] forCellWithReuseIdentifier:@"ZGPHVideoCellReusedId"];
    [self.view addSubview:_collectionView];
}

- (void)loadData
{
    for (PHAsset *asset in [ZGPHResourceManager getVideos]) {
        [self.assetAry addObject:asset];
    }
    // Update the assets the PHCachingImageManager is caching.
    [_imageManager startCachingImagesForAssets:self.assetAry targetSize:CGSizeMake(self.itemWidth, self.itemWidth) contentMode:PHImageContentModeAspectFill options:nil];

    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assetAry.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZGPHVideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZGPHVideoCellReusedId" forIndexPath:indexPath];
    PHAsset *asset = self.assetAry[indexPath.item];
    NSLog(@"duration %f",asset.duration);
    // Add a badge to the cell if the PHAsset represents a Live Photo.
    
    // Request an image for the asset from the PHCachingImageManager.
    cell.representedAssetIdentifier = asset.localIdentifier;
    
//    PHImageRequestOptions *op = [PHImageRequestOptions al];
    [self.imageManager requestImageForAsset:asset targetSize:CGSizeMake(self.itemWidth, self.itemWidth) contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        // UIKit may have recycled this cell by the handler's activation time.
        // Set the cell's thumbnail image only if it's still showing the same asset.
        if ([cell.representedAssetIdentifier isEqualToString:asset.localIdentifier]) {
            cell.imgView.image = result;
        }
    }];
    return cell;
}

@end
