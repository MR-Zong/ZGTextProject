//
//  ZGWKWebViewController.m
//  ZGTextProj
//
//  Created by ali on 2018/11/28.
//  Copyright © 2018 XuZonggen. All rights reserved.
//

#import "ZGWKWebViewController.h"
#import <WebKit/WebKit.h>
#import "ZGWKWebNoDataView.h"

@interface ZGWKBackButton : UIButton
@end

@implementation ZGWKBackButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 10, 10, 20);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(15, 0, 40, 40);
}
@end

@interface ZGWKWebViewController () <WKNavigationDelegate,WKUIDelegate>

@property (weak, nonatomic) UIButton *closeButton;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (strong, nonatomic) ZGWKWebNoDataView *noDataView;

@end

@implementation ZGWKWebViewController

- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

+(void)openUrl:(NSString*)url navigationController:(UINavigationController *)navigationController backType:(ZGWKWebViewBackType)backType
{
    ZGWKWebViewController *webVc = [[ZGWKWebViewController alloc] init];
    webVc.backType = backType;
    webVc.urlString=url;
    
    [navigationController pushViewController:webVc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.titleString;
    
    [self setupViews];
    [self loadHtml];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    CGFloat noDataViewWidth = 260;
    CGFloat noDataViewHeight = 260;
    self.noDataView.frame = CGRectMake((self.view.bounds.size.width - noDataViewWidth) / 2.0, (self.view.bounds.size.height - noDataViewHeight) / 2.0, noDataViewWidth, noDataViewHeight);
}

- (void)setupViews
{
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    _webView.navigationDelegate = self;
    _webView.backgroundColor = [UIColor whiteColor];
    
    
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    [self.view addSubview:_webView];

    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, _webView.frame.origin.y, self.view.bounds.size.width, 10)];
    _progressView.hidden = YES;
    [self.view addSubview:_progressView];
    
    [self setupNavigationLeftItems];
    
    [self setupNoDataView];
}

- (void)setupNavigationLeftItems
{
    ZGWKBackButton *leftBtn = [ZGWKBackButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 55, 40);
    [leftBtn setImage:[UIImage imageNamed:@"zg_webView_back_small"] forState:UIControlStateNormal];
    NSAttributedString *leftAttributeTitle = [[NSAttributedString alloc] initWithString:@"back" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15],NSForegroundColorAttributeName : [UIColor blackColor]}];
    [leftBtn setAttributedTitle:leftAttributeTitle forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeButton = closeButton;
    [closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    closeButton.frame = CGRectMake(0, 0, 35, 40);
    NSAttributedString *attributeTitle = [[NSAttributedString alloc] initWithString:@"close" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15],NSForegroundColorAttributeName :[UIColor blackColor]}];
    [closeButton setAttributedTitle:attributeTitle forState:UIControlStateNormal];
    
    UIBarButtonItem *closeBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
    NSArray *leftBarButtonItems = @[backBarButtonItem,closeBarButtonItem];
    [self.navigationItem setLeftBarButtonItems:leftBarButtonItems];
    self.closeButton.hidden = YES;
}

- (void)setupNoDataView
{
    _noDataView = [[ZGWKWebNoDataView alloc] init];
    _noDataView.hidden = YES;
    [self.view addSubview:_noDataView];
}

- (void)loadHtml
{
    if (self.urlString.length > 0) {
        NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.urlString]];
        [self.webView loadRequest:req];
    }else {
        // 显示url错误
        [self.noDataView setImage:nil text:@"网址错误"];
    }
}

#pragma mark - listen button click
- (void)back
{
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }else {
        [self close];
    }
}

- (void)close
{
    if (self.backType == ZGWKWebViewBackTypeDefault) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (self.backType == ZGWKWebViewBackTypePop) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (self.backType == ZGWKWebViewBackTypeDismiss) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - kvo
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.hidden = (self.webView.estimatedProgress == 1);
        [self.progressView setProgress:(CGFloat)self.webView.estimatedProgress animated:YES];
    }else if ([keyPath isEqualToString:@"title"]) {
        self.title = self.webView.title;
    }else {
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
    }
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"didFinishNavigation");
    self.progressView.progress = 0;
    self.closeButton.hidden = !self.webView.canGoBack;
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"didFailNavigation");
    self.noDataView.hidden = NO;
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"didFailProvisionalNavigation");
    self.noDataView.hidden = NO;
}

@end
