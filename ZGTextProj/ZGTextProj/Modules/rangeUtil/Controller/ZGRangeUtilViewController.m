//
//  ZGRangeUtilViewController.m
//  ZGTextProj
//
//  Created by XuZongGen on 2019/11/6.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGRangeUtilViewController.h"
#import "ZGRange.h"
#import "ZGRCacheItem.h"
#import "NSString+ZGMD5.h"

#define LZDataAmoutMaxIncrement 20
NSString *kLZPlayerDAPreAudioUrlKey = @"kLZPlayerDAPreAudioUrlKey";

@interface ZGRangeUtilViewController ()

@property (nonatomic, strong) NSURL *audioUrl;
@property (nonatomic, strong) NSURL *preAudioUrl;

@property (nonatomic, strong) NSMutableDictionary *cache;

@property (nonatomic, strong) UILabel *downloadTfLabel;
@property (nonatomic, strong) UITextField *downloadTf;

@property (nonatomic, strong) UILabel *listenStartTfLabel;
@property (nonatomic, strong) UITextField *listenStartTf;
@property (nonatomic, strong) UILabel *listenLengthTfLabel;
@property (nonatomic, strong) UITextField *listenLengthTf;

@property (nonatomic, strong) UIButton *playBtn;

@property (nonatomic, strong) UITextField *audioUrlTf;
@property (nonatomic, strong) UIButton *preBtn;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, assign) NSInteger audioUrlIndex;

@end

@implementation ZGRangeUtilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self prepare];
    
    
    
    /**   调试修改点：
     *  1. 不能存盘filePath 也没必要
        2. set不支持 json序列化
        3. 自定义对象 不支持 json序列化
     *  4. 缓存文件之前没有，创建时候要赋值文件对应数据模型属性
     *  5. range范围判断
     *  6. 存盘时机：1，preDownloadDataAmout  赋值j后，就要 立马保存到硬盘 2，超过LZDataAmoutMaxIncrement 3，新增一个range
     *  测试用例
     *  listenRange  [10,10]
     *  range :  noOverlapLess [0,5]   overlapLeft [6, 5]   equal [10,10]  contain [ 13, 3]  beContain [8,14] overlapRight [19, 4] noOverlapGreater [25,5]
     *
     *  preAudioUrl 测试
     *  preDownloadDataAmount  preListenDataAmout
     *  最终打点上报数据是否正确
     */
    [self testRange];
}

- (void)prepare
{
    self.cache = [NSMutableDictionary dictionary];
    
    _audioUrlIndex = 1;
    self.audioUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://zong.com/zongFaCai.mp%ld",(long)_audioUrlIndex]];
    
    NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSString *audioCacheDir = [cacheDir stringByAppendingPathComponent:@"audio"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    // fileExistsAtPath 判断一个文件或目录是否有效，isDirectory判断是否一个目录
    BOOL existed = [fileManager fileExistsAtPath:audioCacheDir isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) ) {//如果文件夹不存在
        [fileManager createDirectoryAtPath:audioCacheDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

- (void)testRange
{
    
    _downloadTfLabel = [[UILabel alloc] init];
    _downloadTfLabel.text = @"downloadByte:";
    _downloadTfLabel.backgroundColor = [UIColor orangeColor];
    _downloadTfLabel.frame = CGRectMake(50, 160, 150, 20);
    [self.view addSubview:_downloadTfLabel];
    
    _downloadTf = [[UITextField alloc] init];
    _downloadTf.keyboardType = UIKeyboardTypeDecimalPad;
    _downloadTf.layer.borderColor = [UIColor blueColor].CGColor;
    _downloadTf.layer.borderWidth = 1;
    _downloadTf.frame = CGRectMake(50, CGRectGetMaxY(_downloadTfLabel.frame) + 10, 100, 20);
    [self.view addSubview:_downloadTf];
    
    _listenStartTfLabel = [[UILabel alloc] init];
    _listenStartTfLabel.text = @"startByte:";
    _listenStartTfLabel.backgroundColor = [UIColor orangeColor];
    _listenStartTfLabel.frame = CGRectMake(50, CGRectGetMaxY(_downloadTf.frame) + 50, 100, 20);
    [self.view addSubview:_listenStartTfLabel];
    
    _listenStartTf = [[UITextField alloc] init];
    _listenStartTf.keyboardType = UIKeyboardTypeDecimalPad;
    _listenStartTf.layer.borderColor = [UIColor blueColor].CGColor;
    _listenStartTf.layer.borderWidth = 1;
    _listenStartTf.frame = CGRectMake(50, CGRectGetMaxY(_listenStartTfLabel.frame) + 10, 100, 20);
    [self.view addSubview:_listenStartTf];
    
    _listenLengthTfLabel = [[UILabel alloc] init];
    _listenLengthTfLabel.text = @"lengthByte:";
    _listenLengthTfLabel.backgroundColor = [UIColor orangeColor];
    _listenLengthTfLabel.frame = CGRectMake(50, CGRectGetMaxY(_listenStartTf.frame) + 10, 100, 20);
    [self.view addSubview:_listenLengthTfLabel];
    
    _listenLengthTf = [[UITextField alloc] init];
    _listenLengthTf.keyboardType = UIKeyboardTypeDecimalPad;
    _listenLengthTf.layer.borderColor = [UIColor blueColor].CGColor;
    _listenLengthTf.layer.borderWidth = 1;
    _listenLengthTf.frame = CGRectMake(50, CGRectGetMaxY(_listenLengthTfLabel.frame) + 10, 100, 20);
    [self.view addSubview:_listenLengthTf];
    
    _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playBtn setTitle:@"Play" forState:UIControlStateNormal];
    _playBtn.backgroundColor = [UIColor orangeColor];
    _playBtn.frame = CGRectMake(50, CGRectGetMaxY(_listenLengthTf.frame) + 50, 100, 40);
    [_playBtn addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_playBtn];
    
    
    _audioUrlTf = [[UITextField alloc] init];
    _audioUrlTf.text = [NSString stringWithFormat:@"%ld",(long)_audioUrlIndex];
    _audioUrlTf.keyboardType = UIKeyboardTypeDecimalPad;
    _audioUrlTf.layer.borderColor = [UIColor blueColor].CGColor;
    _audioUrlTf.layer.borderWidth = 1;
    _audioUrlTf.frame = CGRectMake(50, CGRectGetMaxY(_playBtn.frame) + 50, 100, 20);
    [self.view addSubview:_audioUrlTf];
    
    _preBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_preBtn setTitle:@"<" forState:UIControlStateNormal];
    _preBtn.backgroundColor = [UIColor orangeColor];
    _preBtn.frame = CGRectMake(50, CGRectGetMaxY(_audioUrlTf.frame) + 10, 60, 40);
    [_preBtn addTarget:self action:@selector(pre:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_preBtn];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nextBtn setTitle:@">" forState:UIControlStateNormal];
    _nextBtn.backgroundColor = [UIColor orangeColor];
    _nextBtn.frame = CGRectMake(_preBtn.frame.origin.x+80, _preBtn.frame.origin.y,60, 40);
    [_nextBtn addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextBtn];
}

#pragma mark - action
- (void)play:(UIButton *)btn
{
    
    [self playWithUrl:self.audioUrl];
    
    [self receiveNetworkDataLength:[self.downloadTf.text intValue]];
    
    [self listenStart:[self.listenStartTf.text intValue] listenDataLength:[self.listenLengthTf.text intValue]];
}

- (void)pre:(UIButton *)btn
{
    _audioUrlTf.text = [NSString stringWithFormat:@"%ld",(long)--_audioUrlIndex];
    self.audioUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://zong.com/zongFaCai.mp%ld",(long)_audioUrlIndex]];
}

- (void)next:(UIButton *)btn
{
    _audioUrlTf.text = [NSString stringWithFormat:@"%ld",(long)++_audioUrlIndex];
    self.audioUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://zong.com/zongFaCai.mp%ld",(long)_audioUrlIndex]];
}

#pragma mark -- - - -  - - -  -
- (void)playWithUrl:(NSURL *)audioUrl
{
    if (!audioUrl) {
        return;
    }
    if (audioUrl.absoluteString.length == 0) {
        return;
    }
    
    self.audioUrl = audioUrl;
    
    // 要先上报上一首
    if (![self getPreAudioUrl]) {
        [self savePreAudioUrl:audioUrl];
    }
    if (![audioUrl.absoluteString isEqualToString:self.preAudioUrl.absoluteString]) {
        
        [self reportDataAmountWithUrl:self.preAudioUrl];
        
        // 上一首preDownloadDataAmout，preListenDataAmount处理
        ZGRCacheItem *preItem = [self getItem:self.preAudioUrl];
        preItem.preDownloadDataAmout = preItem.downloadDataAmout;
        preItem.preListenDataAmount = preItem.listenDataAmount;
        [preItem save2File];
        
        // 保存为上一首
        [self savePreAudioUrl:audioUrl];
    }
    
}

- (NSURL *)getPreAudioUrl
{
    NSURL *preAudioUrl = self.preAudioUrl;
    if (!preAudioUrl) {
        NSString *urlString = [[NSUserDefaults standardUserDefaults] objectForKey:kLZPlayerDAPreAudioUrlKey];
        if (urlString.length > 0) {
            preAudioUrl = [NSURL URLWithString:urlString];
            self.preAudioUrl = preAudioUrl;
        }
    }
    
    return preAudioUrl;
}

- (void)savePreAudioUrl:(NSURL *)audioUrl
{
    self.preAudioUrl = audioUrl;
    [[NSUserDefaults standardUserDefaults] setObject:self.preAudioUrl.absoluteString forKey:kLZPlayerDAPreAudioUrlKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)reportDataAmountWithUrl:(NSURL *)audioUrl
{
    ZGRCacheItem *item = [self getItem:audioUrl];
    int64_t wasteDataAmount = 0;
    if (item.preDownloadDataAmout == 0 ) {
        wasteDataAmount = item.downloadDataAmout - item.listenDataAmount;
    }else {
        
        if (item.listenDataAmount <= item.preDownloadDataAmout) {
            wasteDataAmount = item.downloadDataAmout - item.preDownloadDataAmout;
        }else {
            wasteDataAmount = item.downloadDataAmout - item.listenDataAmount;
        }
    }
    NSLog(@"report downloadDataAmout %lld , listenDataAmount %lld , wasteDataAmount %lld  ",item.downloadDataAmout,item.listenDataAmount,wasteDataAmount);
}

#pragma mark - 下载流量统计
- (void)receiveNetworkDataLength:(int64_t)receiveDataLength
{
    if (receiveDataLength <= 0 || self.audioUrl.absoluteString.length == 0) {
        return;
    }
    
    [self synchronizeCacheWithReceiveNetworkDataLength:receiveDataLength listenDataLength:0];
}

#pragma mark - 收听流量统计
- (void)listenStart:(int32_t)listenStart listenDataLength:(int64_t)listenDataLength
{
    if (listenDataLength <= 0 || self.audioUrl.absoluteString.length == 0 || listenStart < 0) {
        return;
    }
    
    int64_t realListenDataLength = [self caculateRealListenDataLengthWithListenStart:listenStart listenDataLength:listenDataLength];
    [self synchronizeCacheWithReceiveNetworkDataLength:0 listenDataLength:realListenDataLength];
}

// 对音频收听流量去重，算出真实新增的收听流量大小
- (int64_t)caculateRealListenDataLengthWithListenStart:(int32_t)listenStart listenDataLength:(int64_t)listenDataLength
{
    ZGRCacheItem *item = [self getItem:self.audioUrl];

    ZGRange *listenRange = [ZGRange rangeWithStart:listenStart length:listenDataLength];
    if (item.listenRangeAry.count == 0) {
        [item.listenRangeAry addObject:listenRange];
        [item save2File];
        return listenDataLength;
    }
    
    __block int overlapType = 1; // 1 没有重叠，2 有重叠，3 被包含
    NSMutableArray *removeObjs = [NSMutableArray array];
    __block int64_t alreadyListenDataLength = 0;
    for (ZGRange *range in item.listenRangeAry) {
        [listenRange compareRange:range completeBlock:^(ZGRangeCompareType type, int64_t overlapLength) {
            switch (type) {
                case ZGRangeCompareTypeNoOverlapLess:
                {
                    ;
                }
                    break;
                case ZGRangeCompareTypeOverlapLeft:
                {
                    overlapType = 2;
                    listenRange.start = range.start;
                    listenRange.length += range.length;
                    alreadyListenDataLength += overlapLength;
                    range.length = 0;
                    [removeObjs addObject:range];
                }
                    break;
                case ZGRangeCompareTypeContain:
                {
                    overlapType = 2;
                    alreadyListenDataLength += overlapLength;
                    range.length = 0;
                    [removeObjs addObject:range];
                }
                    break;
                case ZGRangeCompareTypeEqual:
                {
                    overlapType = 3;
                }
                    break;
                case ZGRangeCompareTypeBeContain:
                {
                    overlapType = 3;
                }
                    break;
                case ZGRangeCompareTypeOverlapRight:
                {
                    overlapType = 2;
                    listenRange.length += range.length;
                    alreadyListenDataLength += overlapLength;
                    range.length = 0;
                    [removeObjs addObject:range];
                }
                    break;
                case ZGRangeCompareTypeNoOverlapGreater:
                {
                    ;
                }
                    break;
                default:
                    break;
            }
        }];
    }
    
    if (overlapType == 3) {
        return 0;
    }
    
    
    for (ZGRange *removeRange in removeObjs) {
        [item.listenRangeAry removeObject:removeRange];
    }
    [item.listenRangeAry addObject:listenRange];
    [item save2File];
    
    return listenRange.length - alreadyListenDataLength;
}


#pragma mark - 基础功能
- (ZGRCacheItem *)getItem:(NSURL *)audioUrl
{
    if (audioUrl.absoluteString.length == 0) {
        return nil;
    }
    
    // 先查询内存是否有，有则同时存入内存和硬盘，无则加载硬盘该条记录到内存
    NSString *key = [self keyFromAudioUrl:audioUrl];
    ZGRCacheItem *item = [self.cache objectForKey:key];
    if (!item) {
        item = [[ZGRCacheItem alloc] initWithAudioUrl:audioUrl];
        [self.cache setObject:item forKey:key];
    }
    return item;
}

- (NSString *)keyFromAudioUrl:(NSURL *)audioUrl
{
    NSString *key = nil;
    if (audioUrl.absoluteString.length > 0) {
        key = [[audioUrl absoluteString] md5String];
    }
    return key;
}

- (void)synchronizeCacheWithReceiveNetworkDataLength:(int64_t)receiveDataLength listenDataLength:(int64_t)listenDataLength
{
    ZGRCacheItem *item = [self getItem:self.audioUrl];
    
    int64_t oldDataAmout = 0;
    int64_t newDataAmout = 0;
    if (receiveDataLength > 0) {
        oldDataAmout = item.downloadDataAmout;
        item.downloadDataAmout += receiveDataLength;
        newDataAmout = item.downloadDataAmout;
    }else if(listenDataLength > 0) {
        oldDataAmout = item.listenDataAmount;
        item.listenDataAmount += listenDataLength;
        newDataAmout = item.listenDataAmount;
    }
    
    if (newDataAmout - oldDataAmout >= LZDataAmoutMaxIncrement) {
        [item save2File];
    }
     
}




@end
