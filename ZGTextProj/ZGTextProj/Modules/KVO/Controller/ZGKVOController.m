//
//  ZGKVOController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/2/1.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGKVOController.h"
#import "ZGKVODataModel.h"
#import "ZGKVOObserverA.h"
#import "ZGKVOObserverB.h"

#import "ZGKVOResearchData.h"
#import "ZGKVOResearchObserverA.h"
#import "ZGKVOResearchObserverB.h"

#import <objc/runtime.h>

#import "ZGKVOCDataModel.h"
#import "ZGKVOCBaseOberver.h"
#import "ZGKVOCSubObserver.h"

#import "ZGKVOODataModel.h"
#import "ZGKVOOObserverA.h"
#import "ZGKVOOObserverB.h"


@interface ZGKVOController ()

@property (nonatomic, strong) ZGKVODataModel *dataModel;
@property (nonatomic, strong) ZGKVOObserverA *a;
@property (nonatomic, strong) ZGKVOObserverB *b;

// research
@property (nonatomic, strong) ZGKVOResearchData *rsDataModel;
@property (nonatomic, strong) ZGKVOResearchObserverA *rsA;
@property (nonatomic, strong) ZGKVOResearchObserverB *rsB;

// context
@property (nonatomic, strong) ZGKVOCDataModel *cDataModel;
@property (nonatomic, strong) ZGKVOCBaseOberver *cBase;
@property (nonatomic, strong) ZGKVOCSubObserver *cSub;

// observationInfo
@property (nonatomic, strong) ZGKVOODataModel *oDataModel;
@property (nonatomic, strong) ZGKVOOObserverA *oA;
@property (nonatomic, strong) ZGKVOOObserverB *oB;

@end

@implementation ZGKVOController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"KVO";
    
    
    /**
     * 数组removeObject 不在数组的对象不会崩溃
     */
//    NSMutableArray *mAry = [NSMutableArray arrayWithCapacity:3];
//    [mAry addObject:@8];
//    [mAry removeObject:@9];
    
    /**
     1，  经过测试 KVO 和通知一样 默认是同步的！！！  不会自己开线程！！
     2，changeValue后，会挨个一次 执行 监听通知的对象的selector ，顺序是 先进后出（与通知相反），就是先监听的对象的selector  反而会后面执行
     3，在哪个线程 changeValue  就在哪个线程 执行 监听对象的 selector（第2点依然适用）
     4，千万注意 changeValue 和 监听对象的selector是同一个线程的 （多写一次以重视）
     */
//    [self testKVO];
    
    
    /**
     * 深入研究KVO ：KVO 观察者 是否 在被观察者的数组保存？
     * 证明NSKVONotifying_xx 类并不会新增实例变量，也不能新增实例变量，因为他的实例已经形成
     * 保存被观察者的数组其实在observerinfo 里
     */
//    [self researchKVO];
    
    /**
     * 深入研究KVO ：关联key   keyPathsForValuesAffectingValueForKey
     */
//    [self researchKVOKeyPathAffecting];
    
    /**
     * 深入研究KOV -- observationInfo 参数 意义
     * 可以重写observationInfo 的getter  setter方法把，observationInfo实例放到当前实例
     * 的某个实例变量里
     */
    [self kvo_observationInfo];

    
    /**
     * 深入研究KOV -- context 参数 意义
     */
//    [self kvo_context];

    
    
}

- (void)testKVO
{
    _dataModel = [[ZGKVODataModel alloc] init];
    
    _a = [[ZGKVOObserverA alloc] init];
    [_a kvoObject:_dataModel];
    
    _b = [[ZGKVOObserverB alloc] init];
    [_b kvoObject:_dataModel];
    
    
    [_dataModel changeValue];
    NSLog(@"KVO changeValue");
}

- (void)researchKVO
{
    _rsDataModel = [[ZGKVOResearchData alloc] init];
    
    _rsA = [[ZGKVOResearchObserverA alloc] init];
    _rsA.target = _rsDataModel;
    
    _rsB = [[ZGKVOResearchObserverB alloc] init];
    _rsB.target = _rsDataModel;
    
    [_rsDataModel addObserver:_rsA forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    [_rsDataModel addObserver:_rsB forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    
    
    unsigned int ivarCount = 0;
    NSLog(@"getClass %@",object_getClass(_rsDataModel));
    NSLog(@"class %@",[_rsDataModel class]);
    id classObj = object_getClass(_rsDataModel);
    Ivar *ivarList = class_copyIvarList(classObj, &ivarCount);
    for (int i=0; i<ivarCount; i++) {
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivarList[i])];
        NSLog(@"ivarName %@",ivarName);
    }
}

- (void)researchKVOKeyPathAffecting
{
    _rsDataModel = [[ZGKVOResearchData alloc] init];
    
    _rsA = [[ZGKVOResearchObserverA alloc] init];
    _rsA.target = _rsDataModel;
    
    [_rsDataModel addObserver:_rsA forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    
    _rsDataModel.name = @"a";
    _rsDataModel.address = @"japan";
}

- (void)kvo_context
{
    _cDataModel = [[ZGKVOCDataModel alloc] init];
    
    _cBase = [[ZGKVOCBaseOberver alloc] initWithTarget:_cDataModel];
//    _cBase = [[ZGKVOCBaseOberver alloc] init];
//    _cBase.target = _cDataModel;
//    [_cDataModel addObserver:_cBase forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:ZGKVOCBaseOberverContext];
    
    NSLog(@"baseContext %p",ZGKVOCBaseOberverContext);
    NSLog(@"baseContext value %lx",*(NSUInteger *)ZGKVOCBaseOberverContext);
    
    _cSub = [[ZGKVOCSubObserver alloc] initWithTarget:_cDataModel];
//    _cSub = [[ZGKVOCSubObserver alloc] init];
//    _cSub.target = _cDataModel;
//      [_cDataModel addObserver:_cSub forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:ZGKVOCSubObserverContext];
    
    _cDataModel.name = @"Z";
    
//    [_cSub changName];
}

- (void)kvo_observationInfo
{
    _oDataModel = [[ZGKVOODataModel alloc] init];
    
    _oA = [[ZGKVOOObserverA alloc] init];
    _oA.target = _oDataModel;
    [_oDataModel addObserver:_oA forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    [_oDataModel addObserver:_oA forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    
    NSLog(@"observationInfo %@",_oDataModel.observationInfo);
    // 此句，为xcode 查看数据结果
    id obserInfoObj = _oDataModel.observationInfo;
    NSArray *observaArray = [(NSObject *)_oDataModel.observationInfo valueForKey:@"_observances"];
    for (id obser in observaArray) {
        NSLog(@"obser %@",obser);
    }
    
//    _oB = [[ZGKVOOObserverB alloc] init];
//    _oB.target = _oDataModel;
//    [_oDataModel addObserver:_oB forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    
    _oDataModel.name = @"Z";
}


@end
