//
//  ZGHotFixController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/8/10.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGHotFixController.h"

@interface ZGHotFixController ()

@end

@implementation ZGHotFixController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /**
     * 测试 for in 对字典遍历
     */
    [self testDictionary];
}

- (void)testDictionary
{
    NSDictionary *dic = @{@"a":@"aaa",@"b":@"bbb",@"c":@"ccc"};
    /**
     * 可以直接 for in 字典 的key
     */
    for (NSString *key in dic) {
        NSLog(@"key %@",key);
    }
}


@end
