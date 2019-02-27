//
//  ZGShuoUsersListView.m
//  ZGTextProj
//
//  Created by ali on 2019/2/27.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGShuoUsersListView.h"
#import <SDWebImage/UIImageView+WebCache.h>

CGFloat const ZGShuoUsersListView_imgView_space = 10;
CGFloat const ZGShuoUsersListView_imgView_With = 20;
@interface ZGShuoUsersListView ()

@property (nonatomic, strong) NSMutableArray *imgViewAry;
@property (nonatomic, assign) CGFloat rightBaseX;

@end

@implementation ZGShuoUsersListView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _imgViewAry = [NSMutableArray arrayWithCapacity:5];
        _rightBaseX = 0;
    }
    return self;
}

- (void)setupImageViewsWithRightBaseX:(CGFloat)rightBaseX
{
    [self removeAllSubViews];
    
    NSInteger count = self.userArray.count;
    if (count > 4) {
        count = 4;
    }
    for (int i=0; i<count+1; i++) {
        UIImageView *imgView = [UIImageView new];
        imgView.backgroundColor = [UIColor grayColor];
        imgView.contentMode = UIViewContentModeCenter;
        imgView.layer.borderColor = [UIColor redColor].CGColor;
        imgView.layer.borderWidth = 1;
        imgView.layer.cornerRadius = ZGShuoUsersListView_imgView_With / 2.0;
        imgView.layer.masksToBounds = YES;
        imgView.frame = CGRectMake(rightBaseX + i*ZGShuoUsersListView_imgView_space, 0, ZGShuoUsersListView_imgView_With, ZGShuoUsersListView_imgView_With);
        if (i == count) {
            imgView.image = [UIImage imageNamed:@"me_more"];
            imgView.backgroundColor = [UIColor redColor];
        }else {
            NSString *imgUrl = self.userArray[i];
            [imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"vaka_default_avater"] options:SDWebImageAllowInvalidSSLCertificates];
            [self.imgViewAry addObject:imgView];
        }
        [self insertSubview:imgView atIndex:0];
    }
}

- (void)removeAllSubViews
{
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
    [self.imgViewAry removeAllObjects];
}

- (void)setUserArray:(NSArray *)userArray
{
    _userArray = userArray;
    
    if (userArray.count == 0) {
        self.hidden = YES;
    }else {
        self.hidden = NO;
        [self setupImageViewsWithRightBaseX:self.rightBaseX];
    }
    
}

+ (CGFloat)listViewWidthWithUsrsAry:(NSArray *)usersAry
{
    CGFloat width = (usersAry.count + 1) * ZGShuoUsersListView_imgView_With - usersAry.count * ZGShuoUsersListView_imgView_space;
    return width;
}

@end
