//
//  ZGRCacheItem.h
//  ZGTextProj
//
//  Created by XuZongGen on 2019/11/6.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ZGRange;

@interface ZGRCacheItem : NSObject


@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, assign) int64_t preDownloadDataAmout;
@property (nonatomic, assign) int64_t preListenDataAmount;

@property (nonatomic, assign) int64_t downloadDataAmout;
@property (nonatomic, assign) int64_t listenDataAmount;

@property (nonatomic, assign) int32_t audioDuration;
@property (nonatomic, strong) NSMutableArray <ZGRange *> *listenRangeAry;

- (instancetype)initWithAudioUrl:(NSURL *)audioUrl;
#pragma mark - 文件管理
- (void)loadFile2Memory;
- (void)save2File;

@end

NS_ASSUME_NONNULL_END
