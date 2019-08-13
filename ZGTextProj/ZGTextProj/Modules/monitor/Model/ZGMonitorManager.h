//
//  ZGMonitorManager.h
//  ZGTextProj
//
//  Created by XuZongGen on 2019/8/13.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZGMonitorManager : NSObject

- (void)startWatchAnr;
- (void)stopWatchAnr;


@end

NS_ASSUME_NONNULL_END
