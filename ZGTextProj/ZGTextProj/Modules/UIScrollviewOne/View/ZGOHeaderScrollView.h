//
//  ZGOHeaderScrollView.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/1/11.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZGOHeaderScrollView : UIScrollView

@property (nonatomic,assign) NSInteger tabCount;

- (void)pageToIndex:(NSInteger)index contentOffset:(CGPoint)contentOffset;

@end
