//
//  ZGWebKitTestController.m
//  ZGTextProj
//
//  Created by ali on 2018/11/27.
//  Copyright © 2018 XuZonggen. All rights reserved.
//

#import "ZGWebKitTestController.h"
#import "ZGWKWebViewController.h"

@interface ZGWebKitTestController ()

@property (nonatomic, strong) UIButton *btnWeb;


@end

@implementation ZGWebKitTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self testWebKit];
}

- (void)testWebKit
{
    _btnWeb = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnWeb.frame = CGRectMake(50, 200, 100, 40);
    _btnWeb.backgroundColor = [UIColor redColor];
    [_btnWeb setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal
     ];
    [_btnWeb setTitle:@"testWKWebView" forState:UIControlStateNormal];
    [_btnWeb addTarget:self action:@selector(didBtnWeb) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnWeb];
}

- (void)didBtnWeb
{
    ZGWKWebViewController *webVC = [[ZGWKWebViewController alloc] init];
    webVC.urlString = @"https://www.baidu.com";
    [self.navigationController pushViewController:webVC animated:YES];
}



@end
