//
//  ZGWebKitTestController.m
//  ZGTextProj
//
//  Created by ali on 2018/11/27.
//  Copyright © 2018 XuZonggen. All rights reserved.
//

#import "ZGWebKitTestController.h"
#import <WebKit/WebKit.h>

@interface ZGWebKitTestController () <WKNavigationDelegate,WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation ZGWebKitTestController

- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testWebKit];
}

- (void)testWebKit
{
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    _webView.navigationDelegate = self;
    _webView.backgroundColor = [UIColor redColor];
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    [_webView loadRequest:req];
    [self.view addSubview:_webView];
    
    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 10)];
    _progressView.hidden = YES;
    [self.view addSubview:_progressView];
}

#pragma mark - kvo
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.hidden = (self.webView.estimatedProgress == 1);
        [self.progressView setProgress:(CGFloat)self.webView.estimatedProgress animated:YES];
    }
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    self.progressView.progress = 0;
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    ;
}

@end
