//
//  ZGProModelB.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/7/19.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGProModelA.h"

@protocol ZGProModelBDelegate <NSObject>
@end

@interface ZGProModelB : ZGProModelA

@property (nonatomic, strong) NSString *name;
//@property(strong,nonatomic,readwrite)NSString *address;
//
//
//@property (nonatomic, weak) id <ZGProModelBDelegate,ZGProModelADelegate> delegate;

@end
