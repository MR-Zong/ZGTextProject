//
//  ZGComposeVideoAndAudioViewController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/8/3.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import "ZGComposeVideoAndAudioViewController.h"

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import "ZGComposeVideoAndAudioManager.h"
#import "ZGComposeAudioModel.h"
#import "ZGAudioManager.h"
#import "ZGImagesToVideoManager.h"


@interface ZGComposeVideoAndAudioViewController () <ZGAudioManagerDelegate>

{
    NSMutableArray *rawImageArr; //未压缩的图片
    NSMutableArray *imageArray; //经过压缩的图片
    NSMutableArray *frameArray; //封装成帧后的数组
    NSMutableArray *frameDurationArray; // 对应frame 显示时长
}

@property (nonatomic, strong) NSString *theVideoPath;
@property (nonatomic, strong) NSURL *composeAVFileUrl;
@property (nonatomic, copy) NSURL *composeAudiosURL;

@property (nonatomic, strong) ZGAudioManager *audioManager;


// video
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *composeImgsToVideoBtn;
@property (nonatomic, strong) UIButton *playComposeVideoBtn;
// audio
@property (nonatomic, strong) UIButton *playAudioBtn;
@property (nonatomic, strong) UIButton *startRecordAudioBtn;
@property (nonatomic, strong) UIButton *endRecordAudioBtn;
@property (nonatomic, strong) UIButton *composeAudiosBtn;
@property (nonatomic, strong) UIButton *playComposeAudioBtn;

// 合成音视频
@property (nonatomic, strong) UIButton *composeVideoAndAudioBtn;
@property (nonatomic, strong) UIButton *playComposeVideoAndAudioBtn;




@end

@implementation ZGComposeVideoAndAudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initialize];
    [self setupViews];
}

- (void)initialize
{
    _audioManager = [ZGAudioManager shareInstance];
    _audioManager.delegate = self;
}

- (void)setupViews
{
    _composeImgsToVideoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _composeImgsToVideoBtn.frame = CGRectMake(20, 70, 150, 40);
    _composeImgsToVideoBtn.backgroundColor = [UIColor orangeColor];
    [_composeImgsToVideoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_composeImgsToVideoBtn setTitle:@"图片合成视频" forState:UIControlStateNormal];
    [_composeImgsToVideoBtn addTarget:self action:@selector(didComposeImgsToVideoBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_composeImgsToVideoBtn];
    
    _playComposeVideoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _playComposeVideoBtn.frame = CGRectMake(20, 120, 150, 40);
    _playComposeVideoBtn.backgroundColor = [UIColor orangeColor];
    [_playComposeVideoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_playComposeVideoBtn setTitle:@"播放合成视频" forState:UIControlStateNormal];
    [_playComposeVideoBtn addTarget:self action:@selector(didPlayComposeVideoBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_playComposeVideoBtn];
    
    
    // audio
    _playAudioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _playAudioBtn.frame = CGRectMake(20, 170, 150, 40);
    _playAudioBtn.backgroundColor = [UIColor orangeColor];
    [_playAudioBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_playAudioBtn setTitle:@"播放当前录音" forState:UIControlStateNormal];
    [_playAudioBtn addTarget:self action:@selector(didPlayAudioBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_playAudioBtn];
    
    _startRecordAudioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _startRecordAudioBtn.frame = CGRectMake(20, 220, 150, 40);
    _startRecordAudioBtn.backgroundColor = [UIColor orangeColor];
    [_startRecordAudioBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_startRecordAudioBtn setTitle:@"开始录音" forState:UIControlStateNormal];
    [_startRecordAudioBtn addTarget:self action:@selector(didStartRecordAudioBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_startRecordAudioBtn];
    
    _endRecordAudioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _endRecordAudioBtn.frame = CGRectMake(20, 270, 150, 40);
    _endRecordAudioBtn.backgroundColor = [UIColor orangeColor];
    [_endRecordAudioBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_endRecordAudioBtn setTitle:@"结束录音" forState:UIControlStateNormal];
    [_endRecordAudioBtn addTarget:self action:@selector(didEndRecordAudioBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_endRecordAudioBtn];
    
    _composeAudiosBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _composeAudiosBtn.frame = CGRectMake(180, 70, 150, 40);
    _composeAudiosBtn.backgroundColor = [UIColor orangeColor];
    [_composeAudiosBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_composeAudiosBtn setTitle:@"合成多音频" forState:UIControlStateNormal];
    [_composeAudiosBtn addTarget:self action:@selector(didComposeAudiosBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_composeAudiosBtn];
    
    _playComposeAudioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _playComposeAudioBtn.frame = CGRectMake(180, 120, 150, 40);
    _playComposeAudioBtn.backgroundColor = [UIColor orangeColor];
    [_playComposeAudioBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_playComposeAudioBtn setTitle:@"播放合成音频" forState:UIControlStateNormal];
    [_playComposeAudioBtn addTarget:self action:@selector(didPlayComposeAudioBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_playComposeAudioBtn];
    
    // 合成音视频
    _composeVideoAndAudioBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _composeVideoAndAudioBtn.frame = CGRectMake(180, 170, 150, 40);
    _composeVideoAndAudioBtn.backgroundColor = [UIColor orangeColor];
    [_composeVideoAndAudioBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_composeVideoAndAudioBtn setTitle:@"合成音视频" forState:UIControlStateNormal];
    [_composeVideoAndAudioBtn addTarget:self action:@selector(didComposeVideoAndAudioBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_composeVideoAndAudioBtn];

    _playComposeVideoAndAudioBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _playComposeVideoAndAudioBtn.frame = CGRectMake(180, 220, 150, 40);
    _playComposeVideoAndAudioBtn.backgroundColor = [UIColor orangeColor];
    [_playComposeVideoAndAudioBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_playComposeVideoAndAudioBtn setTitle:@"播放合成音视频" forState:UIControlStateNormal];
    [_playComposeVideoAndAudioBtn addTarget:self action:@selector(didPlayComposeVideoAndAudioBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_playComposeVideoAndAudioBtn];

    
    // imageView
    _imageView = [[UIImageView alloc] init];
    _imageView.backgroundColor = [UIColor blackColor];
    _imageView.frame = CGRectMake(20, 500, 320, 200);
    [self.view addSubview:_imageView];

}

- (void)prepareImageSource
{
    rawImageArr =[[NSMutableArray alloc]initWithObjects:
    [UIImage imageNamed:@"longzhu1"],[UIImage imageNamed:@"longzhu2"],nil];
    

    AVURLAsset*audioAsset = [AVURLAsset URLAssetWithURL:self.composeAudiosURL options:nil];
    CMTime audioDuration = audioAsset.duration;
    float audioDurationSeconds = CMTimeGetSeconds(audioDuration);
    frameDurationArray = [[NSMutableArray alloc] initWithObjects:@(audioDurationSeconds),@(1), nil];
    
    imageArray = [[NSMutableArray alloc] initWithCapacity:rawImageArr.count];
    frameArray = [[NSMutableArray alloc] initWithCapacity:rawImageArr.count];
    
    for (int i = 0; i<rawImageArr.count; i++) {
        UIImage *imageNew = rawImageArr[i];
        //设置image的尺寸
        CGSize imagesize = imageNew.size;
        imagesize.height =408;
        imagesize.width =306;
        //对图片大小进行压缩--
        imageNew = [self imageWithImage:imageNew scaledToSize:imagesize];
        [imageArray addObject:imageNew];
        
        // 封装成frame
        NSUInteger frameDuration = [frameDurationArray[i] integerValue];
        ZGImageFrameModel *frame = [ZGImageFrameModel imageFrameWithImage:imageNew frameDuration:frameDuration];
        [frameArray addObject:frame];
    }

}

//对图片尺寸进行压缩--

-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    //    新创建的位图上下文 newSize为其大小
    UIGraphicsBeginImageContext(newSize);
    //    对图片进行尺寸的改变
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    //    从当前上下文中获取一个UIImage对象  即获取新的图片对象
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}



#pragma mark - video
- (void)didComposeImgsToVideoBtn:(UIButton *)btn
{
    self.theVideoPath = [[ZGImagesToVideoManager shareInstance] compressionWithImagesArray:frameArray];
}

- (void)didPlayComposeVideoBtn:(UIButton *)btn
{
    NSLog(@"************%@",self.theVideoPath);
    NSURL *sourceMovieURL = [NSURL fileURLWithPath:self.theVideoPath];
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.frame = CGRectMake(20, 320, 320, 150);
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.view.layer addSublayer:playerLayer];
    [player play];
}


#pragma mark - audio action
- (void)didPlayAudioBtn:(UIButton *)btn
{
    [[ZGAudioManager shareInstance] playRecordAudio];
}

- (void)didStartRecordAudioBtn:(UIButton *)btn
{
    [[ZGAudioManager shareInstance] startRecord];
}

- (void)didEndRecordAudioBtn:(UIButton *)btn
{
    [[ZGAudioManager shareInstance] stopRecord];
}

- (void)didComposeAudiosBtn:(UIButton *)btn
{
    self.composeAudiosURL = [[ZGAudioManager shareInstance] composeAudios];
}

- (void)didPlayComposeAudioBtn:(UIButton *)btn
{
    [[ZGAudioManager shareInstance] playComposeAudio];
}

#pragma mark - videoAndAudio

- (void)didComposeVideoAndAudioBtn:(UIButton *)btn
{
    // 声音来源
//    NSURL *audioInputUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"五环之歌" ofType:@"mp3"]];
    NSURL *audioInputUrl = self.composeAudiosURL;
    // 视频来源
//    NSString *videoFilePath = [[NSBundle mainBundle] pathForResource:@"myPlayer" ofType:@"mp4"];
//    NSURL *videoInputUrl = [NSURL fileURLWithPath:videoFilePath];

    NSURL *videoInputUrl = [NSURL fileURLWithPath:self.theVideoPath];
    self.composeAVFileUrl = [[ZGComposeVideoAndAudioManager shareInstance] composeVideoInputUrl:videoInputUrl audioInputUrl:audioInputUrl];
}

- (void)didPlayComposeVideoAndAudioBtn:(UIButton *)btn
{
    // 传入地址
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:self.composeAVFileUrl];
    // 播放器
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    // 播放器layer
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.frame = self.imageView.bounds;
    // 视频填充模式
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    // 添加到imageview的layer上
    [self.imageView.layer addSublayer:playerLayer];
    
    // 播放
    [player play];

}



#pragma mark - ZGAudioManagerDelegate
- (void)audioManagerDidCompleteComposeAudiosWithDestUrl:(NSURL *)destUrl
{
    [self prepareImageSource];
}


@end
