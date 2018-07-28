//
//  ZGBrightnessController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/1/6.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGBrightnessController.h"
#import "ZGBrightManger.h"

@interface ZGBrightnessController ()

@property (nonatomic,strong) ZGBrightManger *brightM;

@end

@implementation ZGBrightnessController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"环境光照";
    
    // 测试NSDictionary 能否删除，设置nil
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    // 字典不能设置Nil，否则崩溃
//    [mDic setObject:nil forKey:@"a"];
    
    NSObject *p1 = [[NSObject alloc] init];
    [mDic setObject:p1 forKey:@"p1"];
    NSLog(@"mDic %@",mDic);
    for (NSString *key in mDic.allKeys) {
        NSLog(@"key %@, value %@",key,mDic[key]);
    }
    
    [mDic removeObjectForKey:@"p1"];
    NSLog(@"mDic %@",mDic);
    for (NSString *key in mDic.allKeys) {
        NSLog(@"key %@, value %@",key,mDic[key]);
    }
    
    
    // 测试 感光
    [self test];
}

- (void)test
{
    [[ZGBrightManger shareInstance] getBrightnessWithCompleteBlock:^(float brightness) {
        NSLog(@"brightness == %f",brightness);
    }];
}

@end
