//
//  ZGAliyunTestController.m
//  ZGTextProj
//
//  Created by ali on 2019/3/15.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGAliyunTestController.h"
#import "AudioQueueRecorder.h"
#import "AudioQueuePlayer.h"
#import "ZGAliyunRecognizer.h"

@interface ZGAliyunTestController () <AudioQueueRecorderDelegate>
@property (nonatomic,strong) UIButton *recordBtn;
@property (nonatomic,strong) UIButton *stopBtn;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) UIButton *clearBtn;

@property (nonatomic, strong) AudioQueuePlayer *audioPlayer;
@property (nonatomic, strong) AudioQueueRecorder *audioRecorder;
@property (nonatomic, strong) NSMutableData *audioRecordData;
@property (nonatomic, strong) dispatch_queue_t playQueue;

@property (nonatomic, strong) ZGAliyunRecognizer *recognizer;
@property (nonatomic, strong) UITextView *textView;

@end

@implementation ZGAliyunTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    

    // 实时录音
    [self testAVAudioQueueRecord];
    
    _recognizer = [[ZGAliyunRecognizer alloc] init];
    _recognizer.textView = _textView;
}

- (void)testAVAudioQueueRecord
{
    _recordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_recordBtn addTarget:self action:@selector(didRecordStart:) forControlEvents:UIControlEventTouchDown];
    [_recordBtn setTitle:@"record" forState:UIControlStateNormal];
    _recordBtn.frame = CGRectMake(50, 200, 60, 40);
    _recordBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:_recordBtn];
    
    _stopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_stopBtn addTarget:self action:@selector(didRecordStop:) forControlEvents:UIControlEventTouchDown];
    [_stopBtn setTitle:@"stop" forState:UIControlStateNormal];
    _stopBtn.frame = CGRectMake(50, 250, 60, 40);
    _stopBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:_stopBtn];
    
    _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playBtn addTarget:self action:@selector(didPlayBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_playBtn setTitle:@"play" forState:UIControlStateNormal];
    _playBtn.frame = CGRectMake(200, 200, 60, 40);
    _playBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:_playBtn];
    
    _clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_clearBtn addTarget:self action:@selector(didClearBtn) forControlEvents:UIControlEventTouchUpInside];
    [_clearBtn setTitle:@"clear" forState:UIControlStateNormal];
    _clearBtn.frame = CGRectMake(200, 250, 60, 40);
    _clearBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:_clearBtn];
    
    _textView = [[UITextView alloc] init];
    _textView.frame = CGRectMake(50, CGRectGetMaxY(_stopBtn.frame)+30, 230, 200);
    _textView.textColor = [[UIColor redColor] colorWithAlphaComponent:0.7];
    _textView.backgroundColor = [UIColor lightGrayColor];
    _textView.font = [UIFont systemFontOfSize:13];
    _textView.text = @"初始化文本";
    [self.view addSubview:_textView];
    
    [AudioQueuePlayer setupAudioSession];
    _playQueue = dispatch_queue_create("zong.playQueue", DISPATCH_QUEUE_SERIAL);
    _audioPlayer = [[AudioQueuePlayer alloc] init];
    _audioRecorder = [[AudioQueueRecorder alloc] init];
    _audioRecorder.delegate = self;
    
}


#pragma mark - action
- (void)didClearBtn
{
    self.textView.text = @"";
}

- (void)didRecordStart:(UIButton *)btn
{
    NSLog(@"record start");
    [self.recognizer startRecognize];
    self.audioRecordData = [[NSMutableData alloc] init];
    [self.audioRecorder startRecording];
}

- (void)didRecordStop:(UIButton *)btn
{
    NSLog(@"record end");
    [self.recognizer stopRecognize];
    [self.audioRecorder stopRecording];
}

- (void)didRecordEnd:(UIButton *)btn
{
    NSLog(@"record end");
    [self.recognizer stopRecognize];
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
    NSLog(@"pcmData.len %zd",pcmData.length);
    [self.recognizer voiceRecorded:pcmData];
    //    NSLog(@"recording...");
    //     NSLog(@"recording currentThread %@",[NSThread currentThread]);
    //    [self.audioRecordData appendData:pcmData];
    
    // 发现线程特别重要
    //    dispatch_async(self.playQueue, ^{
    //        [self.audioPlayer playWithData:pcmData];
    //    });
}

@end
