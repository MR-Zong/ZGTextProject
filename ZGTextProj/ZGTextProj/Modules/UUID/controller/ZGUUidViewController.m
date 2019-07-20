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

@end

@implementation ZGUUidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
     [self testWKWebView];
    
//    [self testUUID];
}

- (void)testUUID
{
    /**
     * 苹果广告 id  可以被重置 也可以被限制获取
     */
    NSString *adId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSLog(@"adId %@",adId);
}


#pragma mark --
- (void)testWKWebViewJSBridge
{
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
    config.requiresUserActionForMediaPlayback = YES;
    //设置是否允许画中画技术 在特定设备上有效
    config.allowsPictureInPictureMediaPlayback = YES;
    //设置请求的User-Agent信息中应用程序名称 iOS9后可用
    config.applicationNameForUserAgent = @"ChinaDailyForiPad";
    
    
    WKWebView *wkWeb = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    wkWeb.backgroundColor = [UIColor redColor];
    [self.view addSubview:wkWeb];
    _wkjsBridge = [WKWebViewJavascriptBridge bridgeForWebView:wkWeb];
    [wkWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    
    
    // UIWebView
    //    UIWebView *uiWeb = [[UIWebView alloc] initWithFrame:self.view.bounds];
    //    [self.view addSubview:uiWeb];
    //
    //    _uiJsBridg = [WebViewJavascriptBridge bridgeForWebView:uiWeb];
    //    [uiWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
}


- (void)testWKWebView
{
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
    config.requiresUserActionForMediaPlayback = YES;
    //设置是否允许画中画技术 在特定设备上有效
    config.allowsPictureInPictureMediaPlayback = YES;
    //设置请求的User-Agent信息中应用程序名称 iOS9后可用
    config.applicationNameForUserAgent = @"ChinaDailyForiPad";


    WKWebView *wkWeb = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    wkWeb.backgroundColor = [UIColor redColor];
    wkWeb.navigationDelegate = self;
    wkWeb.UIDelegate = self;
    [self.view addSubview:wkWeb];
//    [wkWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://sfestival.lizhi.fm/static/gift_progress_new.html?userId=2568669201606673964&isSFestivalOpen=false&isRedEnvelopeOpen=true&redEnvelopeHost=https%3A%2F%2Fredenvelope.lizhi.fm&isValentineDayOpen=false&isHidePendant=true&isFirstChargeWidgetShow=false&isBraveOpen=false&appId=0&subAppId=0&coinLotteryOpen=false&liveId=5055101392710816822&accessToken=806D16B4408E8F98C968BAA1C83EBA5FBDD86A9FD5635EA4F0D6FDE5FFB695B641F2694AE3011498346B93DDB1EC2B68F68FBAD0C157D61CDE87E78EB35E1C0AFF9841E4A65A4A94B5B44E74148F6F2052AA16318C89F1DB"]]];
    [wkWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [wkWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:bdddlank"]]];
    });
    
    
    // UIWebView
//        UIWebView *uiWeb = [[UIWebView alloc] initWithFrame:self.view.bounds];
//        [self.view addSubview:uiWeb];
//        [uiWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
//    [uiWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"gk"]]];
}


#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSLog(@"navigationAction.request.URL %@",navigationAction.request.URL);
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
    ;
}


- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    ;
}

#pragma mark - WKUIDelegate

@end
