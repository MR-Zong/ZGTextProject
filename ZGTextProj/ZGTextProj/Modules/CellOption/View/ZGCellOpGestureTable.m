//
//  ZGCellOpGestureTable.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/6/28.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGCellOpGestureTable.h"

@implementation ZGCellOpGestureTable

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"table shouldBegin");
    return YES;
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    NSLog(@"Simultaneously");
//    return YES;
//}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    // 打印touch到的视图
//    NSLog(@"%@", NSStringFromClass([touch.view class]));
//    
//    // 如果视图为UITableViewCellContentView（即点击tableViewCell），则不截获Touch事件
//    //    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
//    //        return NO;
//    //    }
//    return  YES;
//}


@end
