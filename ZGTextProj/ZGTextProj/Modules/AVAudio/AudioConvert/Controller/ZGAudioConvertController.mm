//
//  ZGAudioConvertController.m
//  ZGTextProj
//
//  Created by ali on 2019/1/18.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGAudioConvertController.h"
#include "MZCodec.hpp"
#import <AVFoundation/AVFoundation.h>
#import "wavreader.h"

@interface ZGAudioConvertController ()

@property (strong, nonatomic) UITextView *disAearText;

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@property (strong, nonatomic) UIButton *covertBtn;

@property (strong, nonatomic) UIButton *playBtn;

@property (strong, nonatomic) UIButton *covertWAVToAACBtn;

@property (strong, nonatomic) UIButton *playWAVBtn;

@property (nonatomic, copy) NSString *destFilePath;

@end


@implementation ZGAudioConvertController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"音频编解码";
    
    [self setupViews];
    
    self.disAearText.text = @"";
    self.playBtn.enabled = NO;
    self.playBtn.alpha = 0.7f;
    self.playWAVBtn.enabled = NO;
    self.playWAVBtn.alpha = 0.7f;
}

- (void)setupViews
{
    self.view.backgroundColor = [UIColor lightGrayColor];
    UIColor *btnBGColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1];
    CGFloat leftMargin = 20;
    CGFloat btnWidth = 100;
    CGFloat btnHeight = 40;
    CGFloat sw = [UIScreen mainScreen].bounds.size.width;
    
    _covertBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _covertBtn.frame = CGRectMake(leftMargin, 120, btnWidth, btnHeight);
    [_covertBtn setTitle:@"WAV->AAC" forState:UIControlStateNormal];
    [_covertBtn addTarget:self action:@selector(doWAV2AACAction:) forControlEvents:UIControlEventTouchUpInside];
    _covertBtn.backgroundColor = btnBGColor;
    [self.view addSubview:_covertBtn];
    
    _covertWAVToAACBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _covertWAVToAACBtn.frame = CGRectMake(sw-btnWidth-leftMargin, 120, btnWidth, btnHeight);
    [_covertWAVToAACBtn setTitle:@"AAC->WAV" forState:UIControlStateNormal];
    [_covertWAVToAACBtn addTarget:self action:@selector(doCovertAACToWAVAction:) forControlEvents:UIControlEventTouchUpInside];
    _covertWAVToAACBtn.backgroundColor = btnBGColor;
    [self.view addSubview:_covertWAVToAACBtn];
    
    _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _playBtn.frame = CGRectMake(leftMargin, CGRectGetMaxY(_covertBtn.frame)+20, btnWidth, btnHeight);
    [_playBtn setTitle:@"Play AAC" forState:UIControlStateNormal];
    [_playBtn addTarget:self action:@selector(_playAAC) forControlEvents:UIControlEventTouchUpInside];
    _playBtn.backgroundColor = btnBGColor;
    [self.view addSubview:_playBtn];
    
    _playWAVBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _playWAVBtn.frame = CGRectMake(sw-btnWidth-leftMargin, CGRectGetMaxY(_covertBtn.frame)+20, btnWidth, btnHeight);
    [_playWAVBtn setTitle:@"Play WAV" forState:UIControlStateNormal];
    [_playWAVBtn addTarget:self action:@selector(playWAVAction:) forControlEvents:UIControlEventTouchUpInside];
    _playWAVBtn.backgroundColor = btnBGColor;
    [self.view addSubview:_playWAVBtn];
    
    _disAearText = [[UITextView alloc] init];
    _disAearText.backgroundColor = [UIColor grayColor];
    _disAearText.frame = CGRectMake(leftMargin, CGRectGetMaxY(_playWAVBtn.frame) +20, sw-2*leftMargin, 200);
    [self.view addSubview:_disAearText];

    
    
}

/**
 * 读取wav头文件信息
 */
- (void)readWAVHeader
{
    int format;
    int channels;
    int sample_rate;
    int bits_per_sample;
    unsigned int  data_length;
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *resPath = [bundle pathForResource:@"testZong" ofType:@"wav"];
   void *fp = wav_read_open([resPath UTF8String]);
    wav_get_header(fp, &format, &channels, &sample_rate, &bits_per_sample, &data_length);
    wav_read_close(fp);
    
    NSLog(@"format %d, channels %d, sample_rate %d, bits_per_sample %d, data_length %d",format,channels,sample_rate,bits_per_sample,data_length);
}

- (void)doWAV2AACAction:(id)sender {
    [self readWAVHeader];
    return;
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *resPath = [bundle pathForResource:@"testZong" ofType:@"wav"];
    
    
    
    NSLog(@"The path of wav file: %@", resPath);
    
    NSArray<NSString *> *docPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *destPath = [[docPath lastObject] stringByAppendingString:@"/out.aac"];
    NSLog(@"The path of aac file: %@", destPath);
    
    self.disAearText.text = @"正在转换...";
    self.covertBtn.alpha = 0.7f;
    self.covertBtn.enabled = NO;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        codeWAV([resPath UTF8String], [destPath UTF8String]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.disAearText.text = @"转换完成...";
            self.playBtn.enabled = YES;
            self.playBtn.alpha = 1.f;
            self.destFilePath = destPath;
        });
    });
}

- (void)doAAC2OtherAction:(id)sender {
    
    if (nil == self.destFilePath) {
        return;
    }
    
    self.disAearText.text = @"正在播放 AAC 音频文件...";
    
    [self _playAAC];
}

- (void)_playAAC {
    
    NSURL *soundUrl = [NSURL fileURLWithPath:self.destFilePath isDirectory:NO];
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive: YES error: nil];
    
    if (_audioPlayer) {
        [_audioPlayer stop];
        _audioPlayer = nil;
    }
    NSError *error;
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl
                                                          error:&error];
    
    if (nil != error) {
        
        NSLog(@"Init AVAudioPlayer error: %@", error);
        return;
    }
    
    [self.audioPlayer prepareToPlay];
    [self.audioPlayer play];
}

- (void)doCovertAACToWAVAction:(id)sender {
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *resPath = [bundle pathForResource:@"gamesound" ofType:@"aac"];
    NSLog(@"The path of aac file: %@", resPath);
    
    if (resPath.length== 0) {
        return;
    }
    NSArray<NSString *> *docPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *destPath = [[docPath lastObject] stringByAppendingString:@"/out.wav"];
    NSLog(@"The path of wav file: %@", destPath);
    
    self.disAearText.text = @"正在转换...";
    self.covertWAVToAACBtn.alpha = 0.7f;
    self.covertWAVToAACBtn.enabled = NO;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        decodeAAC([resPath UTF8String], [destPath UTF8String]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.disAearText.text = @"转换完成...";
            self.playWAVBtn.enabled = YES;
            self.playWAVBtn.alpha = 1.f;
            self.destFilePath = destPath;
        });
    });
}

- (void)playWAVAction:(id)sender {
    
    if (nil == self.destFilePath) {
        return;
    }
    
    self.disAearText.text = @"正在播放 WAV 音频文件...";
    
    [self _playAAC];
}

@end
