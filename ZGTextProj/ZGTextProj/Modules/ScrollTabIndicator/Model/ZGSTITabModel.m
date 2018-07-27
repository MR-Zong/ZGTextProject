//
//  ZGSTITabModel.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/7/27.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGSTITabModel.h"

@implementation ZGSTITabModel

+ (instancetype)tabItemWithViewController:(ZGSTIBaseController *)vc
{
    ZGSTITabModel *tabItem = [[ZGSTITabModel alloc] init];
    tabItem.vc = vc;
    return tabItem;
}

@end
