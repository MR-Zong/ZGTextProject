//
//  ZGProModelA.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/7/19.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZGProModelADelegate <NSObject>
@end

@interface ZGProModelA : NSObject

@property (nonatomic, strong) NSString *name;
- (void)printName;


@property(strong,nonatomic,readonly)NSString *address;


@property (nonatomic, weak) id <ZGProModelADelegate> delegate;

@property (nonatomic, assign) BOOL finished;


@end
