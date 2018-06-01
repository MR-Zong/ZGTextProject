//
//  ZGCellOptionMGController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/5/29.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGCellOptionMGController.h"
#import "MGSwipeButton.h"
#import "MGSwipeTableCell.h"

@interface ZGCellOptionMGController () <UITableViewDelegate,UITableViewDataSource,MGSwipeTableCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ZGCellOptionMGController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"cellOption";
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArray = [NSMutableArray array];
    for (int i=0; i<20; i++) {
        [_dataArray addObject:@0];
    }
    
    [self setupViews];
    
}


- (void)setupViews
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [_tableView registerClass:[MGSwipeTableCell class] forCellReuseIdentifier:@"MGSwipeTableCell"];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MGSwipeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MGSwipeTableCell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd-%zd",indexPath.section,indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark Swipe Delegate
-(BOOL) swipeTableCell:(MGSwipeTableCell*) cell canSwipe:(MGSwipeDirection) direction;
{
    [cell refreshButtons:YES];
    return YES;
}

-(NSArray*) swipeTableCell:(MGSwipeTableCell*) cell swipeButtonsForDirection:(MGSwipeDirection)direction
             swipeSettings:(MGSwipeSettings*) swipeSettings expansionSettings:(MGSwipeExpansionSettings*) expansionSettings
{
    
    swipeSettings.transition = MGSwipeTransitionBorder;
    expansionSettings.buttonIndex = 0;
    
    if (direction == MGSwipeDirectionRightToLeft) {
        
        expansionSettings.fillOnTrigger = NO;
        expansionSettings.threshold = 2;
        
         CGFloat padding = 35;
        
        MGSwipeButton *deleteBtn = [MGSwipeButton buttonWithTitle:@"删除" backgroundColor:[UIColor colorWithRed:1.0 green:59/255.0 blue:50/255.0 alpha:1.0] padding:padding callback:^BOOL(MGSwipeTableCell *sender) {

            for (MGSwipeButton *btn in sender.rightButtons) {
                NSString *title = [btn titleForState:UIControlStateNormal];
                if ([title isEqualToString:@"删除"]) {
                    [btn setTitle:@"确认删除" forState:UIControlStateNormal];
                    CGRect tmpF = btn.frame;
                    tmpF.size.width += 40;
                    tmpF.origin.x -= 20;
                    btn.frame = tmpF;
                }else if ([title isEqualToString:@"确认删除"]){
                    NSLog(@"do something");
                }
            }
            
            return NO; //don't autohide to improve delete animation
        }];
        
         return @[deleteBtn];
    }
    
    
    return nil;
    
}

//- (BOOL)swipeTableCell:(MGSwipeTableCell *)cell tappedButtonAtIndex:(NSInteger)index direction:(MGSwipeDirection)direction fromExpansion:(BOOL)fromExpansion
//{
//    NSLog(@"xxx");
//    return YES;
//}

//-(void) swipeTableCell:(MGSwipeTableCell*) cell didChangeSwipeState:(MGSwipeState)state gestureIsActive:(BOOL)gestureIsActive
//{
//    NSString * str;
//    switch (state) {
//        case MGSwipeStateNone: str = @"None"; break;
//        case MGSwipeStateSwippingLeftToRight: str = @"SwippingLeftToRight"; break;
//        case MGSwipeStateSwippingRightToLeft: str = @"SwippingRightToLeft"; break;
//        case MGSwipeStateExpandingLeftToRight: str = @"ExpandingLeftToRight"; break;
//        case MGSwipeStateExpandingRightToLeft: str = @"ExpandingRightToLeft"; break;
//    }
//    NSLog(@"Swipe state: %@ ::: Gesture: %@", str, gestureIsActive ? @"Active" : @"Ended");
//}
@end
