//
//  ZGArchiveController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/7/20.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGArchiveController.h"
#import "ZGArchiveModelA.h"
#import "ZGArchiveModelB.h"

@interface ZGArchiveController ()

@end

@implementation ZGArchiveController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"archive";
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self testArchive];
    [self testArchiveMoreFile];
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

- (void)testArchiveMoreFile
{
    ZGArchiveModelA *a = [[ZGArchiveModelA alloc] init];
    a.name = @"zong";
    a.age = 28;
    a.sex = @"男";
    a.isMan = YES;
    
    ZGArchiveModelB *b = [[ZGArchiveModelB alloc] init];
    b.name = @"gen";
    b.age = 30;
    b.sex = @"女";
    b.isMan = NO;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentFilePath = paths.firstObject;
    NSLog(@"documentPath %@",documentFilePath);
    NSString *filePath = [documentFilePath stringByAppendingPathComponent:@"moreData"];
    
    
    NSMutableData *mD = [[NSMutableData alloc] init];
    NSKeyedArchiver *ar = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mD];
    [ar encodeObject:a forKey:@"zzz"];
    [ar encodeObject:b forKey:@"ggg"];
    [ar finishEncoding];
    
    [mD writeToFile:filePath atomically:YES];
    
    
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSKeyedUnarchiver *uAr = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    
    ZGArchiveModelA *aa = [uAr decodeObjectForKey:@"zzz"];
    ZGArchiveModelB *bb = [uAr decodeObjectForKey:@"ggg"];
    [uAr finishDecoding];
    
    NSLog(@"aa.name %@,age %zd",aa.name,aa.age);
    NSLog(@"bb.name %@,age %zd",bb.name,bb.age);
}


@end
