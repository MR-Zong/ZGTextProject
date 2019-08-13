//
//  ZGMonitorManager.m
//  ZGTextProj
//
//  Created by XuZongGen on 2019/8/13.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGMonitorManager.h"

float overTime = 0.07;

@interface ZGMonitorManager ()
{
    CFRunLoopObserverRef runLoopObserver;
    dispatch_semaphore_t dispatchSemaphore;
    CFRunLoopActivity runLoopActivity;
}

@property (nonatomic, assign) BOOL isStatisticsEnabled;
@property (nonatomic, assign) NSUInteger anrCount;
@end

@implementation ZGMonitorManager

- (instancetype)init
{
    if (self = [super init]) {
        _isStatisticsEnabled = YES;
    }
    return self;
}


static inline dispatch_queue_t lz_event_monitor_queue() {
    static dispatch_queue_t lz_event_monitor_queue;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        lz_event_monitor_queue = dispatch_queue_create("com.lizhi.fm.lz_event_monitor_queue", NULL);
        dispatch_set_target_queue(lz_event_monitor_queue, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    });
    return lz_event_monitor_queue;
}

static void runLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
    ZGMonitorManager *monitor = (__bridge ZGMonitorManager*)info;
    monitor->runLoopActivity = activity;
    NSLog(@"monitor activity %d",activity);
    dispatch_semaphore_t sp = monitor->dispatchSemaphore;
    if (sp) dispatch_semaphore_signal(sp);
}

- (void)startWatchAnr
{
    if (runLoopObserver) {
        return;
    }
    
    dispatchSemaphore = dispatch_semaphore_create(0);
    
    CFRunLoopObserverContext context = {0,(__bridge void*)self,NULL,NULL};
    runLoopObserver = CFRunLoopObserverCreate(kCFAllocatorDefault,
                                              kCFRunLoopAllActivities,
                                              YES,
                                              0,
                                              &runLoopObserverCallBack,
                                              &context);
    CFRunLoopAddObserver(CFRunLoopGetMain(), runLoopObserver, kCFRunLoopCommonModes);
    
    __block int timeoutCount;
    
    dispatch_async(lz_event_monitor_queue(), ^{
        while (_isStatisticsEnabled)
        {
            long semaphoreWait = dispatch_semaphore_wait(dispatchSemaphore, dispatch_time(DISPATCH_TIME_NOW, overTime*1000*NSEC_PER_MSEC));
            if (semaphoreWait != 0){
                if (!runLoopObserver) {
                    timeoutCount = 0;
                    dispatchSemaphore = 0;
                    runLoopActivity = 0;
                    return;
                }
                if (runLoopActivity == kCFRunLoopBeforeSources ||
                    runLoopActivity == kCFRunLoopAfterWaiting)
                {
                    if (++timeoutCount < _anrCount) continue;
                    [self monitorLog];
                }
            }
            timeoutCount = 0;
        }
    });
    
}

- (void)stopWatchAnr
{
    if (!runLoopObserver) {
        return;
    }
    CFRunLoopRemoveObserver(CFRunLoopGetMain(), runLoopObserver, kCFRunLoopCommonModes);
    CFRelease(runLoopObserver);
    runLoopObserver = NULL;
}

#pragma mark - log
- (void)monitorLog
{
    NSLog(@"monitor log");
}


@end
