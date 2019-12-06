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

@end

@implementation ZGAudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self testMp4];
}

- (void)testMp4
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"liuchang.aac" ofType:nil];
    double fileDuration = [ZGAACUtil fileDurationWithFilePath:filePath];
    NSLog(@"fileDuration %f",fileDuration);
}


@end
