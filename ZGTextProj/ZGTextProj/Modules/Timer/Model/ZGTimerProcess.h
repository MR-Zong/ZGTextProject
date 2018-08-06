//
//  ZGBlockTimer.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/8/6.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ZGTimerProcessDefaultSel (@selector(ProcessTimer))

@interface ZGTimerProcess : NSObject

+ (instancetype)timerProcessWithTarget:(id)target selector:(SEL)selector;

- (void)ProcessTimer;


@end
