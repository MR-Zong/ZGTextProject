//
//  ZGSV1Delegate.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/1/10.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGSV1Delegate.h"

@interface ZGSV1Delegate ()


@end

@implementation ZGSV1Delegate

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint contentOffset = scrollView.contentOffset;
    //    NSLog(@"contentOffset %@",NSStringFromCGPoint(contentOffset));
    
    if (contentOffset.x > scrollView.contentSize.width -  scrollView.bounds.size.width) {
        if (self.pageFlag == NO) {
            [self.containSV scrollToPageIndex:++self.containSV.pageIndex animation:YES];
            self.pageFlag = YES;
        }
    }else if(contentOffset.x < 0){
        if (self.pageFlag == NO) {
            [self.containSV scrollToPageIndex:--self.containSV.pageIndex animation:YES];
            self.pageFlag = YES;
        }
    }else {
        self.pageFlag = NO;
    }
    
}

@end
