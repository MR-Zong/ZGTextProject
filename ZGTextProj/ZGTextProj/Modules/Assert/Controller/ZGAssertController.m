//
//  ZGAssertController.m
//  ZGTextProj
//
//  Created by ali on 2018/11/22.
//  Copyright © 2018 XuZonggen. All rights reserved.
//

#import "ZGAssertController.h"

@interface ZGAssertController ()

@end

@implementation ZGAssertController

- (void)dealloc
{
    NSLog(@"dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    [self test_assert];
    [self test_retain];
}

- (void)test_assert
{
    // 断言测试
    CGFloat itemHeight = 0;
    if (itemHeight>0) {
        NSLog(@"xxxx");
    }else {
        NSLog(@"yyyyy");
    }
    NSAssert(itemHeight>0, @"itemHeight must bigger than 0");
    assert(itemHeight>0);
}

- (void)test_retain
{
    // 断言测试
    NSAssert(YES, @"itemHeight must bigger than 0");

}

@end
