//
//  ZGChineseDate.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/9/10.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZGChineseDate : NSObject

+ (instancetype)dateWithYear:(NSString *)year month:(NSString *)month day:(NSString *)day components:(NSDateComponents *)components;

@property (nonatomic, strong) NSString *year;
@property (nonatomic, strong) NSString *month;
@property (nonatomic, strong) NSString *day;

@property (nonatomic, assign) NSInteger yearI;
@property (nonatomic, assign) NSInteger monthI;
@property (nonatomic, assign) NSInteger dayI;

@end
