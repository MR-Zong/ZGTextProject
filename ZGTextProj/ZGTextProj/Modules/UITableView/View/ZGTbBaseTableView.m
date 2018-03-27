//
//  ZGTbBaseTableView.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/1/5.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGTbBaseTableView.h"

@interface ZGTbBaseTableView () <ZGNoDataViewDelegate>

@end

@implementation ZGTbBaseTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _noDataView = [[ZGNoDataView alloc] init];
        _noDataView.hidden = YES;
        _noDataView.delegate = self;
        [self addSubview:_noDataView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat noDataViewWidth = 260;
    CGFloat noDataViewHeight = 260;
     self.noDataView.frame = CGRectMake((self.bounds.size.width - noDataViewWidth) / 2.0, (self.bounds.size.height - noDataViewHeight) / 2.0, noDataViewWidth, noDataViewHeight);
}

#pragma mark - ZGNoDataViewDelegate
- (void)noDataViewDidTap:(ZGNoDataView *)noDataView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(zgTableViewDidTouchNoDataView:)]) {
        [self.refreshDelegate zgTableViewDidTouchNoDataView:self];
    }
}

- (void)reloadDataWithDataArrayCount:(NSInteger)dataArrayCount
{
    if (dataArrayCount == 0) {
        self.noDataView.hidden = NO;
        self.scrollEnabled = NO;
    }else {
        self.noDataView.hidden = YES;
        self.scrollEnabled = YES;
        [self reloadData];
    }
}

@end
