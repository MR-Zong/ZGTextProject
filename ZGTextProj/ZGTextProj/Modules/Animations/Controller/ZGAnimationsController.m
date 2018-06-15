//
//  ZGAnimationsController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/6/15.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGAnimationsController.h"

@interface ZGAnimationsController ()

@property (nonatomic, strong) UIView *fv;
@property (nonatomic, strong) UIView *cv1;
@property (nonatomic, assign) BOOL isExtend;

@end

@implementation ZGAnimationsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Animations";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    /** 发现 父控件 和子控件都是正常动画
     */
    _isExtend = NO;
    
    _fv = [[UIView alloc] initWithFrame:CGRectMake(50, 120, 260, 100)];
    _fv.backgroundColor = [UIColor redColor];
    [self.view addSubview:_fv];
    
    _cv1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _cv1.backgroundColor = [UIColor blueColor];
    [_fv addSubview:_cv1];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_isExtend) {
        _isExtend = NO;
        [UIView animateWithDuration:0.25 animations:^{
            _fv.frame = CGRectMake(50, 120, 260, 100);
            _cv1.frame = CGRectMake(0, 0, 100, 100);
        }];
    }else {
        _isExtend = YES;
        [UIView animateWithDuration:0.25 animations:^{
            _fv.frame = CGRectMake(50, 120, 260, 200);
            _cv1.frame = CGRectMake(0, 100, 100, 100);
        }];

    }

}


@end
