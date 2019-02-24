//
//  ZGExposureCell.m
//  ZGTextProj
//
//  Created by ali on 2018/10/31.
//  Copyright © 2018 XuZonggen. All rights reserved.
//

#import "ZGExposureCell.h"
#import "ZGExposureManager.h"


@interface ZGExposureCell ()

@property (nonatomic, strong) UIImageView *corverImgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;

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
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didContentOffsetChange:) name:[ZGExposureManager zg_exposure_contentOffsetChangeNotifyNameWithUniqueID:@"ZGFontController"] object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didStatistics:) name:[ZGExposureManager zg_exposure_statisticNotifyNameWithUniqueID:@"ZGFontController"] object:nil];

        _corverImgView = [[UIImageView alloc] init];
        [self.contentView addSubview:_corverImgView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_lineView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.corverImgView.frame = self.bounds;
    self.titleLabel.frame = self.bounds;
    CGFloat lineH = 2;
    self.lineView.frame = CGRectMake(0, (self.bounds.size.height - lineH)/2.0, self.bounds.size.width, lineH);
}

- (void)setExp_dataModel:(ZGExposureDataModel *)exp_dataModel
{
    _exp_dataModel = exp_dataModel;
    self.titleLabel.text = [NSString stringWithFormat:@"item_%zd",exp_dataModel.indexPath.item];
}

#pragma mark - - - -  -
- (void)didContentOffsetChange:(NSNotification *)note
{
  
    CGRect scrollVieaawBounds = [note.userInfo[ZGExposure_scrollViewBounds_key] CGRectValue];

    //    NSLog(@"contentOffset_y %f",y);
//        NSLog(@"self.frame %@",NSStringFromCGRect(self.frame));
    
    __weak typeof(self) weakSelf = self;
    [self.exposureMgr zg_exposureWithDataModel:self.exp_dataModel scrollViewBounds:scrollVieaawBounds cellFrame:self.frame exposureBlock:^{
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
