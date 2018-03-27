//
//  ZGOffScreenController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/9/7.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import "ZGOffScreenController.h"

@interface ZGOffScreenController ()

@end

@implementation ZGOffScreenController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(50, 100, 40, 40);
    btn1.layer.cornerRadius = 20.0;
    btn1.layer.masksToBounds = YES;
    [btn1 setTitle:@"测试" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn1];
    
    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(50, 170, 100, 100)];
    imgView1.image = [UIImage imageNamed:@"求红包"];
    imgView1.layer.cornerRadius = 50.0;
    imgView1.layer.masksToBounds = YES;
    imgView1.contentMode = UIViewContentModeScaleToFill;
//    imgView1.layer.borderColor = [UIColor blackColor].CGColor;
//    imgView1.layer.borderWidth = 2.0;
//    imgView1.backgroundColor = [UIColor blackColor];
    [self.view addSubview:imgView1];
}



@end
