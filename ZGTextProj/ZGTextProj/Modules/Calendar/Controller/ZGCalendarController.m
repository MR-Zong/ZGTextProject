//
//  ZGCalendarController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/9/8.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import "ZGCalendarController.h"
#import "ZGCalendarHeaderView.h"
#import "ZGCalendarCell.h"
#import "ZGCalendarMonthCell.h"
#import "ZGMonthModel.h"

@interface ZGCalendarController () <UICollectionViewDelegate,UICollectionViewDataSource,ZGCalendarHeaderViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) ZGCalendarHeaderView *headerView;
@property (nonatomic, strong) NSMutableArray *monthsArray;

@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic, assign) dispatch_once_t onceToken;



@end

@implementation ZGCalendarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialize];
    [self setupViews];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    dispatch_once(&_onceToken, ^{
        
        NSCalendarUnit dayInfoUnits  =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
        NSDateComponents *components = [self.calendar components: dayInfoUnits fromDate:[NSDate date]];
        
        NSInteger item = (components.year - 1971) * 12 + components.month - 1;
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
        
        ZGMonthModel *monthModel = self.monthsArray[item];
        self.headerView.optionView.yearAndMonthLabel.text = [NSString stringWithFormat:@"%zd年%zd月",monthModel.year,monthModel.month];
    });
}


#pragma mark -
- (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = year;
    components.month = month;
    components.day = 1;
    return [self.calendar dateFromComponents:components];
}


- (void)initialize
{
    NSInteger yearCount = 100;
    NSInteger monthsCount = yearCount*12;
    NSInteger beginYear = 1971;
    NSInteger year = beginYear;
    NSInteger month = 1;
    _monthsArray = [NSMutableArray arrayWithCapacity:monthsCount];
    for (int i= 1; i<= monthsCount ; i++) {
        
        NSDate *date = [self dateWithYear:year month:month];
        ZGMonthModel *monthModel = [ZGMonthModel monthModelWithYear:year month:month date:date];
        [_monthsArray addObject:monthModel];
        
        if (i % 12 == 0) {
            year ++;
            month = 1;
        }else {
            month++;
        }
    }
}


- (void)setupViews
{
    _headerView = [[ZGCalendarHeaderView alloc] initWithFrame:CGRectMake(0, 64.0, self.view.bounds.size.width, 88.0)];
    _headerView.delegate = self;
    [self.view addSubview:_headerView];
    
    
    // collectionView
    CGRect collectionViewFrame = CGRectMake(0, CGRectGetMaxY(_headerView.frame), self.view.bounds.size.width, self.view.bounds.size.height - _headerView.bounds.size.height -  64.0);
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(collectionViewFrame.size.width, collectionViewFrame.size.height);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;

    
    _collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    [_collectionView registerClass:[ZGCalendarMonthCell class] forCellWithReuseIdentifier:ZGCalendarMonthCellReusedID];
    [self.view addSubview:_collectionView];
}

#pragma mark - ZGCalendarHeaderViewDelegate
- (void)calendarHeaderView:(ZGCalendarHeaderOptionView *)calendarHeaderview didTouchPreBtn:(UIButton *)btn
{
    [self.collectionView setContentOffset:CGPointMake(0, self.collectionView.contentOffset.y - self.collectionView.bounds.size.height) animated:YES];
}

- (void)calendarHeaderView:(ZGCalendarHeaderOptionView *)calendarHeaderview didTouchNextBtn:(UIButton *)btn
{
    [self.collectionView setContentOffset:CGPointMake(0, self.collectionView.contentOffset.y + self.collectionView.bounds.size.height) animated:YES];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.monthsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZGCalendarMonthCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZGCalendarMonthCellReusedID forIndexPath:indexPath];
    ZGMonthModel *monthModel =  self.monthsArray[indexPath.item];
    cell.monthModel = monthModel;

    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.y / scrollView.bounds.size.height;
    ZGMonthModel *monthModel = self.monthsArray[index];
    self.headerView.optionView.yearAndMonthLabel.text = [NSString stringWithFormat:@"%zd年%zd月",monthModel.year,monthModel.month];
}

#pragma mark - getter
- (NSCalendar *)calendar
{
    if (!_calendar) {
        _calendar = [NSCalendar currentCalendar];
        
        NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
        [_calendar setTimeZone: timeZone];
        
    }
    return _calendar;
}


@end
