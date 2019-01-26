//
//  ZGIMDesignController.m
//  ZGTextProj
//
//  Created by ali on 2019/1/23.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGIMDesignController.h"
#import "ZGIMTextCell.h"
#import "ZGIMMessage.h"

@interface ZGIMDesignController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *messgeAry;

@end

@implementation ZGIMDesignController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self imDesign];
}

- (void)imDesign
{
    _messgeAry = [NSMutableArray array];
    for (int i=0; i<2; i++) {
        ZGIMMessage *msg = [[ZGIMMessage alloc] init];
        msg.messageType = 1;
        msg.content = @"你好，美女";
        [_messgeAry addObject:msg];
    }
    
    _tableView = [[UITableView alloc] init];
    _tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.view.bounds.size.height - 64);
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[ZGIMTextCell class] forCellReuseIdentifier:@"ZGIMTextCellReusedId"];
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messgeAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZGIMTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZGIMTextCellReusedId"];
    cell.message = self.messgeAry[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

@end
