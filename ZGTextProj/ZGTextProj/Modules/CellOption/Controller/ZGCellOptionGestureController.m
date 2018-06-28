//
//  ZGCellOptionGestureController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/6/28.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGCellOptionGestureController.h"
#import "ZGCellOpGestureTable.h"
#import "ZGCellopGestureScrollView.h"
#import "ZGCellOpCell.h"

@interface ZGCellOptionGestureController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) ZGCellopGestureScrollView *scrollView;
@property (nonatomic, strong) ZGCellOpGestureTable *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ZGCellOptionGestureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"左滑删除冲突";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    NSLog(@"width %f",[UIScreen mainScreen].bounds.size.width);
    _dataArray = [NSMutableArray array];
    for (int i=0; i<20; i++) {
        [_dataArray addObject:@0];
    }
    
    [self setupViews];
    
}


- (void)setupViews
{
    
    _scrollView = [[ZGCellopGestureScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.backgroundColor = [UIColor redColor];
    _scrollView.alwaysBounceVertical = NO;
    _scrollView.bounces = NO;
    _scrollView.contentSize = CGSizeMake(2*self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:_scrollView];
    
    _tableView = [[ZGCellOpGestureTable alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [_tableView registerClass:[ZGCellOpCell class] forCellReuseIdentifier:@"ZGCellOpCellReusedId"];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_scrollView addSubview:_tableView];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZGCellOpCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZGCellOpCellReusedId"];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd-%zd",indexPath.section,indexPath.row];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
#pragma mark - 多个选项
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 5;
}

- (NSArray*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    // delete action
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:NSLocalizedString(@"Delete", @"") handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                          {
                                              
                                              //                                              [tableView setEditing:NO animated:YES];  // 这句很重要，退出编辑模式，隐藏左滑菜单
                                              //                                              [self removeNotificationAction:index];
                                          }];
    
    // read action
    //    // 根据cell当前的状态改变选项文字
    //    NSInteger index = indexPath.section;
    //    BOOL isRead = [[NotificationManager instance] read:index];
    //    NSString *readTitle = isRead ? @"Unread" : @"Read";
    //
    //    // 创建action
    //    UITableViewRowAction *readAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:readTitle handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
    //                                        {
    //                                            [tableView setEditing:NO animated:YES];  // 这句很重要，退出编辑模式，隐藏左滑菜单
    //                                            [[NotificationManager instance] setRead:!isRead index:index];
    //                                        }];
    
    return @[deleteAction];
}


#pragma mark - 系统删除
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.dataArray[indexPath.row] = @0;
    return UITableViewCellEditingStyleNone;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dataArray[indexPath.row] integerValue] == 1) {
        return @"确认删除";
    }
    return @"删除";
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        self.dataArray[indexPath.row] = @1;
    }
    
}




@end
