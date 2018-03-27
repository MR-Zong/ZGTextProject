//
//  ZGLetterSectionModel.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/9/8.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import "ZGLetterSectionModel.h"

@implementation ZGLetterSectionModel

+ (instancetype)letterSectionWithLetter:(NSString *)letter
{
    ZGLetterSectionModel *model = [[ZGLetterSectionModel alloc] init];
    model.letter = letter;
    return model;
}

+ (instancetype)letterSectionWithLetter:(NSString *)letter string:(NSString *)string
{
    ZGLetterSectionModel *model = [[ZGLetterSectionModel alloc] init];
    model.letter = letter;
    [model.stringsArray addObject:string];
    return model;
}


- (instancetype)init
{
    if (self= [super init]) {
        _stringsArray = [NSMutableArray array];
    }
    return self;
}

@end
