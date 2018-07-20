//
//  ZGArchiveController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/7/20.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGArchiveController.h"
#import "ZGArchiveModelA.h"

@interface ZGArchiveController ()

@end

@implementation ZGArchiveController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"archive";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self testArchive];
}

- (void)testArchive
{
    ZGArchiveModelA *a = [[ZGArchiveModelA alloc] init];
    a.name = @"zong";
    a.age = 28;
    a.sex = @"男";
    a.isMan = YES;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentFilePath = paths.firstObject;
    NSLog(@"documentPath %@",documentFilePath);
    NSString *filePath = [documentFilePath stringByAppendingPathComponent:@"modelA"];
    
    [NSKeyedArchiver archiveRootObject:a toFile:filePath];
    
    
    ZGArchiveModelA *b = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"name %@,age %zd",b.name,b.age);
}


@end
