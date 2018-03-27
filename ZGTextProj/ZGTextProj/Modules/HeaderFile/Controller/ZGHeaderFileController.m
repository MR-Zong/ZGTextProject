//
//  ZGHeaderFileController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/1/24.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGHeaderFileController.h"
#import "ZGHFMan.h"

@interface ZGHeaderFileController ()

@end

@implementation ZGHeaderFileController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"headerFile";
    
    [self testHF];
}

- (void)testHF
{
    ZGHFMan *man = [[ZGHFMan alloc] init];
    NSLog(@"man %@",man);
    ZGHFGirl *g = [[ZGHFGirl alloc] init];
     NSLog(@"g %@",g);
}

@end
