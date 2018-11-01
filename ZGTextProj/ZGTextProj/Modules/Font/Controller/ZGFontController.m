//
//  ZGFontController.m
//  ZGTextProj
//
//  Created by ali on 2018/9/26.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGFontController.h"
#import "ZGExposureCell.h"
#import "ZGExposureManager.h"


@interface ZGFontController () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) ZGExposureManager *exposureManager;
@property (nonatomic, strong) NSMutableDictionary <NSString *,ZGExposureDataModel *>*exp_dataModelDic;

@end

@implementation ZGFontController


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ZGExposureContentOffsetChangeNotify object:nil userInfo:@{@"contentOffset_y":@(self.collectionView.contentOffset.y)}];
    [self zg_exposureOnScrollDidEnd];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self testFont];
    
    // 测试---曝光统计
    [self testExposure];
}

- (void)testFont
{
    [self printSystemFonts2];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 40)];
    _label.backgroundColor = [UIColor blackColor];
    _label.textColor = [UIColor whiteColor];
    _label.textAlignment = NSTextAlignmentCenter;
    
    UIFont *font = [UIFont fontWithName:@"Cairo-Regular" size:12];
    _label.font = font;
    _label.text = @"لا مزيد من البيانات";
    [self.view addSubview:_label];

}

- (void)testExposure
{
    _exposureManager = [[ZGExposureManager alloc] init];
    _exp_dataModelDic = [NSMutableDictionary dictionary];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    CGFloat itemWidth = ([UIScreen mainScreen].bounds.size.width - 2) / 3.0;
     CGFloat itemWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat itemHeight = [UIScreen mainScreen].bounds.size.height;
    flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
    flowLayout.minimumLineSpacing = 1;
    flowLayout.minimumInteritemSpacing = 1;
    flowLayout.headerReferenceSize = CGSizeMake(100, 200);
    
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:[ZGExposureCell class] forCellWithReuseIdentifier:@"ZGExposureCellReuseID"];
    [self.view addSubview:_collectionView];
}

- (ZGExposureDataModel *)getDataModelWithIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [NSString stringWithFormat:@"data_%zd",indexPath.item];
    ZGExposureDataModel *dataM = self.exp_dataModelDic[key];
    if (!dataM) {
        dataM = [[ZGExposureDataModel alloc] init];
        dataM.indexPath = indexPath;
        [self.exp_dataModelDic setValue:dataM forKey:key];
    }
    return dataM;
}

#pragma mark - test font
- (void)printSystemFonts
{
    UIFont *font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    NSLog(@"当前字体。。。 %@",font);
    NSMutableArray *familyNameArray = [[NSMutableArray alloc] init];
    NSArray* familyNamesAll = [UIFont familyNames];
    for (id family in familyNamesAll) {
        NSArray* fonts = [UIFont fontNamesForFamilyName:family];
        for (id font in fonts)
        {
                [familyNameArray addObject:font];
                
            }
        
    }
    NSLog(@"所有字体 %@",familyNameArray);

}

- (void)printSystemFonts2
{
    for (NSString *fontfamilyname in [UIFont familyNames])
    {
        NSLog(@"family:'%@'",fontfamilyname);
        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
        {
            NSLog(@"\tfont:'%@'",fontName);
        }
        NSLog(@"-------------");
    }
    
}


#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 170;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZGExposureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZGExposureCellReuseID" forIndexPath:indexPath];
    cell.exposureMgr = self.exposureManager;
    cell.exp_dataModel = [self getDataModelWithIndexPath:indexPath];
    return cell;
}

#pragma mark - scroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // contentOffset 必须传到cell
    [[NSNotificationCenter defaultCenter] postNotificationName:ZGExposureContentOffsetChangeNotify object:nil userInfo:@{@"contentOffset_y":@(scrollView.contentOffset.y)}];
//    NSLog(@"contentOffset.y %f",scrollView.contentOffset.y);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self zg_exposureOnScrollDidEnd];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self zg_exposureOnScrollDidEnd];
    }
}

- (void)zg_exposureOnScrollDidEnd
{
    // 500ms 统计一次曝光
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:ZGExposureStatisticNotify object:nil];
    });
}

@end
