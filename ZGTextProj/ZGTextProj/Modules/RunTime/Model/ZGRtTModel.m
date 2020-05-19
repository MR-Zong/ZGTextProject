//
//  ZGRtTModel.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2020/5/17.
//  Copyright © 2020 XuZonggen. All rights reserved.
//

#import "ZGRtTModel.h"

@implementation ZGRtTModel

- (void)dealloc
{
    NSLog(@"dealloc");
}

- (instancetype)init
{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didNote) name:@"zongNote" object:nil];
    }
    return self;
}

- (void)didNote
{
    NSLog(@"didNote");
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if (aSelector == @selector(zong:)) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSString *arg1 = nil;
    [anInvocation getArgument:&arg1 atIndex:2];
    NSLog(@"forwardInvocation arg1 %@",arg1);
    
//    [super forwardInvocation:anInvocation];
    
}

@end
