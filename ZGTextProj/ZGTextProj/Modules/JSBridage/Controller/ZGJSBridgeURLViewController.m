//
//  ZGJSBridgeURLViewController.m
//  ZGTextProj
//
//  Created by XuZongGen on 2019/7/25.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGJSBridgeURLViewController.h"
#import <WebKit/WebKit.h>

static NSString *const kLZScheme = @"lizhi";

@interface ZGJSBridgeURLViewController () <WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) WKWebView *wkWeb;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger blankCount;
@property (nonatomic, assign) NSTimeInterval beginTime;

@end

@implementation ZGJSBridgeURLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupViews];
}

- (void)setupViews
{
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn setTitle:@"JSBridge测试" forState:UIControlStateNormal];
    _btn.titleLabel.font = [UIFont systemFontOfSize:16];
    _btn.backgroundColor = [UIColor blueColor];
    _btn.frame = CGRectMake(50, 200, 140, 40);
    [_btn addTarget:self action:@selector(didBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    
    // 创建设置对象
    WKPreferences *preference = [[WKPreferences alloc]init];
    //最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
    preference.minimumFontSize = 0;
    //设置是否支持javaScript 默认是支持的
    preference.javaScriptEnabled = YES;
    // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
    preference.javaScriptCanOpenWindowsAutomatically = YES;
    config.preferences = preference;
    
    // 是使用h5的视频播放器在线播放, 还是使用原生播放器全屏播放
    config.allowsInlineMediaPlayback = YES;
    //设置视频是否需要用户手动播放  设置为NO则会允许自动播放
    //    config.requiresUserActionForMediaPlayback = YES;
    //设置是否允许画中画技术 在特定设备上有效
    config.allowsPictureInPictureMediaPlayback = YES;
    //设置请求的User-Agent信息中应用程序名称 iOS9后可用
    config.applicationNameForUserAgent = @"ChinaDailyForiPad";
    
    
    _wkWeb = [[WKWebView alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(self.btn.frame)+30, self.view.bounds.size.width - 100, 200) configuration:config];
    _wkWeb.layer.borderColor = [UIColor orangeColor].CGColor;
    _wkWeb.layer.borderWidth = 1;
    _wkWeb.backgroundColor = [UIColor redColor];
    _wkWeb.navigationDelegate = self;
    _wkWeb.UIDelegate = self;
    [self.view addSubview:_wkWeb];
}

#pragma mark - action
- (void)didBtn:(UIButton *)btn
{
    [self testWKWebView];
}

- (void)testWKWebView
{
    NSString *localHtml = [[NSBundle mainBundle] pathForResource:@"iframeTest.html" ofType:nil];
    NSURL *localUrl = [NSURL fileURLWithPath:localHtml];
    [self.wkWeb loadFileURL:localUrl allowingReadAccessToURL:[NSBundle mainBundle].bundleURL];
    
    
    // count 清零
    self.count = 0;
    self.blankCount = 0;
    
    /**
     * 发现 只要有about:开头就可以实现白屏功能
     */
    //    _timer = [NSTimer scheduledTimerWithTimeInterval:0.03 repeats:YES block:^(NSTimer * _Nonnull timer) {
    //        [wkWeb evaluateJavaScript:@"sendMessage('hello')" completionHandler:nil];
    //    }];
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        // 测试单个JS消息
    //        [self.wkWeb evaluateJavaScript:@"sendMessage('hello')" completionHandler:nil];
    //    });
    
}


#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSString *scheme = navigationAction.request.URL.scheme;
    
    //    NSLog(@"navigationAction.request.URL %@",navigationAction.request.URL);
    if ([navigationAction.request.URL.absoluteString isEqualToString:@"about:blank"]) {
        //        NSLog(@"navigationAction.request.URL %@, blankCount %zd",navigationAction.request.URL,self.blankCount);
        self.blankCount++;
    }
    
    
    // 测试 JS连续批量消息
    if ([scheme isEqualToString:kLZScheme]) {
        //            NSLog(@"navigationAction.request.URL %@, count %zd",navigationAction.request.URL,self.count);
        if (self.count == 0) {
            _beginTime = [[NSDate date] timeIntervalSince1970];
        }else if (self.count == 500) {
            NSTimeInterval endTime = [[NSDate date] timeIntervalSince1970];
            NSLog(@"costTime %f",endTime-_beginTime);
        }
        self.count++;
    }
    
    // 测试 单个JS
    //    if ([scheme isEqualToString:kLZScheme]) {
    //        NSLog(@"navigationAction.request.URL %@, count %zd",navigationAction.request.URL,self.count);
    //    }
    //
    //    if ([scheme isEqualToString:kLZScheme] && self.count < 100 ) {
    //        //    if (self.count < 500 ) {
    //
    //
    //        // 不延迟
    //        [self.wkWeb evaluateJavaScript:@"sendMessage('hello')" completionHandler:nil];
    //
    //        // 延迟
    //        //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        //            [self.wkWeb evaluateJavaScript:@"sendMessage('hello')" completionHandler:nil];
    //        //            if (self.count == 10 || self.count ==20) {
    //        //                [self.wkWeb evaluateJavaScript:@"sendBlank()" completionHandler:nil];
    //        //            }
    //        //        });
    //
    //        self.count++;
    //    } // end if
    
    
    
    
    //    if ([navigationAction.request.URL.absoluteString isEqualToString:@"about:blank"]) {
    //        decisionHandler(WKNavigationActionPolicyCancel);
    //        return;
    //    }
    
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    ;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"didFinishLoad");
    
    // 测试单个JS消息
    //    [self.wkWeb evaluateJavaScript:@"sendMessage('hello')" completionHandler:nil];
    
    // 测试 JS连续批量消息
    [self.wkWeb evaluateJavaScript:@"sendMessageSet('hello')" completionHandler:nil];
    
}


- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    ;
}

#pragma mark - WKUIDelegate

@end
