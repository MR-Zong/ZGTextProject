//
//  ZGImagesToVideoManager.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/8/4.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZGImageFrameModel : NSObject

@property (nonatomic, strong) UIImage *img;
@property (nonatomic, assign) CGFloat frameDuration;
@property (nonatomic, assign) NSUInteger keepPresentFrames;

+ (instancetype)imageFrameWithImage:(UIImage *)image frameDuration:(CGFloat)frameDuration;

@end


@interface ZGImagesToVideoManager : NSObject

+ (instancetype)shareInstance;

- (NSString *)compressionWithImagesArray:(NSArray<ZGImageFrameModel *>*)imagesArray;

@end
