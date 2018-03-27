//
//  ZGOScrollManager.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/1/11.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGOScrollManager.h"
#import "ZGOHeaderScrollView.h"

@implementation ZGOScrollManager

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
//    NSLog(@"index %zd",index);
    
    [self.headerSV pageToIndex:index contentOffset:scrollView.contentOffset];
}

@end
