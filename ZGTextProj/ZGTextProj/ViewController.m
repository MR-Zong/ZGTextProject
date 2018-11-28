//
//  ViewController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/7/28.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import "ViewController.h"

#import "ZGMaskController.h"
#import "ZGTestBlockViewController.h"
#import "ZGComposeVideoAndAudioViewController.h"
#import "ZGInterviewViewController.h"
#import "ZGTestCopyViewController.h"
#import "ZGOffScreenController.h"
#import "ZGAddressListController.h"
#import "ZGCalendarController.h"
#import "ZGTestViewBoundsController.h"
#import "ZGTestWindowController.h"

// category
#import "ZGCategoryController.h"
#import "ZGCategoryExtendController.h"

// avfoundation
#import "ZGAVAudioTrackController.h"
#import "ZGAVAudioClipController.h"


#import "ZGInstanceController.h"
#import "ZGBlockController.h"
#import "ZGProtocolController.h"
#import "ZGTbTestController.h"
#import "ZGBrightnessController.h"
#import "ZGSTestController.h"
#import "ZGOneScrollViewController.h"

#import "ZGWeakSelfController.h"
#import "ZGHeaderFileController.h"
#import "ZGMsgForwardController.h"
#import "ZGNotificationController.h"
#import "ZGKVOController.h"
#import "ZGCYViewController.h"
#import "ZGKEViewController.h"
#import "ZGGCDTestController.h"
#import "ZGInitializeController.h"
#import "ZGPerformanceController.h"
#import "ZGCAAnimationController.h"
#import "ZGCrashController.h"
#import "ZGNSProxyController.h"
#import "ZGSafeDicController.h"
#import "ZGOperationQueueController.h"
#import "ZGExtendLayoutController.h"
#import "ZGERController.h"
#import "ZGInitFunctionController.h"
#import "ZGClassFunctionController.h"
#import "ZGScrollViewNestingController.h"
#import "ZGSafeAreaController.h"
#import "ZGNavTestController.h"
#import "ZGCellOptionController.h"
// cell option
#import "ZGCellOptionMGController.h"
#import "ZGCellOptionGestureController.h"

#import "ZGPVCTestController.h"
// animations
#import "ZGAnimationsController.h"
#import "ZGAnimationsTableController.h"
#import "ZGAnimationsCellController.h"
#import "ZGAnimationCellNormalController.h"
#import "ZGAnimationsCollectionViewController.h"
#import "ZGAniCollectionViewNormalController.h"
#import "ZGAniTextCellController.h"
#import "ZGAnisTestController.h"

#import "ZGEventChainController.h"
#import "ZGSTestDragingController.h"
#import "ZGPropertyController.h"
#import "ZGArchiveController.h"

#import "ZGImageController.h"
#import "ZGScrollTabIndicatorController.h"
#import "ZGLockAndSemaphoreController.h"
#import "ZGTimerController.h"

#import "ZGHotFixController.h"

#import "ZGWaterFallController.h"
#import "ZGVAKDiscoverController.h"
#import "ZGGzipController.h"
#import "ZGScrollAndPopController.h"

#import "ZGFontController.h"

#import "ZGBezierController.h"
#import "ZGAutoScrollLabelController.h"
#import "ZGPhotoPickController.h"

#import "ZGAssertController.h"
#import "ZGIMessageController.h"
#import "ZGWebKitTestController.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialize];
    [self setupViews];
}

- (void)initialize
{
    self.title = @"测试集合";
}

- (void)setupViews
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 44.0;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ZGMaskCellID"];
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 62;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZGMaskCellID"];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"mask";
    }else if(indexPath.row == 1){
        cell.textLabel.text = @"block";
    }else if(indexPath.row == 2){
        cell.textLabel.text = @"composeVideoAndAudio";
    }else if(indexPath.row == 3){
        cell.textLabel.text = @"interview";
    }else if(indexPath.row == 4){
        cell.textLabel.text = @"NSCopying协议";
    }else if(indexPath.row == 5){
        cell.textLabel.text = @"offScreen";
    }else if(indexPath.row == 6){
        cell.textLabel.text = @"addressList";
    }else if(indexPath.row == 7){
        cell.textLabel.text = @"calendar";
    }else if(indexPath.row == 8){
        cell.textLabel.text = @"viewBounds";
    }else if(indexPath.row == 9){
        cell.textLabel.text = @"testWindow";
    }else if(indexPath.row == 10){
        cell.textLabel.text = @"category";
    }else if(indexPath.row == 11){
        cell.textLabel.text = @"avFoundation";
    }else if(indexPath.row == 12){
        cell.textLabel.text = @"instance";
    }else if(indexPath.row == 13){
        cell.textLabel.text = @"block";
    }else if(indexPath.row == 14){
        cell.textLabel.text = @"protocol";
    }else if(indexPath.row == 15){
        cell.textLabel.text = @"UITableview";
    }else if(indexPath.row == 16){
        cell.textLabel.text = @"brightness";
    }else if(indexPath.row == 17){
        cell.textLabel.text = @"uiscrollview";
    }else if(indexPath.row == 18){
        cell.textLabel.text = @"OneScrollview";
    }else if(indexPath.row == 19){
        cell.textLabel.text = @"weakSelf";
    }else if(indexPath.row == 20){
        cell.textLabel.text = @"headFile";
    }else if(indexPath.row == 21){
        cell.textLabel.text = @"messageForward";
    }else if(indexPath.row == 22){
        cell.textLabel.text = @"notification";
    }else if(indexPath.row == 23){
        cell.textLabel.text = @"KVO";
    }else if(indexPath.row == 24){
        cell.textLabel.text = @"copy&mutableCopy";
    }else if(indexPath.row == 25){
        cell.textLabel.text = @"KVO本质研究";
    }else if(indexPath.row == 26){
        cell.textLabel.text = @"GCD";
    }else if(indexPath.row == 27){
        cell.textLabel.text = @"initialize";
    }else if(indexPath.row == 28){
        cell.textLabel.text = @"performance";
    }else if(indexPath.row == 29){
        cell.textLabel.text = @"CAAnimation";
    }else if(indexPath.row == 30){
        cell.textLabel.text = @"crash";
    }else if(indexPath.row == 31){
        cell.textLabel.text = @"NSProxy";
    }else if(indexPath.row == 32){
        cell.textLabel.text = @"safeDictionary";
    }else if(indexPath.row == 33){
        cell.textLabel.text = @"NSOperationQueue";
    }else if(indexPath.row == 34){
        cell.textLabel.text = @"ExtendLayout";
    }else if(indexPath.row == 35){
        cell.textLabel.text = @"EstimateRowHeight";
    }else if(indexPath.row == 36){
        cell.textLabel.text = @"initFunciton";
    }else if(indexPath.row == 37){
        cell.textLabel.text = @"ClassFunction";
    }else if(indexPath.row == 38){
        cell.textLabel.text = @"ScrollViewNesting";
    }else if(indexPath.row == 39){
        cell.textLabel.text = @"SafeArea";
    }else if(indexPath.row == 40){
        cell.textLabel.text = @"Navigation";
    }else if(indexPath.row == 41){
        cell.textLabel.text = @"cellOption";
    }else if(indexPath.row == 42){
        cell.textLabel.text = @"pageViewController";
    }else if(indexPath.row == 43){
        cell.textLabel.text = @"Animations";
    }else if(indexPath.row == 44){
        cell.textLabel.text = @"eventChain";
    }else if(indexPath.row == 45){
        cell.textLabel.text = @"property";
    }else if(indexPath.row == 46){
        cell.textLabel.text = @"archive";
    }else if(indexPath.row == 47){
        cell.textLabel.text = @"image";
    }else if(indexPath.row == 48){
        cell.textLabel.text = @"scrollTabIndicator";
    }else if(indexPath.row == 49){
        cell.textLabel.text = @"lock&semaphore";
    }else if(indexPath.row == 50){
        cell.textLabel.text = @"timer";
    }else if(indexPath.row == 51){
        cell.textLabel.text = @"hotfix";
    }else if(indexPath.row == 52){
        cell.textLabel.text = @"waterfall";
    }else if(indexPath.row == 53){
        cell.textLabel.text = @"gZip";
    }else if(indexPath.row == 54){
        cell.textLabel.text = @"font";
    }else if(indexPath.row == 55){
        cell.textLabel.text = @"audioClip";
    }else if(indexPath.row == 56){
        cell.textLabel.text = @"bezierPath";
    }else if(indexPath.row == 57){
        cell.textLabel.text = @"autoScrollLabel";
    }else if(indexPath.row == 58){
        cell.textLabel.text = @"photoKit";
    }else if(indexPath.row == 59){
        cell.textLabel.text = @"assert";
    }else if(indexPath.row == 60){
        cell.textLabel.text = @"IMessage";
    }else if(indexPath.row == 61){
        cell.textLabel.text = @"WebKit";
    }








    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ZGMaskController *con = [[ZGMaskController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 1){
        ZGTestBlockViewController *con = [[ZGTestBlockViewController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 2){
        ZGComposeVideoAndAudioViewController *con = [[ZGComposeVideoAndAudioViewController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 3){
        ZGInterviewViewController *con = [[ZGInterviewViewController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 4){
        ZGTestCopyViewController *con = [[ZGTestCopyViewController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 5){
        ZGOffScreenController *con = [[ZGOffScreenController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 6){
        ZGAddressListController *con = [[ZGAddressListController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 7){
        ZGCalendarController *con = [[ZGCalendarController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 8){
        ZGTestViewBoundsController *con = [[ZGTestViewBoundsController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 9){
        ZGTestWindowController *con = [[ZGTestWindowController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 10){
        ZGCategoryExtendController *con = [[ZGCategoryExtendController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 11){
        ZGAVAudioTrackController *con = [[ZGAVAudioTrackController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 12){
        ZGInstanceController *con = [[ZGInstanceController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 13){
        ZGBlockController *con = [[ZGBlockController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 14){
        ZGProtocolController *con = [[ZGProtocolController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 15){
        ZGTbTestController *con = [[ZGTbTestController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 16){
        ZGBrightnessController *con = [[ZGBrightnessController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 17){ // uiScorllView
        ZGScrollAndPopController *con = [[ZGScrollAndPopController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 18){
        ZGOneScrollViewController *con = [[ZGOneScrollViewController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 19){
        ZGWeakSelfController *con = [[ZGWeakSelfController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 20){
        ZGHeaderFileController *con = [[ZGHeaderFileController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 21){
        ZGMsgForwardController *con = [[ZGMsgForwardController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 22){
        ZGNotificationController *con = [[ZGNotificationController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 23){
        ZGKVOController *con = [[ZGKVOController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 24){
        ZGCYViewController *con = [[ZGCYViewController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 25){
        ZGKEViewController *con = [[ZGKEViewController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 26){
        ZGGCDTestController *con = [[ZGGCDTestController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 27){
        ZGInitializeController *con = [[ZGInitializeController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 28){
        ZGPerformanceController *con = [[ZGPerformanceController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 29){
        ZGCAAnimationController *con = [[ZGCAAnimationController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 30){
        ZGCrashController *con = [[ZGCrashController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 31){
        ZGNSProxyController *con = [[ZGNSProxyController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 32){
        ZGSafeDicController *con = [[ZGSafeDicController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 33){
        ZGOperationQueueController *con = [[ZGOperationQueueController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 34){
        ZGExtendLayoutController *con = [[ZGExtendLayoutController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 35){
        ZGERController *con = [[ZGERController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 36){
        ZGInitFunctionController *con = [[ZGInitFunctionController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 37){
        ZGClassFunctionController *con = [[ZGClassFunctionController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 38){
        ZGScrollViewNestingController *con = [[ZGScrollViewNestingController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 39){
        ZGSafeAreaController *con = [[ZGSafeAreaController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 40){
        ZGNavTestController *con = [[ZGNavTestController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 41){
        ZGCellOptionGestureController *con = [[ZGCellOptionGestureController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 42){
        ZGPVCTestController *con = [[ZGPVCTestController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 43){
        ZGAniTextCellController *con = [[ZGAniTextCellController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 44){
        ZGEventChainController *con = [[ZGEventChainController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 45){
        ZGPropertyController *con = [[ZGPropertyController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 46){
        ZGArchiveController *con = [[ZGArchiveController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 47){
        ZGImageController *con = [[ZGImageController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 48){
        ZGScrollTabIndicatorController *con = [[ZGScrollTabIndicatorController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 49){
        ZGLockAndSemaphoreController *con = [[ZGLockAndSemaphoreController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 50){
        ZGTimerController *con = [[ZGTimerController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 51){
        ZGHotFixController *con = [[ZGHotFixController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 52){
        ZGWaterFallController *con = [[ZGWaterFallController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 53){
        ZGGzipController *con = [[ZGGzipController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 54){
        ZGFontController *con = [[ZGFontController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 55){
        ZGAVAudioClipController *con = [[ZGAVAudioClipController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 56){
        ZGBezierController *con = [[ZGBezierController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 57){
        ZGAutoScrollLabelController *con = [[ZGAutoScrollLabelController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 58){
        ZGPhotoPickController *con = [[ZGPhotoPickController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 59){
        ZGAssertController *con = [[ZGAssertController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 60){
        ZGIMessageController *con = [[ZGIMessageController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }else if(indexPath.row == 61){
        ZGWebKitTestController *con = [[ZGWebKitTestController alloc] init];
        [self.navigationController pushViewController:con animated:YES];
    }






}


@end
