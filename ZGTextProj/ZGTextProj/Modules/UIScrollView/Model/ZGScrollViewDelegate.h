//
//  ZGScrollViewDelegate.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/1/10.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZGSBaseScrollView.h"

@interface ZGScrollViewDelegate : NSObject <UIScrollViewDelegate>

@property (nonatomic,strong) ZGSBaseScrollView *containSV;
@property (nonatomic,assign) BOOL pageFlag;

@end
