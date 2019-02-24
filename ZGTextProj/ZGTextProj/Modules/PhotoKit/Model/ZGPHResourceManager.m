//
//  ZGPHResourceManager.m
//  ZGTextProj
//
//  Created by ali on 2018/11/7.
//  Copyright © 2018 XuZonggen. All rights reserved.
//

#import "ZGPHResourceManager.h"

@implementation ZGPHResourceManager

+ (PHFetchResult *)getAlbums
{
    PHFetchOptions *op = [[PHFetchOptions alloc] init];
    op.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    PHFetchResult *res = [PHAsset fetchAssetsWithOptions:op];
    return res;
}

+ (PHFetchResult *)getVideos
{
    PHFetchOptions *op = [[PHFetchOptions alloc] init];
//    op.includeAssetSourceTypes = PHAssetResourceTypeVideo;
    op.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    PHFetchResult *res = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeVideo options:op];
    return res;
}

@end
