//
//  ZGExposureCell.m
//  ZGTextProj
//
//  Created by ali on 2018/10/31.
//  Copyright © 2018 XuZonggen. All rights reserved.
//

#import "ZGExposureCell.h"
#import "ZGExposureManager.h"

NSString *const ZGExposureContentOffsetChangeNotify = @"ZGExposureContentOffsetChangeNotify";
NSString *const ZGExposureStatisticNotify = @"ZGExposureStatisticNotify";

@interface ZGExposureCell ()

@property (nonatomic, strong) UIImageView *corverImgView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ZGExposureCell

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor blueColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didContentOffsetChange:) name:ZGExposureContentOffsetChangeNotify object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didStatistics:) name:ZGExposureStatisticNotify object:nil];
        
        _corverImgView = [[UIImageView alloc] init];
        [self.contentView addSubview:_corverImgView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.corverImgView.frame = self.bounds;
    self.titleLabel.frame = self.bounds;
}

- (void)setExp_dataModel:(ZGExposureDataModel *)exp_dataModel
{
    _exp_dataModel = exp_dataModel;
    self.titleLabel.text = [NSString stringWithFormat:@"item_%zd",exp_dataModel.indexPath.item];
}

#pragma mark - - - -  -
- (void)didContentOffsetChange:(NSNotification *)note
{
    CGFloat y = [note.userInfo[@"contentOffset_y"] floatValue];
    
    CGRect scrollViewBounds = CGRectMake(0, y+64, 375, 667);
    //    NSLog(@"contentOffset_y %f",y);
//        NSLog(@"self.frame %@",NSStringFromCGRect(self.frame));
    
    __weak typeof(self) weakSelf = self;
    [self.exposureMgr zg_exposureWithDataModel:self.exp_dataModel scrollViewBounds:scrollViewBounds cellFrame:self.frame exposureBlock:^{
        // 日志打点
        NSLog(@"item %zd exposure",weakSelf.exp_dataModel.indexPath.item);
    }];
}

- (void)didStatistics:(NSNotification *)note
{
     __weak typeof(self) weakSelf = self;
    [self.exposureMgr zg_exposure_statisticWithDataModel:self.exp_dataModel exposureBlock:^{
        // 日志打点
        NSLog(@"item %zd exposure",weakSelf.exp_dataModel.indexPath.item);
    }];
}

@end
