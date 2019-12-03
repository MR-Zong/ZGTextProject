//
//  ZGFUNCDemoViewController.m
//  ZGTextProj
//
//  Created by XuZongGen on 2019/10/12.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGFUNCDemoViewController.h"
#import "ZGReferenceTestModel.h"

@interface ZGFUNCDemoViewController ()

@end

@implementation ZGFUNCDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];\


    /**
     * 测试memcpy 什么情况会崩溃
     * 结论：memcpy 崩溃 只有在 来源或者目的指针 为空 拷贝数据长度不为0时候才会崩溃
     */
//    [self testMemcpy];
    
    /**
     *  探究selector 本质到底是什么？
     *   typedef struct objc_selector *SEL;   struct objc_selector 到底是什么类型
     */
//    [self discoverSelector];
    
    
    // 测试URL
    NSString *urlString = @"http://cdn01.lizhi.fm/";
    NSURL *url = [NSURL URLWithString:urlString];
    NSString *formatSchemeAndHost = [NSString stringWithFormat:@"%@://%@",url.scheme,url.host];
    NSLog(@"formatSchemeAndHost %@",formatSchemeAndHost);
    
    // 证明：NULL->age 会崩溃 用->的时候要小心必须保证调用者不为NULL
    ZGReferenceTestModel *model = [ZGReferenceTestModel new];
    model.name = @"gen";
    model->age = 19;
    NSLog(@"name %@",model.name);
    NSLog(@"age %lld",model->age);
    model = nil;
    if (!model) {  // 用->的时候要小心必须保证调用者不为NULL
        return;
    }
    NSLog(@"nil age %lld",model->age);
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


#pragma mark - SEL 研究
struct zongSelctor {
    char sel[100];
    int size;
};

typedef struct zongSelctor * ZSEL;

- (void)discoverSelector
{
    /**
     * 我懂了，就是 struct objc_selector 随便定义个类型就可以了，定义什么无所谓
     * struct objc_selector * 最终都会是 指针类型
     * 假设：struct objc_selector *zong，最重要的其实是真的赋值给zong的值是什么
     * struct objc_selector *只是为了隐藏原来的实际指针类型而已
     *
     * 要把一个struct objc_selector * 强转成 const char* 并能成功打印出来字符串，只有两种可能
     * 1，struct objc_selector *  就是 const char *
     * 2，结构体定义为
     *    struct objc_selector {
     *           char sel[100],
     *    }
     * 但 第2种是不可行的，因为你不知道 实际放进来的字符串是多长
     * 综上，只有第1中方法，才是实际可行的
     * 由此证明：struct objc_selector * 就是 const char*
     */
//     Class
    SEL as = @selector(discoverSelector);
    const char *ss = (const char *)as;
    NSLog(@"ss %s",ss);
    
    const char *z = "zong";
    ZSEL bs = z;
    const char *bss = (const char *)bs;
    NSLog(@"bss %s",bss);
    
    struct zongSelctor cs = {"zong",8};
    ZSEL css = &cs;
    const char *cd = (const char *)css;
    NSLog(@"cd %s",cd);
}

@end
