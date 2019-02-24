//
//  ZGCrashController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/3/28.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGCrashController.h"

@interface ZGCrashController ()

@property (nonatomic,strong) UIImageView *imgView;

@end

@implementation ZGCrashController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    NSProxy
    // 测试数组越界
//    [self testAryBounds];
    
    // 测试图片拉伸
    [self testImgStretch];

}

- (void)testImgStretch
{
    UIImage *img = [UIImage imageNamed:@"kid_bottom_list_icon_clean"];// ImgStretch
    
    // 拉伸图片
    // 设置端盖的值
    CGFloat top = img.size.height * 0.5;
    CGFloat left = img.size.width * 0.5;
    CGFloat bottom = img.size.height * 0.5;
    CGFloat right = img.size.width * 0.5;
    // 设置端盖的值
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
//    UIImage *newImage = [img resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch];
    UIImage *newImage = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    _imgView = [[UIImageView alloc] init];
    _imgView.frame = CGRectMake(50, 100, 100, 100);
    _imgView.image = newImage;
    _imgView.tintColor = [UIColor redColor];
    [self.view addSubview:_imgView];
}

- (void)testAryBounds
{
    // 测试数组越界
    NSArray *arry=[NSArray arrayWithObject:@"sss"];
    NSLog(@"%@",[arry objectAtIndex:1]);
}


@end
