//
//  ZGNestBController.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/6/26.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZGNestSubScrollView.h"
#import "ZGNestPageDController.h"

@class ZGNestScrollView;

@interface ZGNestPageBController : UIViewController

@property (nonatomic, strong) ZGNestSubScrollView *scrollView;
@property (nonatomic, weak) ZGNestScrollView *nestScrollView;


@end
