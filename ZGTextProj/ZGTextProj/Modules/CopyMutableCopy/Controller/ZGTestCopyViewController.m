//
//  ZGTestCopyViewController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/8/25.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import "ZGTestCopyViewController.h"
#import "ZGCopyObj.h"

@interface ZGTestCopyViewController ()

@property (nonatomic, strong) void (^testBlock)(void);

@end

@implementation ZGTestCopyViewController

- (void)dealloc
{
    NSLog(@"deallo");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ZGCopyObj *obj = [[ZGCopyObj alloc] init];
    obj.name = @"zong";
    ZGCopyObj *obj2 = [obj copy];
    
    
//    __block ZGTestCopyViewController *strongSelf = self;
//    self.testBlock = ^(){
//        NSLog(@"%@",strongSelf);
//        strongSelf = nil;
//    };
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSLog(@"%@",[NSThread currentThread]);
//        self.testBlock();
//    });
}


@end
