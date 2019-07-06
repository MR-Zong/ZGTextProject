//
//  ZGPropertyController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/7/19.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGPropertyController.h"
#import "ZGProModelA.h"
#import "ZGProModelB.h"
#import "ZGPAUTModelA.h"

#import "ZGPEteModelA.h"
#import "ZGPSHIModelA.h"
#import "ZGPCopyModel.h"
#import "ZGPropertyAssociation.h"

/**
 * 匿名分类 不在.m模块里 也不能定义实例变量 效果和不是匿名分类一个效果
 */
@interface ZGPEteModelA ()

@property (nonatomic, strong) NSString *address;

@end

#pragma mark - - - - - -  - -  - -  -
@interface ZGPropertyController ()

@end

@implementation ZGPropertyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"property";
    
    
    /**
     * 测试 property 与 实例变量的关联
     */
    //    [self testProperty2];
    
    /** 测试 @synthesize
     */
//    [self testProperty];
    
    /** 测试 automic,，原子性 只能是对get set 方法的原子性
     * 不能对直接访问实例成员变量，或者 改变成员变量的属性原子性
     */
//    [self testAutomic];
    
    
    /**
     * 测试通知
     */
//    [self testNotify];
    
    /**
     * 测试runloop
     * 结论：实践证明 runloop唤醒后 一定会先执行完 睡眠前未执行完的任务，然后再执行唤醒runloop的
     * timer dispatch_asyn source1 的对应回调
     */
    [self testRunLoop];
    
    
    /**
     * 测试匿名拓展 是第一次的才有用，还是在.m模块内的都有用
     */
//    [self testExtend];
    
    /**
     * 测试单例 限制 init new方法
     * NS_UNAVAILABLE 非常完美的实现了
     */
//    [self testShareInstance];
    
    /**
     * 测试
     * Property 默认都是什么修饰
     */
//        [self testDefaultProperty];
    
    /**
     * 测试
     * Property copy修饰的话，get方法是否有copy
     */
//    [self testPropertyCopy];
    
    
    
    
}

- (void)testProperty2
{
    ZGPropertyAssociation *mm = [ZGPropertyAssociation new];
    mm.name = @"gen";
    NSLog(@"name %@,setupSeekTime %f",mm.name,mm.setupSeekTime);
}

- (void)testProperty
{
    ZGProModelA *a = [[ZGProModelA alloc] init];
    a.name = @"中国";
    a.finished = YES;
    [a printName];
    
    ZGProModelB *b = [[ZGProModelB alloc] init];
    b.name = @"日本";
    b.finished = YES;
    NSLog(@"b.finished %zd",b.finished);
}

- (void)testAutomic
{
    ZGPAUTModelA *a = [[ZGPAUTModelA alloc] init];


    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);

    dispatch_async(queue, ^{

    });
}

#pragma mark - test notify
- (void)testNotify
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didNote) name:@"abc" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didNote) name:@"abc" object:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"abc" object:nil];
}

- (void)didNote
{
    NSLog(@"didNote");
}


#pragma mark - testRunLoop
- (void)testRunLoop
{
    [self rlTimer];
    
    [self afterRlTimer];
}

- (void)rlTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(didTimer) userInfo:nil repeats:NO];
    NSTimer *timer1 = [NSTimer scheduledTimerWithTimeInterval:7 target:self selector:@selector(didTimer1) userInfo:nil repeats:NO];
    [self testRlB];
    [self testRlC];
    //    [self testRlC];[self testRlC];[self testRlC];[self testRlC];[self testRlC];

}

- (void)afterRlTimer
{
    NSLog(@"afterRlTimer");
}

- (void)didTimer
{
    NSLog(@"timerA");
}
- (void)didTimer1
{
    NSLog(@"timerA111");
}

- (void)testRlB
{
    NSLog(@"testRlB");
    [NSThread sleepForTimeInterval:10];
}

- (void)testRlC
{
    NSLog(@"testRlC");
    [NSThread sleepForTimeInterval:6];
}


#pragma mark - test extend
- (void)testExtend
{
    ZGPEteModelA *a = [[ZGPEteModelA alloc] init];
    
    /**
     * 匿名分类在 类定义.m 外，和其他分类效果一样，没有合成get set方法和实例变量
     */
//    a.address = @"dabu";
//    NSLog(@"a.address %@",a);
    
    [a print];
}

#pragma mark - 测试单例 限制 init new
- (void)testShareInstance
{
    /**
     * 编译器会报错，非常完美！！！
     */
//    ZGPSHIModelA *a = [[ZGPSHIModelA alloc] init];
//    ZGPSHIModelA *b = [ZGPSHIModelA new];
}

#pragma mark - testDefaultProperty
- (void)testDefaultProperty
{
    /**
     *  证明 内存管理 默认，基本数据类型是assgin 对象类型是strong
     *  读写修饰，默认  可读可写
     */
    ZGPEteModelA *t = [[ZGPEteModelA alloc] init];
    ZGPSHIModelA *a = [ZGPSHIModelA shareInstance];
    a.name = t;
    NSLog(@"a.name %@",a.name);
    t = nil;
    NSLog(@"s %@",t);
    NSLog(@"a.name %@",a.name);
}

#pragma mark - testPropertyCopy
- (void)testPropertyCopy
{
    /**
     *  证明 copy 只有set方法才会copy get是不会copy的
     */
    ZGPCopyModel *md = [[ZGPCopyModel alloc] init];
    md.py = [ZGPCopyModelPy new];
    
    NSLog(@"md.py %@",md.py);
}

@end
