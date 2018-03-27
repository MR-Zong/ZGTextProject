//
//  ZGBaseObject.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/1/2.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZGBaseObject : NSObject

@property (nonatomic,strong) NSString *name;

@end

@interface ZGAObject : ZGBaseObject

@property (nonatomic,assign) int age;

@end


@interface ZGBObject : ZGAObject

@property (nonatomic,strong) NSString *phone;

@end
