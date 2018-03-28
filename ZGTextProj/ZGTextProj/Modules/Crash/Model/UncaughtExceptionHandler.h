//
//  UncaughtExceptionHandler.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/3/28.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UncaughtExceptionHandler : NSObject{
    BOOL dismissed;
}

void HandleException(NSException *exception);
void SignalHandler(int signal);


void InstallUncaughtExceptionHandler(void); 

@end
