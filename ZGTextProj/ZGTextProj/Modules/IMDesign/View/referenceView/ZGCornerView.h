//
//  ZGCornerView.h
//  ZGTextProj
//
//  Created by ali on 2019/2/25.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZGCornerView : UIView {
    CGFloat _cornerRadius_topRight;
    CGFloat _cornerRadius_topLeft;
    CGFloat _cornerRadius_bottomRight;
    CGFloat _cornerRadius_bottomLeft;
}

@property (nonatomic, assign) CGFloat cornerRadius_topRight;
@property (nonatomic, assign) CGFloat cornerRadius_topLeft;
@property (nonatomic, assign) CGFloat cornerRadius_bottomRight;
@property (nonatomic, assign) CGFloat cornerRadius_bottomLeft;


@end

NS_ASSUME_NONNULL_END
