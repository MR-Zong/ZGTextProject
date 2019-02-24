//
//  ZGPHResourceManager.h
//  ZGTextProj
//
//  Created by ali on 2018/11/7.
//  Copyright © 2018 XuZonggen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PhotosUI/PhotosUI.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZGPHResourceManager : NSObject

+ (PHFetchResult *)getAlbums;
+ (PHFetchResult *)getVideos;


@end

NS_ASSUME_NONNULL_END
