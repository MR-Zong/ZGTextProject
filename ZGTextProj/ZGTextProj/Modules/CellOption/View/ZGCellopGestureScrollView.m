//
//  ZGCellopGestureScrollView.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/6/28.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGCellopGestureScrollView.h"

@implementation ZGCellopGestureScrollView


/**
 * 次优方案：限定速度，可触发cell左滑删除
 */
//- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer{
//
//
//    // 算是可行方案
//    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
//
//        CGPoint velocityPoint = [gestureRecognizer velocityInView:self];
//
//        if (fabs(velocityPoint.x) > 150) {
//
//            return YES;
//
//        }else
//
//            return NO;
//
//    }else
//
//        return NO;
//
//}


//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
//    NSLog(@"ges %@",gestureRecognizer);
//    NSLog(@"scrollView shouldBegin");
//    return YES;
//}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
////    NSLog(@"Simultaneously");
//    return YES;
//}


/**
 * 最优方案：限定区域，可触发cell左滑删除
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 打印touch到的视图
    NSLog(@"%@", NSStringFromClass([touch.view class]));

    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        
        // 如果视图为UITableViewCellContentView（即点击tableViewCell），则不截获Touch事件
        if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
            CGPoint location = [touch locationInView:touch.view];
            NSLog(@"location.x %f",location.x);
            if (location.x > [UIScreen mainScreen].bounds.size.width - 100) {
                return NO;
            }
            
            //        return NO;
        }
    }
    return  YES;
}

@end
