//
//  ZGPHVideoCell.h
//  ZGTextProj
//
//  Created by ali on 2018/11/7.
//  Copyright © 2018 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PhotosUI/PhotosUI.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZGPHVideoCell : UICollectionViewCell

@property (nonatomic, strong) PHAsset *phAsset;

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) NSString *representedAssetIdentifier;

@end

NS_ASSUME_NONNULL_END
