//
//  ZGIMMessage.h
//  ZGTextProj
//
//  Created by ali on 2019/1/24.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZGIMMessage : NSObject

@property (nonatomic, assign) NSInteger messageType;
@property (nonatomic, strong) NSString *content;

@end

NS_ASSUME_NONNULL_END
