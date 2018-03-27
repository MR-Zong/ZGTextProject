//
//  ZGCategoryController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/12/28.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import "ZGCategoryController.h"
#import "ZGCategoryObject.h"
#import <objc/runtime.h>
#import "ZGCategoryObject+Extension.h"

@interface ZGCategoryController ()

@end

@implementation ZGCategoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZGCategoryObject *cObj = [[ZGCategoryObject alloc] init];
    [cObj log];
    [cObj cat];
    
//    unsigned int count = 0;
//    Method *methodList = class_copyMethodList([ZGCategoryObject class], &count);
//    Method *methodHeader = methodList;
//    while (count--) {
//        Method method = *methodHeader;
//        SEL selector = method_getName(method);
//        NSLog(@"sel: %@", NSStringFromSelector(selector));
//
//        methodHeader++;
//    }
//    free(methodList);

}


@end
