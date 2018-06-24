//
//  ZGAnisTestController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/6/24.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGAnisTestController.h"

@interface ZGAnisTestController ()

@property (nonatomic, strong) UIButton *aniBtn;
@property (nonatomic, strong) UIView *aniView;
@property (nonatomic, assign) BOOL isEnd;

@end

@implementation ZGAnisTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupViews];
}


- (void)setupViews
{
    _aniView = [[UIView alloc] init];
    _aniView.frame = CGRectMake(0, 100, 50, 50);
    _aniView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_aniView];
    
    
    _aniBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _aniBtn.backgroundColor = [UIColor purpleColor];
    _aniBtn.frame = CGRectMake(100, 300, 60, 40);
    [_aniBtn setTitle:@"Ani" forState:UIControlStateNormal];
    [_aniBtn addTarget:self action:@selector(didAniBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_aniBtn];
}

- (void)didAniBtn:(UIButton *)btn
{
    self.isEnd = !self.isEnd;
    if (self.isEnd) {
        
        self.aniView.frame = CGRectMake(300, 100, 50, 50);
        [UIView animateWithDuration:0.25 animations:^{
            self.aniView.frame = CGRectMake(0, 100, 50, 50);
        }];
    }else {
        self.aniView.frame = CGRectMake(0, 100, 50, 50);
        [UIView animateWithDuration:0.25 animations:^{
            self.aniView.frame = CGRectMake(300, 100, 50, 50);
        }];
    }
    
}


@end
