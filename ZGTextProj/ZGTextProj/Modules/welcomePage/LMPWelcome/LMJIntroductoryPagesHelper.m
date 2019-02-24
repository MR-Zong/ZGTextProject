//
//  LMJIntroductoryPagesHelper.m
//  iOSProject
//
//  Created by HuXuPeng on 2017/12/29.
//  Copyright © 2017年 HuXuPeng. All rights reserved.
//

#import "LMJIntroductoryPagesHelper.h"
#import "LMJIntroductoryPagesView.h"

@interface LMJIntroductoryPagesHelper ()

@property (strong, nonatomic) LMJIntroductoryPagesView *curIntroductoryPagesView;

@end

@implementation LMJIntroductoryPagesHelper

+ (instancetype)shareInstance
{
    static LMJIntroductoryPagesHelper *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[LMJIntroductoryPagesHelper alloc] init];
    });
    
    return shareInstance;
}

+ (void)showIntroductoryPageView:(NSArray<NSString *> *)imageArray
{
    if (![LMJIntroductoryPagesHelper shareInstance].curIntroductoryPagesView) {
        [LMJIntroductoryPagesHelper shareInstance].curIntroductoryPagesView = [LMJIntroductoryPagesView pagesViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) images:imageArray];
    }

    [[UIApplication sharedApplication].keyWindow addSubview:[LMJIntroductoryPagesHelper shareInstance].curIntroductoryPagesView];
}

@end
