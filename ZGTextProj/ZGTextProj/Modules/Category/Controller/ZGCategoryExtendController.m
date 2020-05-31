//
//  ZGCategoryExtendController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/7/22.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGCategoryExtendController.h"
#import "ZGCategoryExtendA.h"

#pragma mark - 类拓展测试
@interface ZGCategoryExtendA ()

@property (nonatomic, strong) NSString *name;
@end


@interface ZGCategoryExtendController ()

@end

@implementation ZGCategoryExtendController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"categoryExtend";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 验证类拓展 不在所在类.m 文件时候
    // 并不能增加实例成员变量
    // 注意 #pragma mark - 类拓展测试
    [self testCategoryExtend];
}

- (void)testCategoryExtend
{
    ZGCategoryExtendA *a = [[ZGCategoryExtendA alloc] init];
    a.name = @"zong";
    
    NSLog(@"a.name %@",a.name);
    [a print];
}

@end
