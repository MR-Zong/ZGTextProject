//
//  ZGFUNCDemoViewController.m
//  ZGTextProj
//
//  Created by XuZongGen on 2019/10/12.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGFUNCDemoViewController.h"

@interface ZGFUNCDemoViewController ()

@end

@implementation ZGFUNCDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    /**
     * 测试memcpy 什么情况会崩溃
     * 结论：memcpy 崩溃 只有在 来源或者目的指针 为空 拷贝数据长度不为0时候才会崩溃
     */
    [self testMemcpy];
}

- (void)testMemcpy
{
    // test
    int src[10] = {1,2,3,4,5,6,7,8,9,10};
    int *srcPtr = src;
    int dest[10];
    int *destPtr = nil;
    memcpy((int *)destPtr, (const int *)srcPtr, sizeof(int)*10);
    
    printf("dest: ");
    for (int i=0; i<10; i++) {
        printf("%d,",dest[i]);
    }
    printf("\n");
}

@end
