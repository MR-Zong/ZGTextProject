//
//  ZGWaterWaveView.h
//  ZGTextProj
//
//  Created by ali on 2019/3/17.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZGWaterWaveView : UIView

@property (nonatomic, strong) UIColor *firstWaveColor;
@property (nonatomic, strong) UIColor *secondWaveColor;

-(void)startWave;

@end

NS_ASSUME_NONNULL_END
