//
//  ZGHeaderCollectionViewCell.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/6/21.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZGTopicHeaderView.h"

@interface ZGHeaderCollectionViewCell : UICollectionViewCell


@property (nonatomic, strong) ZGTopicHeaderView *hView;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, assign) BOOL isExtend;

@end
