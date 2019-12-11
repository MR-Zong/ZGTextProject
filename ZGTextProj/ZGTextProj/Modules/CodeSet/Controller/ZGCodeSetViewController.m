//
//  ZGCodeSetViewController.m
//  ZGTextProj
//
//  Created by XuZongGen on 2019/12/3.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGCodeSetViewController.h"
#import "NSArray+ZGCrash.h"

@interface ZGCodeSetViewController ()

@end

@implementation ZGCodeSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 查看本机是大端还是小端
//    [self testNOrBig];
    
    
    // 输出二进制数据
//    [self logBytes:nil];
    
    // 测试NSArray 防止越界崩溃
    [self testBeyondCrash];
}

- (void)testNOrBig
{
    short int x;
    char x0,x1;
    x=0x1122;
    x0=((char*)&x)[0]; //低地址单元
    x1=((char*)&x)[1]; //高地址单元
    
    if (x0 == 0x11) {
        NSLog(@"xiaogen 大端");
    }
    else if (x0==0x22)
    {
        NSLog(@"xiaogen 小端");
    }
}

// 转换成小端，本质内存的移动
void convertToLittleEndian(unsigned int *data, int len)
{
    for (int index = 0; index < len; index ++) {
        
        *data = ((*data & 0xff000000) >> 24)
        | ((*data & 0x00ff0000) >>  8)
        | ((*data & 0x0000ff00) <<  8)
        | ((*data & 0x000000ff) << 24);
        
        data ++;
    }
}


- (void)logBytes:(void *)bytes
{
    int j = 0;
    char *p = (char *)bytes;
    printf("xiaogen ");
    while (j<80) {
        printf("%02x ",*p);
        if (j>0 && (j+1)%16==0) {
            printf("\n");
            printf("xiaogen ");
        }
        p++;
        j++;
    }
    printf("\n");
}

#pragma mark - 测试NSArray 防止越界崩溃
- (void)testBeyondCrash
{
    NSArray *itemAry1 = @[@1,@2];
    NSArray *itemAry2 = @[@3,@4];
    NSArray *arys = @[itemAry1,itemAry2];
    
    NSLog(@"test begin");
    // 这样会调用两次 safeobjectAtIndexedSubscript
    int value = arys[0][1];
    NSLog(@"test end");
    
}

@end
