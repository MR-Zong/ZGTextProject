//
//  ZGGzipController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/9/16.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGGzipController.h"

#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <zlib.h>

@interface ZGGzipContainView : UIView <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation ZGGzipContainView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(100, 100);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"testCollectionViewCell"];
        [self addSubview:_collectionView];

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    self.collectionView.frame = self.bounds;
    
//    [self.collectionView reloadData];
    
    
    /**
     * 为什么这样就可以了呢
     */
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}


#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"reloadData");
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"testCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

@end


#pragma mark -- - - -  - - - -  -
@interface ZGGzipController ()

@property (nonatomic, strong) ZGGzipContainView *containView;

@end

@implementation ZGGzipController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self testAyncOnMain];
//    [self testCollectionView];
    
    // gzip
//    testGzip();
}

- (void)testAyncOnMain
{
    /**
     * 为什么这样就可以了呢
     */
    NSLog(@"aaaaaaaa");
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"cccccccc");
    });
    NSLog(@"bbbbbbbb");
}

- (void)testCollectionView
{
    _containView = [[ZGGzipContainView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_containView];
}


int testGzip()
{
    char text[] = "zlib compress and uncompress test\nturingo@163.com\n2012-11-05\n";
    uLong tlen = strlen(text) + 1;    /* 需要把字符串的结束符'\0'也一并处理 */
    char* buf = NULL;
    uLong blen;
    
    /* 计算缓冲区大小，并为其分配内存 */
    blen = compressBound(tlen);    /* 压缩后的长度是不会超过blen的 */
    if((buf = (char*)malloc(sizeof(char) * blen)) == NULL)
    {
        printf("no enough memory!\n");
        return -1;
    }
    
    /* 压缩 */
    if(compress(buf, &blen, text, tlen) != Z_OK)
    {
        printf("compress failed!\n");
        return -1;
    }
    printf("gzip buf %s\n",buf);
    
    /* 解压缩 */
    char text2[tlen];
    if(uncompress(text2, &tlen, buf, blen) != Z_OK)
    {
        printf("uncompress failed!\n");
        return -1;
    }
    printf("unGzip %s\n",text2);
    
    /* 打印结果，并释放内存 */
//    printf("%s", text);
    if(buf != NULL)
    {
        free(buf);
        buf = NULL;
    }
    
    
    return 0;
}



@end
