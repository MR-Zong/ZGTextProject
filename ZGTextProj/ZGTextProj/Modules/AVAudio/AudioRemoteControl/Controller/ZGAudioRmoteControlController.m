//
//  ZGAudioRmoteControlController.m
//  ZGTextProj
//
//  Created by ali on 2019/1/22.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGAudioRmoteControlController.h"
#import <AVFoundation/AVFoundation.h>

@interface ZGAudioRmoteControlController ()

@end

@implementation ZGAudioRmoteControlController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
    
    AVAudioSession *as = [AVAudioSession sharedInstance];
    NSError *error;
    [as setCategory:AVAudioSessionCategoryPlayback error:&error];
    [as setActive:YES error:&error];
}


-(BOOL)canBecomeFirstResponder{
    return YES;
}

//received remote event
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
