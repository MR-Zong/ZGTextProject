//
//  ZGRCacheItem.m
//  ZGTextProj
//
//  Created by XuZongGen on 2019/11/6.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGRCacheItem.h"
#import "NSString+ZGMD5.h"
#import "ZGRange.h"

@implementation ZGRCacheItem

- (instancetype)initWithAudioUrl:(NSURL *)audioUrl
{
    if (self = [super init]) {
        NSString *cacheFileId = @"pda"; // PlayerDataAmout 缩写
        NSString *urlHash = [NSString stringWithFormat:@"%@_%@", [[audioUrl absoluteString] md5String], cacheFileId];
        
        NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
        NSString *audioCacheDir = [cacheDir stringByAppendingPathComponent:@"audio"];
        self.filePath = [audioCacheDir stringByAppendingPathComponent:urlHash];
        [self loadFile2Memory];
    }
    return self;
}

#pragma mark - 文件管理
- (void)createFile
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager createFileAtPath:_filePath contents:nil attributes:nil]) {
        NSLog(@"LZPlayerDataAmountCacheItem 创建文件失败");
    }
}

- (BOOL)fileExist:(NSString*)pFile
{
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:pFile isDirectory:&isDir];
}

- (void)loadFile2Memory
{
    if (_filePath.length == 0) return;
    if (![self fileExist:_filePath]) {
        [self createFile];
        self.listenRangeAry = [NSMutableArray array];
        return;
    }
    
    NSData *data = [NSData dataWithContentsOfFile:_filePath];
    if (!data) return;
    NSDictionary *dict = [NSJSONSerialization
                          JSONObjectWithData:data
                          options:0
                          error:nil];
    
//    self.filePath = dict[@"filePath"]; // 不用存盘
    self.downloadDataAmout = [dict[@"downloadDataAmout"] unsignedIntegerValue];
    self.listenDataAmount = [dict[@"listenDataAmount"] unsignedIntegerValue];
    self.preDownloadDataAmout = [dict[@"preDownloadDataAmout"] unsignedIntegerValue];
    self.preListenDataAmount = [dict[@"preListenDataAmount"] unsignedIntegerValue];
    self.audioDuration = [dict[@"audioDuration"] intValue];
    
    self.listenRangeAry = [self objArray:dict[@"listenRangeAry"]];
    if (!self.listenRangeAry) {
        self.listenRangeAry = [NSMutableArray array];
    }
    
    return;
}

- (void)save2File
{
    if (![self fileExist:_filePath]) {
        [self createFile];
    }

    NSDictionary *dic = [self toDictionary];
    if (![NSJSONSerialization isValidJSONObject:dic]) {
        NSLog(@"sorry，对象不能进行json序列化");
        return;
    }
    
    [[NSJSONSerialization
     dataWithJSONObject:dic
     options:0
     error:nil]
    writeToFile:_filePath atomically:YES];
}

- (NSDictionary *)toDictionary
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
//    [dict setObject:self.filePath forKey:@"filePath"]; // 不用存盘
    [dict setObject:@(self.downloadDataAmout) forKey:@"downloadDataAmout"];
    [dict setObject:@(self.listenDataAmount) forKey:@"listenDataAmount"];
    [dict setObject:@(self.preDownloadDataAmout) forKey:@"preDownloadDataAmout"];
    [dict setObject:@(self.preListenDataAmount) forKey:@"preListenDataAmount"];
    [dict setObject:@(self.audioDuration) forKey:@"audioDuration"];
    [dict setObject:[self jsonArray:self.listenRangeAry] forKey:@"listenRangeAry"];
    
    return dict.copy;
}

- (NSArray *)jsonArray:(NSArray *)ary
{
    NSMutableArray *jsonOkAry = [NSMutableArray arrayWithCapacity:ary.count];
    for (ZGRange *range in ary) {
        [jsonOkAry addObject:range.toString];
    }
    return jsonOkAry;
}

- (NSMutableArray *)objArray:(NSArray *)ary
{
    NSMutableArray *objAry = [NSMutableArray arrayWithCapacity:ary.count];
    for (NSString *rangString in ary) {
        [objAry addObject:[ZGRange rangeWithString:rangString]];
    }
    return objAry;
}

@end
