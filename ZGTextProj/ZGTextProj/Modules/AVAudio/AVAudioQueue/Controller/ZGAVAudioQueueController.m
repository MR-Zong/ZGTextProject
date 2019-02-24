//
//  ZGAVAudioQueueController.m
//  ZGTextProj
//
//  Created by ali on 2019/1/2.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGAVAudioQueueController.h"
#import "AudioQueueRecorder.h"
#import "AudioQueuePlayer.h"

@interface ZGAVAudioQueueController () <AudioQueueRecorderDelegate>
@property (nonatomic,strong) UIButton *recordBtn;
@property (nonatomic, strong) UIButton *playBtn;

@property (nonatomic, strong) AudioQueuePlayer *audioPlayer;
@property (nonatomic, strong) AudioQueueRecorder *audioRecorder;
@property (nonatomic, strong) NSMutableData *audioRecordData;
@property (nonatomic, strong) dispatch_queue_t playQueue;

@end

@implementation ZGAVAudioQueueController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 实时录音
    [self testAVAudioQueueRecord];
}

- (void)testAVAudioQueueRecord
{
    _recordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_recordBtn addTarget:self action:@selector(didRecordStart:) forControlEvents:UIControlEventTouchDown];
    [_recordBtn addTarget:self action:@selector(didRecordEnd:) forControlEvents:UIControlEventTouchUpInside];
    [_recordBtn setTitle:@"record" forState:UIControlStateNormal];
    _recordBtn.frame = CGRectMake(50, 200, 60, 40);
    _recordBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:_recordBtn];
    
    _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playBtn addTarget:self action:@selector(didPlayBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_playBtn setTitle:@"play" forState:UIControlStateNormal];
    _playBtn.frame = CGRectMake(200, 200, 60, 40);
    _playBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:_playBtn];

    [AudioQueuePlayer setupAudioSession];
    _playQueue = dispatch_queue_create("zong.playQueue", DISPATCH_QUEUE_SERIAL);
    _audioPlayer = [[AudioQueuePlayer alloc] init];
    _audioRecorder = [[AudioQueueRecorder alloc] init];
    _audioRecorder.delegate = self;
    
}


#pragma mark - action
- (void)didRecordStart:(UIButton *)btn
{
    NSLog(@"record start");
    self.audioRecordData = [[NSMutableData alloc] init];
    [self.audioRecorder startRecording];
}

- (void)didRecordEnd:(UIButton *)btn
{
    NSLog(@"record end");
    [self.audioRecorder stopRecording];
}


- (void)didPlayBtn:(UIButton *)btn
{
    NSLog(@"audio play");
    [self.audioPlayer playWithData:self.audioRecordData];
}

#pragma mark - AudioQueueRecorderDelegate
- (void)audioQueueRecorder:(AudioQueueRecorder *)recorder pcmData:(NSData *)pcmData
{
//    NSLog(@"recording...");
     NSLog(@"recording currentThread %@",[NSThread currentThread]);
//    [self.audioRecordData appendData:pcmData];
    
    // 发现线程特别重要
    dispatch_async(self.playQueue, ^{
        [self.audioPlayer playWithData:pcmData];
    });
}

@end
