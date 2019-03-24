//
//  ZGPCopyModel.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2019/3/24.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZGPCopyModelPy : NSObject <NSCopying>

@property (nonatomic, copy) NSString *name;
@end

@interface ZGPCopyModel : NSObject

@property (nonatomic, copy) ZGPCopyModelPy *py;
@end

NS_ASSUME_NONNULL_END
