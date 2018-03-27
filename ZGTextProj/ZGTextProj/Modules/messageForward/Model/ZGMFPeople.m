//
//  ZGMFPeople.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/1/28.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGMFPeople.h"
#import <objc/runtime.h>

@interface ZGMFPeople ()
@end


@implementation ZGMFPeople

@dynamic name;

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    NSString *selectorStr = NSStringFromSelector(sel);
    if ([selectorStr isEqualToString:@"name"]) {
        class_addMethod([self class], sel, (IMP)c_name, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

void c_name(id self,SEL selector){
    NSLog(@"zong");
}

@end
