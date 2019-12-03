//
//  ZGCodeSetViewController.m
//  ZGTextProj
//
//  Created by XuZongGen on 2019/12/3.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGCodeSetViewController.h"

@interface ZGCodeSetViewController ()

@end

@implementation ZGCodeSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 查看本机是大端还是小端
    [self testNOrBig];
    
    
    // 输出二进制数据
//    [self logBytes:nil];
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

@end
