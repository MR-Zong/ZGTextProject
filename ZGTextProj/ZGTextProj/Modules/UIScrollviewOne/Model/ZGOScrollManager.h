//
//  ZGOScrollManager.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/1/11.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZGOHeaderScrollView;

@interface ZGOScrollManager : NSObject <UIScrollViewDelegate>

@property (nonatomic,strong) ZGOHeaderScrollView *headerSV;

@end
