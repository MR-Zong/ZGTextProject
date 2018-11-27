//
//  ZGIMessageController.m
//  ZGTextProj
//
//  Created by ali on 2018/11/26.
//  Copyright © 2018 XuZonggen. All rights reserved.
//

#import "ZGIMessageController.h"
#import <MessageUI/MessageUI.h>


#define kStakeWid 10

@interface ZGIMessageController () <MFMessageComposeViewControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ZGIMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self testCollectionView];
    
//    [self sendIMessage];
}

- (void)testCollectionView
{
    UICollectionViewFlowLayout *collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];

    collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 300)/2.0, 260, 300, 100) collectionViewLayout:collectionViewLayout];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"testcolllllll"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor blackColor];
    self.collectionView.clipsToBounds = NO;
    self.collectionView.scrollEnabled = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = YES;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, kStakeWid, 0, kStakeWid);
    self.collectionView.alwaysBounceHorizontal = YES;
    self.collectionView.alwaysBounceVertical = NO;
    self.collectionView.layer.cornerRadius = 4;
    self.collectionView.layer.masksToBounds = YES;
    [self.view addSubview:self.collectionView];
}

- (void)sendIMessage
{
    if( [MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        controller.recipients = @[@"10086"];//发送短信的号码，数组形式入参
        controller.navigationBar.tintColor = [UIColor redColor];
        controller.body = @"zong test imessage"; //此处的body就是短信将要发生的内容
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:@"title"];//修改短信界面标题
        
    }else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示信息" message:@"该设备不支持短信功能" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *aac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"不支持短信功能");
        }];
        [alert addAction:aac];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
}


#pragma mark - MFMessageComposeViewControllerDelegate
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [self dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MessageComposeResultSent:
            //信息传送成功
            break;
        case MessageComposeResultFailed:
            //信息传送失败
            break;
        case MessageComposeResultCancelled:
            //信息被用户取消传送
            break;
        default:
            break;
    }
}



#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 11;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"testcolllllll" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:cell.bounds];
    imgView.image = [UIImage imageNamed:@"longzhu2"];
    [cell addSubview:imgView];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize cellSize = [self cellSize];
    if (indexPath.item == 10)
    {
        NSLog(@"left left left left left left left left left left ");
        return CGSizeMake(cellSize.width/2.0, cellSize.height);
        //        return CGSizeMake(cellSize.width * secs.doubleValue/self.zg_secondsPerFrame, cellSize.height); //kSecondsPerFrame
    }
    else
    {
        NSLog(@"normal normalnormalnormalnormalnormalnormalnormal");
        return cellSize;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


- (CGSize)cellSize
{
    CGFloat avaiableWid = CGRectGetWidth(self.collectionView.bounds) - 2*kStakeWid;
    CGFloat cellWidth = (avaiableWid  *2.0) /21.0;
    return CGSizeMake(cellWidth, CGRectGetHeight(self.collectionView.bounds));
}

@end
