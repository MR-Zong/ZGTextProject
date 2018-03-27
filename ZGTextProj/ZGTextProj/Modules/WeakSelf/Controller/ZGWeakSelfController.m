//
//  ZGWeakSelfController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/1/18.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGWeakSelfController.h"
#import "ZGWeakSelfManager.h"

@interface ZGWeakSelfController ()

@property (nonatomic, strong) NSString *name;


@end

@implementation ZGWeakSelfController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"weakSelf";
    [self test];
}

- (void)dealloc
{
    NSLog(@"dealloc");
}

- (void)test
{
    _name = @"zongs";
    __weak ZGWeakSelfController *weakSelf = self;
//    NSLog(@"weakSelf %@",weakSelf);
    
    [ZGWeakSelfManager shareInstance].name = weakSelf.name;
    
//    ZGWeakSelfController *strongSelf = weakSelf;
//    NSLog(@"strongSelf %@",strongSelf);
//    [weakSelf doSomething];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [weakSelf doSomething];
//    });
}

- (void)doSomething
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"%@",self);
        
    });
//    NSLog(@"self %@",self);
}

@end
