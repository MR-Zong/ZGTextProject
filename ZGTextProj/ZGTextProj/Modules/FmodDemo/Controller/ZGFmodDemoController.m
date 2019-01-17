//
//  ZGFmodDemoController.m
//  ZGTextProj
//
//  Created by ali on 2019/1/17.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGFmodDemoController.h"
#import "FMAudioPlayer.h"
#import "ZGBottomToolBar.h"
#import "ZGRecorder.h"

typedef NS_ENUM(NSInteger,ZGRouteType) {
    ZGRouteTypeDefault,
    ZGRouteTypeUserRecord,
};

@interface ZGFmodDemoController ()<UITableViewDelegate, UITableViewDataSource,ZGBottomToolBarDelegate>

@property (nonatomic, strong) NSString *resFilePath;
@property (nonatomic, assign) ZGRouteType routeType;
@property (nonatomic, strong) ZGRecorder *recorder;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZGBottomToolBar *toolBar;
@property (nonatomic, strong) NSArray<FMAudioPlayerOption *> *audioOptions;
@property (nonatomic, strong) FMAudioPlayer *player;

@end

@implementation ZGFmodDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Fmod测试";
    NSString *cacheDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES) firstObject];
    NSString *fileFullName = @"result.wav";
    _resFilePath = [cacheDir stringByAppendingPathComponent:fileFullName];
    
    _recorder = [[ZGRecorder alloc] initWithResultPath:_resFilePath];
    [ZGRecorder configAVAudioSession];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 400) style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 50;
    [self.view addSubview:self.tableView];
    
    self.audioOptions = [FMAudioPlayerOption defaultOptions];
    [self.tableView reloadData];
    
    _toolBar = [[ZGBottomToolBar alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame)+20, [UIScreen mainScreen].bounds.size.width, 80)];
    _toolBar.delegate = self;
    [self.view addSubview:_toolBar];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.audioOptions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = self.audioOptions[indexPath.row].name;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *str = [[NSBundle mainBundle] pathForResource:@"singing" ofType:@"wav"];
    if (self.routeType == ZGRouteTypeUserRecord) {
        str = self.resFilePath;
    }
    
    if (self.player) {
        [self.player stop];
    }
    self.player = [[FMAudioPlayer alloc] initWithPath:str option:self.audioOptions[indexPath.row]];
    [self.player play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ZGBottomToolBarDelegate
- (void)toolBar:(ZGBottomToolBar *)toolBar didClickRouteBtn:(UIButton *)btn
{
    if (btn.selected) {
        self.routeType = ZGRouteTypeUserRecord;
    }else {
        self.routeType = ZGRouteTypeDefault;
    }
}

- (void)toolBar:(ZGBottomToolBar *)toolBar didClickRecBtn:(UIButton *)btn
{
    if (btn.selected) {
        [self.recorder start];
    }else {
        [self.recorder stop];
    }
}

- (void)toolBar:(ZGBottomToolBar *)toolBar didClickPlayeBtn:(UIButton *)btn
{
    if (btn.selected) {
        if (self.routeType == ZGRouteTypeUserRecord) {
            ;
        }else {
            ;
        }
        
    }else {
        [self.player stop];
    }
}


@end
