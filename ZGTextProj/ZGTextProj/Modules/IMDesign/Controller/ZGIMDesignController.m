//
//  ZGIMDesignController.m
//  ZGTextProj
//
//  Created by ali on 2019/1/23.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGIMDesignController.h"
#import "ZGChatMessageModel.h"

#import "ZGChatTimeCell.h"
#import "ZGChatCell.h"

#import "ZGMsgMenuPopView.h"
#import "ZGReportPopView.h"
#import "ZGMsgCountDownView.h"
#import "ZGMsgBottomView.h"
#import "ZGAlertPopView.h"

#import "ZGChatTextInputView.h"
#import "ZGChatTipMessageCell.h"
#import <MJRefresh/MJRefresh.h>
#import "ZGChatRefreshHeader.h"

NSString *const kTableViewContentInset = @"contentInset";

@interface ZGIMDesignController () <UITableViewDelegate,UITableViewDataSource,ZGMsgBottomViewDelegate,ZGChatCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZGChatTextInputView *textInpuView;
@property (nonatomic, strong) ZGMsgBottomView *bottomView;

@property (nonatomic, strong) NSMutableArray *messgeAry;
@property (nonatomic, assign) NSTimeInterval lastMsgTime;

@end

@implementation ZGIMDesignController

- (void)dealloc
{
    [self.tableView removeObserver:self forKeyPath:kTableViewContentInset];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialize];
    [self setupViews];
    
}

- (void)initialize
{
    //    self.view.backgroundColor = [UIColor greenColor];
    self.title = @"zong";
    
     _messgeAry = [NSMutableArray array];
}

- (void)setupRightBtn
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"+" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, 40, 40);
    [rightBtn addTarget:self action:@selector(didRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

- (void)setupViews
{
    [self setupRightBtn];
    
    // tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64.0, ZG_SCREEN_W, ZG_SCREEN_H - 64.0)];
//    _tableView.backgroundColor = [UIColor redColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [_tableView addObserver:self forKeyPath:kTableViewContentInset options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    ZGChatRefreshHeader *header = [ZGChatRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(didLoadMore)];
    _tableView.mj_header = header;
    [self.view addSubview:_tableView];
    
    // 第一次从数据库加载消息后，需要判断是否还有历史消息 进而隐藏下拉Header
//    self.tableView.mj_header.hidden = YES;

    
    // bottomView
    CGFloat bottomHeight = 100;
    _bottomView = [[ZGMsgBottomView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame) - bottomHeight, _tableView.bounds.size.width, bottomHeight)];
    _bottomView.delegate = self;
    [self.view addSubview:_bottomView];
    
    // textInputView
    _textInpuView = [[ZGChatTextInputView alloc] initWithFrame:CGRectMake(0, ZG_SCREEN_H, ZG_SCREEN_W, ZGChatTextInputView_H)];
    _textInpuView.tableView = _tableView;
    __weak typeof(self) weakSelf = self;
    [_textInpuView setSendBlock:^(ZGChatInputInfoModel * _Nonnull inputInfoModel) {
        [weakSelf sendMessageWithInputInfo:inputInfoModel];
    }];
    [self.view addSubview:_textInpuView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self.textInpuView action:@selector(hideKeyboard)];
    [_tableView addGestureRecognizer:tapGesture];
}

#pragma mark - refresh
- (void)didLoadMore
{
    NSLog(@"didRefresh");
    // 模仿拉历史消息
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
        
        NSMutableArray *mergeAry = [NSMutableArray array];
        for (int i= 0; i<1; i++) {
            // 此过程要注意插入时间
            ZGChatMessageModel *messageModel = [ZGChatMessageModel new];
            messageModel.isSender = YES;
            messageModel.isRead = YES;
            messageModel.status = ZGChatMessageDeliveryState_Failure;
            messageModel.creatTime = [[NSDate date] timeIntervalSince1970];
            messageModel.type = ZGChatMessageType_Text;
            messageModel.content = @"refresh";
            [mergeAry addObject:messageModel];
        }
        
        // 此时的IndexP 已经包含时间cell
        NSIndexPath *indexP = [NSIndexPath indexPathForRow:mergeAry.count-1 inSection:0];
        [mergeAry addObjectsFromArray:self.messgeAry];
        self.messgeAry = mergeAry;
        [self  scrollToIndexPath:indexP animated:NO refresh:YES];
        
        // 每次拉历史消息后，都需要判断是否还有历史消息 进而隐藏下拉Header
        self.tableView.mj_header.hidden = YES;
    });
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messgeAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id obj = [self.messgeAry objectAtIndex:indexPath.row];
    
    if ([obj isKindOfClass:[ZGChatTipMesageModel class]]) {
        
        ZGChatTipMesageModel *tipMsgModel = (ZGChatTipMesageModel *)obj;
        if (tipMsgModel.tipType == ZGChatTipMesageType_Time) {
            ZGChatTimeCell *timeCell = (ZGChatTimeCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZGChatTimeCell class])];
            if (!timeCell) {
                timeCell = [[ZGChatTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([ZGChatTimeCell class])];
            }
            timeCell.time = tipMsgModel.creatTime;
            return timeCell;
        }else {
            ZGChatTipMessageCell *tipMsgCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZGChatTipMessageCell class])];
            if (!tipMsgCell) {
                tipMsgCell = [[ZGChatTipMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([ZGChatTipMessageCell class])];
            }
            tipMsgCell.tipModel = tipMsgModel;
            return tipMsgCell;
        }
    }
    
    ZGChatMessageModel *messageModel = (ZGChatMessageModel *)obj;
    NSString *cellIdentifier = [ZGChatCell cellIdentifierForMessageModel:messageModel];
    ZGChatCell *messageCell = (ZGChatCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!messageCell) {
        messageCell = [[ZGChatCell alloc] initWithMessageModel:messageModel reuseIdentifier:cellIdentifier];
    }
    
    messageCell.messageModel = messageModel;
    messageCell.delegate = self;
    
    return messageCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id obj = [self.messgeAry objectAtIndex:indexPath.row];
    
    if ([obj isKindOfClass:[ZGChatTipMesageModel class]]) {
        ZGChatTipMesageModel *tipMsgModel = (ZGChatTipMesageModel *)obj;
        if (tipMsgModel.tipType == ZGChatTipMesageType_Time) {
            return 30;
        }else  {
            return [ZGChatTipMessageCell tableView:tableView heightForRowAtIndexPath:indexPath withObject:tipMsgModel];
        }
    }
    
    ZGChatMessageModel *messageModel = (ZGChatMessageModel *)obj;
    if (messageModel.rowHeight > 0) {
        return messageModel.rowHeight;
    }
    messageModel.rowHeight = [ZGChatCell tableView:tableView heightForRowAtIndexPath:indexPath withObject:messageModel];
    
    return messageModel.rowHeight;
}


#pragma mark - 刷新并滑动到底部
- (void)scrollToBottomAnimated:(BOOL)animated refresh:(BOOL)refresh {
    // tableview滑动到底部
    if (refresh) [self.tableView reloadData];
    if (!self.messgeAry.count) return;
    NSIndexPath *lastPath = [NSIndexPath indexPathForRow:self.messgeAry.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:lastPath atScrollPosition:UITableViewScrollPositionBottom animated:animated];
}

- (void)scrollToIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated refresh:(BOOL)refresh {
    if (refresh) [self.tableView reloadData];
    if (!self.messgeAry.count) return;
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:animated];
}

- (void)refreshCellWithMessage:(ZGChatMessageModel *)messageModel
{
    NSArray *cells = [self.tableView visibleCells];
    [cells enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[ZGChatCell class]]) {
            ZGChatCell *messagecell = (ZGChatCell *)obj;
            if (messagecell.messageModel.creatTime == messageModel.creatTime) {
                [messagecell layoutSubviews];
                *stop = YES;
            }
        }
    }];
}

#pragma mark - 监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:kTableViewContentInset]) {
        CGRect newValue = [change[NSKeyValueChangeNewKey] CGRectValue];
        CGRect oldValue = [change[NSKeyValueChangeOldKey] CGRectValue];
        if (newValue.size.width != oldValue.size.width &&
            newValue.size.width > 0) {
            
            [self scrollToBottomAnimated:YES refresh:NO];
        }
        return;
    }
    
}

#pragma mark - ZGMsgBottomViewDelegate
- (void)bottomView:(ZGMsgBottomView *)bottomView didRecordBtn:(UIButton *)btn
{
    [self.textInpuView becomeFirstResponder];
}
#pragma mark - ZGChatCellDelegate
- (void)chatCell:(ZGChatCell *)cell didTouchHeaderWithMsgModel:(ZGChatMessageModel *)messageModel
{
    NSLog(@"头像被点击");
}

- (void)chatCell:(ZGChatCell *)cell didRetrybtnWithMsgModel:(ZGChatMessageModel *)messageModel
{
    // 重发消息处理
    NSLog(@"重发消息");
#warning
    messageModel.status = ZGChatMessageDeliveryState_Delivering;
    [self refreshCellWithMessage:messageModel];
    
    // 模仿延迟发送
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        messageModel.status = ZGChatMessageDeliveryState_Delivered;
        [self refreshCellWithMessage:messageModel];
    });
}

- (void)chatCell:(ZGChatCell *)cell didTouchBubbleWithMsgModel:(ZGChatMessageModel *)messageModel
{
    NSLog(@"bubbleView被点击");
    if (messageModel.type == ZGChatMessageType_Audio) {
        // 播放音频
    }
}

#pragma mark - action
- (void)didRightBtn:(UIButton *)btn
{
    // 菜单
//    ZGMsgMenuPopView *menuView = [[ZGMsgMenuPopView alloc] init];
//    [menuView showInView:self.view.window];
    
//    ZGReportPopView *reportView = [[ZGReportPopView alloc] init];
//    [reportView showInView:self.view];
    
    ZGAlertPopView *alert = [[ZGAlertPopView alloc] init];
    [alert showInView:self.view title:@"拉黑后将不再收到此人消息"];
}

- (void)sendMessageWithInputInfo:(ZGChatInputInfoModel *)inputInfoModel
{
    if (inputInfoModel.text.length > 0) {
        [self sendMessage:inputInfoModel type:ZGChatMessageType_Audio];
    }
}

#pragma  mark - sendMessage
- (void)sendMessage:(ZGChatInputInfoModel *)inputInfoModel type:(ZGChatMessageType)type {
 
    __block ZGChatMessageModel *messageModel = [ZGChatMessageModel new];
    messageModel.isSender = YES;
    messageModel.isRead = YES;
    messageModel.status = ZGChatMessageDeliveryState_Delivering;
    messageModel.creatTime = [[NSDate date] timeIntervalSince1970];
    messageModel.type = type;
    switch (type) {
        case ZGChatMessageType_Text: {
            messageModel.content = inputInfoModel.text;
            break;
        }
        case ZGChatMessageType_Audio: {
            messageModel.audio_duration = 3;//inputInfoModel.audio_duration;
            messageModel.audio_localPath = inputInfoModel.audio_localPath;
            messageModel.audio_text = @"zong say hello";
            break;
        }
        default:
            break;
    }
    
    // 数据库插入
    ;
    
    NSIndexPath *indexP = [self insertMessageByTime:messageModel];
    self.lastMsgTime = messageModel.creatTime;
    [self.tableView scrollToRowAtIndexPath:indexP atScrollPosition:UITableViewScrollPositionBottom animated:YES];
#warning
    // 模仿延迟发送
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        messageModel.status = ZGChatMessageDeliveryState_Delivered;
                [self refreshCellWithMessage:messageModel];
        
//        // 模仿 被拉黑消息
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//            ZGChatTipMesageModel *tipModel = [[ZGChatTipMesageModel alloc] init];
//            tipModel.tipType = ZGChatTipMesageType_Be_Deleted_Friend;
//            // 时间需要是真实消息的时间，这里是随便写的
//            tipModel.creatTime = [[NSDate date] timeIntervalSince1970];
//            NSIndexPath *index = [self insertMessageByTime:tipModel];
//            [self.tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//        });
        
        // 模仿消息回复
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            ZGChatMessageModel *dbMessageModel = [ZGChatMessageModel new];
            dbMessageModel.isSender = YES;
            dbMessageModel.isRead = YES;
            dbMessageModel.creatTime = messageModel.creatTime;
            dbMessageModel.type = type;
            switch (type) {
                case ZGChatMessageType_Text: {
                    dbMessageModel.content = inputInfoModel.text;
                    break;
                }
                case ZGChatMessageType_Audio: {
                    dbMessageModel.audio_duration = 3;//inputInfoModel.audio_duration;
                    dbMessageModel.audio_localPath = inputInfoModel.audio_localPath;
                    dbMessageModel.audio_text = @"zong say hello";
                    
                    break;
                }
                default:
                    break;
            }

            dbMessageModel.isSender = NO;
            NSIndexPath *index = [self insertMessageByTime:dbMessageModel];
            [self.tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        });
    });
}

#pragma mark - receiveMessage
- (void)receiveMessage:(ZGChatInputInfoModel *)inputInfoModel type:(ZGChatMessageType)type
{
    // 我先大概写了，到时候要实际调试
    // 根据传进来数据 生成messageModel
    ZGChatMessageModel *newMessage = [ZGChatMessageModel new];
    // 然后 和发送差不多
    NSIndexPath *indexP = [self insertMessageByTime:newMessage];
    self.lastMsgTime = newMessage.creatTime;
    [self.tableView scrollToRowAtIndexPath:indexP atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}

- (NSIndexPath *)insertMessageByTime:(id)newMessge
{
    // insert time
    if ([newMessge creatTime] - 3600  > self.lastMsgTime) {
        ZGChatTipMesageModel *timeMsgModel = [ZGChatTipMesageModel new];
        timeMsgModel.tipType = ZGChatTipMesageType_Time;
        timeMsgModel.creatTime = [newMessge creatTime];
        [self insertMessage:timeMsgModel];
        
    }
    return [self insertMessage:newMessge];
}

- (NSIndexPath *)insertMessage:(id)newMessge
{
    NSIndexPath *indexP = [NSIndexPath indexPathForRow:self.messgeAry.count inSection:0];
    [self.messgeAry addObject:newMessge];
    [self.tableView insertRowsAtIndexPaths:@[indexP] withRowAnimation:UITableViewRowAnimationNone];
    return indexP;
}

@end
