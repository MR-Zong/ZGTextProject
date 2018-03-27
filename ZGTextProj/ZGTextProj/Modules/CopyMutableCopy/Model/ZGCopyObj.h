//
//  ZGCopyObj.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/8/25.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZGCopySubObj : NSObject

@end

@interface ZGCopyObj : NSObject <NSCopying,NSMutableCopying>

@property (nonatomic, strong) ZGCopySubObj *subObj;
@property (nonatomic, strong) NSString *name;

@end
