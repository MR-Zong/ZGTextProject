//
//  ZGShuoUsersListView.h
//  ZGTextProj
//
//  Created by ali on 2019/2/27.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZGShuoUsersListView : UIView

@property (nonatomic, strong) NSArray *userArray;
+ (CGFloat)listViewWidthWithUsrsAry:(NSArray *)usersAry;

@end

NS_ASSUME_NONNULL_END
