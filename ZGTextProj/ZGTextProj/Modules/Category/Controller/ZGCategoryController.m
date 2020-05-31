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
#import "ZGViewTestMoveToWindow.h"

@interface ZGCategoryController ()

@property (nonatomic, strong) ZGViewTestMoveToWindow *v;

@end

@implementation ZGCategoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    _v = [[ZGViewTestMoveToWindow alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    _v.backgroundColor = [UIColor redColor];
    [self.view addSubview:_v];
    
//    [v removeFromSuperview];
    
    ZGCategoryObject *cObj = [[ZGCategoryObject alloc] init];
//    [cObj log];
//    [cObj cat];
    [cObj eat];
    
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.v removeFromSuperview];
}


@end
