//
//  ZGAniTextCell.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/6/23.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZGAniTextCellModel : NSObject
@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) CGFloat textHeight;
@property (nonatomic, assign) CGFloat miniHeight;
@property (nonatomic, assign) BOOL isExtend;
@end


@interface ZGAniTextCell : UICollectionViewCell

@property (nonatomic, strong) ZGAniTextCellModel *model;

@end
