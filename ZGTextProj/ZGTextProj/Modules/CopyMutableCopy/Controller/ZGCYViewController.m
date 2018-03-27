//
//  ZGCYViewController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/2/2.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGCYViewController.h"
#import "ZGCopyObj.h"

@interface ZGCYViewController ()

@end

@implementation ZGCYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"copy测试";
    
//    [self testObjCopy];
    [self testSetCopy];
}

// 对非集合类
- (void)testObjCopy
{
    NSLog(@"********Copy*************");
    // 不可变 对象的copy
    NSString *str = @"zong";
    NSString *copyStr = [str copy];
    NSLog(@"str %p,copyStr %p",str,copyStr);
    NSLog(@"str %@\tcopyStr %@",[str class],[copyStr class]);
    
    NSLog(@"\n");
    
    // 可变对象的copy
    NSMutableString *mStr = [[NSMutableString alloc] initWithString:@"gen"];
    NSString *cymStr = [mStr copy];
    NSLog(@"mStr %p,cymStr %p",mStr,cymStr);
    NSLog(@"mStr %@\tcymStr %@",[mStr class],[cymStr class]);
    
    ///////////////////////////////////////
    NSLog(@"\n");
    NSLog(@"\n");
    NSLog(@"\n");
    NSLog(@"********mutableCopy*************");
    // 不可变 对象的mutableCopy
    NSString *str2 = @"zong";
    NSMutableString *copyStr2 = [str2 mutableCopy];
    NSLog(@"str2 %p,mcopyStr2 %p",str2,copyStr2);
    NSLog(@"str2 %@\tmcopyStr2 %@",[str2 class],[copyStr2 class]);
    
    NSLog(@"\n");
    
    // 可变对象的mutableCopy
    NSMutableString *mStr2 = [[NSMutableString alloc] initWithString:@"gen"];
    NSMutableString *mcymStr2 = [mStr2 mutableCopy];
    NSLog(@"mStr2 %p,mcymStr2 %p",mStr2,mcymStr2);
    NSLog(@"mStr2 %@\tmcymStr2 %@",[mStr2 class],[mcymStr2 class]);
}

// 对集合类
- (void)testSetCopy
{
    NSLog(@"********Copy*************");
    // 不可变 对象的copy
    ZGCopyObj *zcObj = [[ZGCopyObj alloc] init];
    NSString *str = @"zong";
    NSMutableString *mStr = [[NSMutableString alloc] initWithString:@"gen"];
    NSArray *ary = @[str,mStr,zcObj];
    NSArray *copyAry = [ary copy];
    NSLog(@"ary %p,copyAry %p",ary,copyAry);
    NSLog(@"ary %@\t copyAry %@",[ary class],[copyAry class]);
    for (NSString *s in ary) {
        NSLog(@"aryElement :%@  %p",[s class],s);
    }
    
    for (NSString *s in copyAry) {
        NSLog(@"copyAryElement :%@  %p",[s class],s);
    }

    
    NSLog(@"\n");
    
    // 可变对象的copy
    NSMutableArray *mAry = [[NSMutableArray alloc] initWithObjects:str,mStr,zcObj, nil];
    NSArray *cymAry = [mAry copy];
    NSLog(@"mAry %p,cymAry %p",mAry,cymAry);
    NSLog(@"mArytr %@\t cymAry %@",[mAry class],[cymAry class]);
    
    for (NSString *s in mAry) {
        NSLog(@"mAryElement :%@  %p",[s class],s);
    }
    
    for (NSString *s in cymAry) {
        NSLog(@"cymAryElement :%@  %p",[s class],s);
    }
    
    ///////////////////////////////////////
    NSLog(@"\n");
    NSLog(@"\n");
    NSLog(@"\n");
    NSLog(@"********mutableCopy*************");

    // 不可变 对象的mutableCopy
    NSArray *ary2 = @[str,mStr,zcObj];
    NSMutableArray *copyAry2 = [ary2 mutableCopy];
    NSLog(@"ary2 %p,copyAry2 %p",ary2,copyAry2);
    NSLog(@"ary2 %@\t copyAry2 %@",[ary2 class],[copyAry2 class]);
    for (NSString *s in ary2) {
        NSLog(@"ary2Element :%@  %p",[s class],s);
    }
    
    for (NSString *s in copyAry2) {
        NSLog(@"copyAry2Element :%@  %p",[s class],s);
    }
    
    NSLog(@"\n");
    
    // 可变对象的mutableCopy
    NSMutableArray *mAry2 = [[NSMutableArray alloc] initWithObjects:str,mStr,zcObj, nil];
    NSMutableArray *cymAry2 = [mAry2 mutableCopy];
    NSLog(@"mAry2 %p,cymAry2 %p",mAry2,cymAry2);
    NSLog(@"mAry2 %@\t cymAry2 %@",[mAry2 class],[cymAry2 class]);
    for (NSString *s in mAry2) {
        NSLog(@"mAry2Element :%@  %p",[s class],s);
    }
    
    for (NSString *s in cymAry2) {
        NSLog(@"cymAry2Element :%@  %p",[s class],s);
    }
}

@end
