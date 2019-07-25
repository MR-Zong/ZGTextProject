//
//  ZGUUidViewController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2019/7/11.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGUUidViewController.h"
#import <AdSupport/AdSupport.h>
#import <WKWebViewJavascriptBridge.h>
#import <WebViewJavascriptBridge.h>

@interface ZGUUidViewController () <WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, strong) WebViewJavascriptBridge *uiJsBridg;
@property (nonatomic, strong) WKWebViewJavascriptBridge *wkjsBridge;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIButton *btn;

@end

@implementation ZGUUidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // mainBundle 文件 不能被修改,只读
//     NSString *filePath = [[NSBundle mainBundle] pathForResource:@"btest.txt" ofType:nil];
////    [self.class removeFile:filePath];
//
//    NSString *content = @"zong";
//    NSError *error = nil;
//    BOOL re = [[content dataUsingEncoding:NSUTF8StringEncoding] writeToFile:filePath options:NSDataWritingAtomic error:&error];
//    NSLog(@"re %zd,error %@",re,error);
//
//    NSData *filedata = [NSData dataWithContentsOfFile:filePath];
//    NSString *fileString = [[NSString alloc] initWithData:filedata encoding:NSUTF8StringEncoding];
//    NSLog(@"fileString %@",fileString);
    
    // 测试语句块,是否执行一次
    [self testYuJuKuai];
    
    [self testUUID];
}

#pragma mark -
- (void)testYuJuKuai
{
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn setTitle:@"语句块测试" forState:UIControlStateNormal];
    _btn.titleLabel.font = [UIFont systemFontOfSize:16];
    _btn.backgroundColor = [UIColor blueColor];
    _btn.frame = CGRectMake(50, 200, 140, 40);
    [_btn addTarget:self action:@selector(didBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
}

- (void)didBtn:(UIButton *)btn
{
    {
        NSLog(@"xxxxxxxxx");
    }
}


+ (BOOL)removeFile:(NSString*)filePath{
    BOOL isSuccess = NO;
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    isSuccess = [fileManager removeItemAtPath:filePath error:&error];
    if (error) {
        NSLog(@"removeFile Field：%@",[error localizedDescription]);
    }else{
        NSLog(@"removeFile Success");
    }
    return isSuccess;
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
