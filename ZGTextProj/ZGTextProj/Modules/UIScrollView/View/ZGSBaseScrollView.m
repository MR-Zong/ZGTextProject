//
//  ZGSBaseScrollView.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/1/10.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGSBaseScrollView.h"

@implementation ZGSBaseScrollView

- (void)scrollToPageIndex:(NSInteger)pageIndex animation:(BOOL)animation
{
    if (pageIndex<0) {
        return;
    }
    
    if (pageIndex>self.pageCount - 1) {
        return;
    }

    // page animation
    CGPoint targetPoint = CGPointMake(pageIndex*self.bounds.size.width, 0);
    [self setContentOffset:targetPoint animated:YES];
}




#pragma mark - UIGestureRecognizerDelegate
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
//    return YES;
//}
//
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    //    NSLog(@"%@,%@",gestureRecognizer,otherGestureRecognizer);
//    
//    
//    return NO;
//}
//
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
////    NSLog(@"%@",otherGestureRecognizer);
//    NSLog(@"containSV");
//    if (gestureRecognizer.view == self) {
////        NSLog(@"self");
//        return YES;
//    }
//    return NO;
//}
//
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    return YES;
//}

@end
