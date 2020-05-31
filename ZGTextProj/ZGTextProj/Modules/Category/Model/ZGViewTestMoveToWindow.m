//
//  ZGViewTestMoveToWindow.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2020/5/31.
//  Copyright © 2020 XuZonggen. All rights reserved.
//

#import "ZGViewTestMoveToWindow.h"

@implementation ZGViewTestMoveToWindow

- (void)willMoveToWindow:(UIWindow *)newWindow
{
    NSLog(@"newWindow %@",newWindow);
}

@end
