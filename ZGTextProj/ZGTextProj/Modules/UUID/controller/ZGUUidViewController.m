//
//  ZGUUidViewController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2019/7/11.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGUUidViewController.h"
#import <AdSupport/AdSupport.h>

@interface ZGUUidViewController ()

@end

@implementation ZGUUidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self testUUID];
}

- (void)testUUID
{
    /**
     * 苹果广告 id  可以被重置 也可以被限制获取
     */
    NSString *adId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSLog(@"adId %@",adId);
}

@end
