//
//  ZGProxy.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/3/29.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGProxy.h"


@interface ZGProxy ()


@property (nonatomic, weak) id target;


@end

@implementation ZGProxy

+ (instancetype)proxyWithTarget:(id)target
{
    ZGProxy *proxy = [[self alloc] init];
    proxy.target = target;
    return proxy;
}

- (instancetype)init
{
    return self;
}

#pragma mark - NSProxy override methods
- (void)forwardInvocation:(NSInvocation *)invocation{
    //获取当前选择子
    SEL sel = invocation.selector;
//
//    //获取选择子方法名
//    NSString *methodName = NSStringFromSelector(sel);
//
//    //在字典中查找对应的target
//    id target = _methodsMap[methodName];
    
    //检查target
    if (self.target && [self.target respondsToSelector:sel]) {
        [invocation invokeWithTarget:self.target];
    } else {
        NSMethodSignature *ms = [NSMethodSignature signatureWithObjCTypes:"v@:v"];
        NSInvocation *ink = [NSInvocation invocationWithMethodSignature:ms];
        ink.selector = @selector(zg_doesNotRecognizeSelector);
        [ink invokeWithTarget:self];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
//    //获取选择子方法名
//    NSString *methodName = NSStringFromSelector(sel);
//
//    //在字典中查找对应的target
//    id target = _methodsMap[methodName];
    
    //检查target
    if (self.target && [self.target respondsToSelector:sel]) {
        return [self.target methodSignatureForSelector:sel];
    } else {
        
         /** v@:@
          * v 返回值类型void;
          * @ id类型,执行sel的对象;
          * ：分隔符 ，分隔执行sel的对象 与 参数
          * @ 参数
          */
        NSMethodSignature *ms = [NSMethodSignature signatureWithObjCTypes:"v@:v"];
        return  ms;
    }
}

- (void)zg_doesNotRecognizeSelector
{
    NSLog(@"ZGProxy doesNotRecognizeSelector");
}

@end
