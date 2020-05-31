//
//  ZGCategoryObject+Extension.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/12/28.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import "ZGCategoryObject+Extension.h"
#import <objc/runtime.h>

@implementation ZGCategoryObject (Extension)

- (NSString *)description
{
    NSLog(@"ZGCategoryObject (Extension) description");
    return [super description];
}

+ (void)initialize
{
    NSLog(@"ZGCategoryObject (Extension) initialize");
}

- (instancetype)init
{
    id obj = [super init];
    NSLog(@"ZGCategoryObject (Extension) init");
   return obj;
}

- (void)eat
{
    [super eat];
    NSLog(@"ZGCategoryObject (Extension) eat");
}

- (void)log
{
    // 调用分类覆盖的方法
    Class currentClass = [self class];
    if (currentClass) {
        unsigned int methodCount;
        Method *methodList = class_copyMethodList(currentClass, &methodCount);
        IMP lastImp = NULL;
        SEL lastSel = NULL;
        for (NSInteger i = 0; i < methodCount; i++) {
            Method method = methodList[i];
            NSString *methodName = [NSString stringWithCString:sel_getName(method_getName(method))
                                                      encoding:NSUTF8StringEncoding];
            if ([@"log" isEqualToString:methodName]) {
                lastImp = method_getImplementation(method);
                lastSel = method_getName(method);
            }
        }
        typedef void (*fn)(id,SEL);
        
        if (lastImp != NULL) {
            fn f = (fn)lastImp;
            f(self,lastSel);
        }
        free(methodList);
    }
    NSLog(@"ZGCategoryObject (Extension)  分类方法");
}

- (void)cat
{
    NSLog(@"cat");
}

@end
