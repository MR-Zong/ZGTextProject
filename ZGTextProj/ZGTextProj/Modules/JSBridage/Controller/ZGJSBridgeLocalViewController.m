//
//  ZGJSBridgeLocalViewController.m
//  ZGTextProj
//
//  Created by XuZongGen on 2019/7/25.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGJSBridgeLocalViewController.h"
#import <WebKit/WebKit.h>

static NSString *const kLZScheme = @"lizhi";

@interface ZGJSBridgeLocalViewController () <WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) WKWebView *wkWeb;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSTimeInterval beginTime;

@end

@implementation ZGJSBridgeLocalViewController

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
    WKUserContentController *userController = [[WKUserContentController alloc] init];
    config.userContentController = userController;
    
    [userController addScriptMessageHandler:self name:@"testA"];
    
    
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
    //    NSString *localHtml = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"iframeTestLocal.html"];
    //    NSURL *localUrl = [NSURL fileURLWithPath:localHtml];
    //    [self.wkWeb loadRequest:[NSURLRequest requestWithURL:localUrl]];
    
    NSString *localHtml = [[NSBundle mainBundle] pathForResource:@"iframeTestLocal.html" ofType:nil];
    NSURL *localUrl = [NSURL fileURLWithPath:localHtml];
    [self.wkWeb loadFileURL:localUrl allowingReadAccessToURL:[NSBundle mainBundle].bundleURL];
    
    
    // count 清零
    self.count = 0;
    
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    if ([message.name isEqualToString:@"testA"]) {
        
        if (self.count == 0) {
            _beginTime = [[NSDate date] timeIntervalSince1970];
        }else if (self.count == 500) {
            NSTimeInterval endTime = [[NSDate date] timeIntervalSince1970];
            NSLog(@"costTime %f",endTime-_beginTime);
        }
        NSString *body = message.body;
        NSLog(@"body： %@, count %zd", body,self.count);
        self.count++;
    }
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSString *scheme = navigationAction.request.URL.scheme;
    
    NSLog(@"navigationAction.request.URL %@",navigationAction.request.URL);
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    ;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"didFinishLoad");
    [self.wkWeb evaluateJavaScript:@"sendMessageSet('hello')" completionHandler:nil];
}


- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    ;
}

#pragma mark - WKUIDelegate

@end
