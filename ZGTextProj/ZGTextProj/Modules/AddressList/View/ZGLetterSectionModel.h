//
//  ZGLetterSectionModel.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/9/8.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZGLetterSectionModel : NSObject

+ (instancetype)letterSectionWithLetter:(NSString *)letter;
+ (instancetype)letterSectionWithLetter:(NSString *)letter string:(NSString *)string;

@property (nonatomic, strong) NSMutableArray *stringsArray;
@property (nonatomic, strong) NSString *letter;

@end
