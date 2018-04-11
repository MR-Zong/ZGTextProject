//
//  ZGNSProxyController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/3/29.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGNSProxyController.h"
#import "ZGProxy.h"
#import "ZGNSPCollectionViewCell.h"

@interface ZGNSProxyController () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ZGNSProxyController

- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
    NSLog(@"dealloc");
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"NSProxy应用";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    /* NSProxy 用途还可以实现多重继承 */
    
    
    // 测试 NSProxy 解决 NSTimer 的循环引用
//    [self testProxy];
    
    // 测试collectionView
    [self testCollectionView];
}

- (void)testCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake(200, 100);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    UICollectionView *c = [[UICollectionView alloc] initWithFrame:CGRectMake(100, 100, 200, 100) collectionViewLayout:flowLayout];
    [c registerClass:[ZGNSPCollectionViewCell class] forCellWithReuseIdentifier:@"ZGNSPCollectionViewCellReusedID"];
    c.pagingEnabled = YES;
    c.showsVerticalScrollIndicator = NO;
    c.bounces = NO;
    c.dataSource = self;
    c.delegate = self;
    [self.view addSubview:c];
}

// 测试 NSTimer 导致的循环引用
- (void)testCircule
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(doTimer:) userInfo:nil repeats:YES];
    
}

// 测试 ios10 之后 用block的方法 不会引起 NSTimer循环引用
- (void)testIos10
{
    // 此方法iOS10以上版本可用 因为 并没有引用 self
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"yyyy");
    }];
    
}

// 测试 NSProxy 解决 NSTimer 的循环引用
- (void)testProxy
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:[ZGProxy proxyWithTarget:self] selector:@selector(doTimer:) userInfo:nil repeats:YES];
}

- (void)doTimer:(NSTimer *)timer
{
    NSLog(@"xxx");
}


#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZGNSPCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZGNSPCollectionViewCellReusedID" forIndexPath:indexPath];
    cell.titleLael.text = [NSString stringWithFormat:@"%zd",indexPath.item];
    return cell;
}

@end
