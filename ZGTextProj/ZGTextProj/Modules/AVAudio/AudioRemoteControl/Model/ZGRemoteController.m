//
//  ZGRemoteController.m
//  ZGTextProj
//
//  Created by ali on 2019/3/26.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGRemoteController.h"
#import <AVFoundation/AVFoundation.h>

@implementation ZGRemoteController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    static ZGRemoteController *_zg_remoteController_;
    dispatch_once(&onceToken, ^{
        _zg_remoteController_ = [[ZGRemoteController alloc] init];
    });
    
    return _zg_remoteController_;
}

- (instancetype)init
{
    if (self = [super init]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didAppWillResignActiveNotification:) name:UIApplicationWillResignActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didAppWillEnterForegroundNotification:) name:UIApplicationWillEnterForegroundNotification object:nil];
    }
    return self;
}

- (void)setup
{
    ;
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}


#pragma mark - notify
- (void)didAppWillResignActiveNotification:(NSNotification *)note
{
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
    
    AVAudioSession *as = [AVAudioSession sharedInstance];
    NSError *error;
    [as setCategory:AVAudioSessionCategoryPlayback error:&error];
    [as setActive:YES error:&error];
}

- (void)didAppWillEnterForegroundNotification:(NSNotification *)note
{
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
}

#pragma mark - -
-(void)remoteControlReceivedWithEvent:(UIEvent *)event{
    NSLog(@"event tyipe:::%ld   subtype:::%ld",(long)event.type,(long)event.subtype);
    //type==2  subtype==单击暂停键：103，双击暂停键104
    if (event.type == UIEventTypeRemoteControl) {
        switch (event.subtype) {
                
            case UIEventSubtypeRemoteControlPlay:{
                NSLog(@"play---------");
            }break;
            case UIEventSubtypeRemoteControlPause:{
                NSLog(@"Pause---------");
            }break;
            case UIEventSubtypeRemoteControlStop:{
                NSLog(@"Stop---------");
            }break;
            case UIEventSubtypeRemoteControlTogglePlayPause:{
                //单击暂停键：103
                NSLog(@"单击暂停键：103");
            }break;
            case UIEventSubtypeRemoteControlNextTrack:{
                //双击暂停键：104
                NSLog(@"双击暂停键：104");
            }break;
            case UIEventSubtypeRemoteControlPreviousTrack:{
                NSLog(@"三击暂停键：105");
            }break;
            case UIEventSubtypeRemoteControlBeginSeekingForward:{
                NSLog(@"单击，再按下不放：108");
            }break;
            case UIEventSubtypeRemoteControlEndSeekingForward:{
                NSLog(@"单击，再按下不放，松开时：109");
            }break;
            default:
                break;
        }
    }
}

@end
