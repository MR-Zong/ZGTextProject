//
//  ZGAACUtil.m
//  ZGTextProj
//
//  Created by XuZongGen on 2019/12/6.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGAACUtil.h"
#import <AVFoundation/AVFoundation.h>

int32_t kMP4BoxHeaderSize = 8;
int32_t kMP4MaxParseDataSize = 200;

@implementation ZGAACUtil

+ (double)fileDurationWithUrl:(NSURL *)audioUrl
{
    return [self standardMp4GetFileDurationWithUrl:audioUrl];
}


+ (double)standardMp4GetFileDurationWithUrl:(NSURL *)audioUrl
{
    if (audioUrl.absoluteString.length == 0) {
        return 0;
    }
    
    double fileDuration = 0;
    NSData *data = [self readDataFromFilePath:audioUrl.path];
    unsigned int *bytes = (unsigned int *)data.bytes;
    if (data.length > 0 && data.length <= kMP4MaxParseDataSize) {
        char *start = (char *)bytes;
        char *end = (char *)bytes + data.length;
        start = [self findBoxWithStart:start end:end targetBoxType:"moov"];
        if (start) {
            fileDuration = [self parseMoovWithStart:start end:end];
        }
    }

    return fileDuration;
}

+ (NSData *)readDataFromFilePath:(NSString *)filePath
{
    NSData *data = nil;
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSFileHandle *reader = [NSFileHandle fileHandleForReadingAtPath:filePath];
        data = [reader readDataOfLength:kMP4MaxParseDataSize];
        [reader closeFile];
    }
    return data;
}

+ (double)parseMoovWithStart:(char *)start end:(char *)end
{
    start = [self findBoxWithStart:start+kMP4BoxHeaderSize end:end targetBoxType:"mvhd"];
    if (start) {
         return [self parseMvhdWithStart:start end:end];
    }
    return 0;
}

+ (double)parseMvhdWithStart:(char *)start end:(char *)end
{
    // fileStream 来直接获取 moov -> mvhd -> duration/time scale
    double fileDuration = 0;
    if (start < end) {
        int32_t *timeScale = (int32_t *)(start+20);
        int32_t *duration = (int32_t *)(start+24);
        fileDuration = NSSwapHostIntToBig(*duration)*1.0/NSSwapHostIntToBig(*timeScale);
    }
    return fileDuration;
}

+ (char *)findBoxWithStart:(char *)start end:(char *)end targetBoxType:(char *)targetBoxType
{
    while (start < end) {
        int32_t *boxSize = (int32_t *)(start);
        int32_t resultBoxSize = NSSwapHostIntToBig(*boxSize);
        char boxType[5] = {0};
        memcpy(boxType, (char *)(start+4), 4);
        printf("resultBoxSize %u, boxType %s\n",resultBoxSize,boxType);
        
        if (strcmp(boxType, targetBoxType) == 0) {
            return start;
        }
        start += resultBoxSize;
    }
    
    return NULL;
}


#pragma mark - avasset
+ (double)avassetGetFileDurationWithUrl:(NSURL *)audioUrl
{
    if (audioUrl.absoluteString.length == 0) {
        return 0;
    }
    
    AVAsset *asset = [AVAsset assetWithURL:audioUrl];
    NSLog(@"asset %@",asset);
    
    CMTime time = [asset duration];
    double fileDuration = ceil(time.value/time.timescale);
    NSLog(@"ZGAACUtil audioUrl %@",audioUrl.absoluteString);
    NSLog(@"ZGAACUtil fileDuration %lf",fileDuration);

    return fileDuration;
}

#pragma mark - 直接写死offset=60 (暂时解决方案)
//- (double)caculateFileDurationByFileHeaderInfo
//{
//    // fileStream 来直接获取 moov -> mvhd -> duration/time scale
//    double fileDuration = 0;
//    BOOL readFlag = NO;
//    NSData *data = [_dataProviderMp4 readBufferWithByteOffset:0 maxLength:80 error:&readFlag];
//    unsigned int *bytes = (unsigned int *)data.bytes;
//    if (!readFlag && data.length > 75) {
//        char *pp = (char *)bytes;
//        char *pp2 =  (char *)bytes;
//        int *timeScale = (int *)(pp+60);
//        int *duration = (int *)(pp2+64);
//        fileDuration = NSSwapHostIntToBig(*duration)*1.0/NSSwapHostIntToBig(*timeScale);
//    }
//    return fileDuration;
//}


#pragma mark - util
+ (void)logBytes:(void *)bytes
{
    int j = 0;
    char *p = (char *)bytes;
    printf("xiaogen ");
    while (j<80) {
        printf("%02x ",*p);
        if (j>0 && (j+1)%16==0) {
            printf("\n");
            printf("xiaogen ");
        }
        p++;
        j++;
    }
    printf("\n");
}

@end
