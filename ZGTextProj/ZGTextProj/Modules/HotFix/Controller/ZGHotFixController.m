//
//  ZGHotFixController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/8/10.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGHotFixController.h"
#import "ZGDicCopyModel.h"
#import "ZGWeakMutableDictionary.h"

@interface ZGHotFixController ()

@end

@implementation ZGHotFixController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /**
     * 测试 for in 对字典遍历
     */
//    [self testDictionary];
    
    /**
     * 测试 字典对value的强引用
     */
//    [self testDictionaryStrog];

    
    /**
     * 测试 自定义weak字典对value的弱引用
     */
//    [self testDictionaryWeakValue];

    
    /**
     * 测试 NSPointerArray
     */
    [self testPointArray];
    
    /**
     * 测试 NSHashTable
     */
//    [self testHashTable];


}

- (void)testDictionary
{
    NSDictionary *dic = @{@"a":@"aaa",@"b":@"bbb",@"c":@"ccc"};
    /**
     * 可以直接 for in 字典 的key
     */
    for (NSString *key in dic) {
        NSLog(@"key %@",key);
    }
}

- (void)testDictionaryStrog
{
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    
    NSObject *a = [[NSObject alloc] init];
    /**
     * 证明weak 对字典是无效的
     */
    __weak typeof(a) weakA = a;
    [mDic setObject:weakA forKey:@"a"];
    
    NSLog(@"a %@",a);
    a = nil;
    NSLog(@"dicA %@",mDic[@"a"]);
    
}

- (void)testDictionaryWeakValue
{
    ZGWeakMutableDictionary *mDic = [ZGWeakMutableDictionary dictionary];
    
    NSObject *a = [[NSObject alloc] init];
    [mDic setObject:a forKey:@"a"];
    
    NSLog(@"a %@",a);
    a = nil;
    NSLog(@"dicA %@",[mDic objectForKey:@"a"]);
}

- (void)testPointArray
{
    ;
}


@end
