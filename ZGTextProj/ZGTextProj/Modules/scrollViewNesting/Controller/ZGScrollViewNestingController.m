//
//  ZGScrollViewNestingController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/5/13.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGScrollViewNestingController.h"

@interface ZGScrollViewNestingController ()

@end

@implementation ZGScrollViewNestingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"scrollView嵌套";
    self.view.backgroundColor = [UIColor whiteColor];
    
    /* 微博个人主页效果
    *  方案筛选
    *  1，两个UITableView 通过contentInset.top 的方法来实现
    *  但整个方案 很不完美
    *  2，直接一个大scrollView  然后里面 两个UITAbleView
    */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
