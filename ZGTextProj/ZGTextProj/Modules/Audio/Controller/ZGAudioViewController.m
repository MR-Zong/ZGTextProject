//
//  ZGAudioViewController.m
//  ZGTextProj
//
//  Created by XuZongGen on 2019/12/6.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGAudioViewController.h"
#import "ZGAACUtil.h"

@interface ZGAudioViewController ()

@property (nonatomic, strong) NSString *shaHeFilePath;

@end

@implementation ZGAudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _shaHeFilePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"liuChangShahe.acc"];
    NSLog(@"_shaHeFilePath %@",_shaHeFilePath);
    
    // 测试通过
//    [self testNetMp4];
    
    // 测试bundle 文件
//    [self testBundleMp4];
    
    // 测试沙盒音频文件
//    [self testShaHeFile];
    
    // 测试自我解析Mp4
    [self testRightParseMp4];
}

- (void)testNetMp4
{
    double fileDuration = 0;
    // 测试在线音频   流畅音质：http://cdn101.gzlzfm.com/audio/2017/09/14/2624462622297931782_sd
    // 高音质：http://cdn101.gzlzfm.com/audio/2017/09/14/2624462622297931782_hd （和低音质url）
    NSURL *netUrl = [NSURL URLWithString:@"http://cdn101.gzlzfm.com/audio/2017/09/14/2624462622297931782_sd"];
    fileDuration = [ZGAACUtil fileDurationWithUrl:netUrl];
    NSLog(@"network fileDuration %f",fileDuration);
}

- (void)testBundleMp4
{
    // 测试bundle 文件
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"liuchang.aac" ofType:nil];
    double fileDuration = [ZGAACUtil fileDurationWithUrl:[NSURL fileURLWithPath:filePath]];
    NSLog(@"bundle file  fileDuration %f",fileDuration);
    
}

#pragma mark - 沙盒测试
- (void)testShaHeFile
{
    [self downloadFileToShaHe];
    
    // 目前只要是在线的音频 不管高音质还是低音质都是可以获取到音频时长的
    // 问题：只要是下载目录都不可以获取到。。
    // 荔枝APP：file:///var/mobile/Containers/Data/Application/F8993035-75D0-437E-9771-6AEAF1580B9C/Documents/download/program/1079D353024FC837B4295A73FDD25F11
    
    // 测试沙盒文件
    if (![[NSFileManager defaultManager] fileExistsAtPath:_shaHeFilePath]) {
           return;
    }
    double fileDuration = [ZGAACUtil fileDurationWithUrl:[NSURL fileURLWithPath:self.shaHeFilePath]];
    NSLog(@"shahe file  fileDuration %f",fileDuration);
    if ([[NSFileManager defaultManager] fileExistsAtPath:_shaHeFilePath]) {
        NSLog(@"shaHe file exist");
    }else {
        NSLog(@"shaHe file not exist");
    }
}

- (void)downloadFileToShaHe
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:_shaHeFilePath]) {
        return;
    }
    NSLog(@"download begin");
    // 此方法无法获取到文件的下载进度，只能在结束时做响应
    NSURL *url = [NSURL URLWithString:@"http://cdn101.gzlzfm.com/audio/2017/09/14/2624462622297931782_sd"];
    [[[NSURLSession sharedSession] downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // 当前线程， 子线程
        NSLog(@"%@", [NSThread currentThread]);
        // 当前文件位置，临时文件，下载完成后删除临时文件
        NSLog(@"%@",location);
        // 将文件复制到自己想要的位置
        // 存放文件的路径
        // 复制文件
        [[NSFileManager defaultManager] copyItemAtPath:location.path toPath:self.shaHeFilePath error:NULL];
        NSLog(@"download success");
    }] resume];
}


#pragma mark - 按mp4的规则来解析出mp4音频时长
- (void)testRightParseMp4
{
    // 测试bundle 文件
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"liuchang.aac" ofType:nil];
    double fileDuration = [ZGAACUtil fileDurationWithUrl:[NSURL fileURLWithPath:filePath]];
    NSLog(@"bundle file  fileDuration %f",fileDuration);
}


@end
