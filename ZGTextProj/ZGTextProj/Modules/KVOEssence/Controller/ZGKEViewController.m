//
//  ZGKEViewController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/2/2.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGKEViewController.h"
#import "ZGKEDataModel.h"
#import "ZGKEObserverA.h"

@interface ZGKEViewController ()

@property (nonatomic, strong) ZGKEDataModel *dataModel;
@property (nonatomic, strong) ZGKEObserverA *a;

@end

@implementation ZGKEViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"KVO本质研究";
    
    // kvo 是基于 isa 动态 swizzling实现的
    [self testKVOEssence];
}

- (void)testKVOEssence
{
    _dataModel = [[ZGKEDataModel alloc] init];
    NSLog(@"_dataModel.class %@",_dataModel.class);
    
    _a = [[ZGKEObserverA alloc] init];
    [_a kvoTarget:_dataModel];
    
    /** 特别注意！！
     * 1，此时 因为class superClass 方法也被 KVO 动态类改写了，所以直接NSLOG class 是不会看出异常的
     * 2，要在KVO后 断点，lldb 如下：
     
     (lldb) p _dataModel
     (ZGKEDataModel *) $0 = 0x000060000020a4f0
     (lldb) p _dataModel->isa
     (Class) $1 = NSKVONotifying_ZGKEDataModel
     (lldb)
      就能看到 isa 指向的类 已经被改变了
     
     */
     NSLog(@"After KVO _dataModel.class %@",_dataModel.class);
    NSLog(@"After KVO _dataModel.superClass %@",_dataModel.superclass);
    
    
}

@end
