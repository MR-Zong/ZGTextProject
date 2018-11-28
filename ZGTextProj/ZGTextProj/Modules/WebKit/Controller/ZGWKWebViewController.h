//
//  ZGWKWebViewController.h
//  ZGTextProj
//
//  Created by ali on 2018/11/28.
//  Copyright © 2018 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ZGWKWebViewBackType) {
    ZGWKWebViewBackTypeDefault,
    ZGWKWebViewBackTypePop,
    ZGWKWebViewBackTypeDismiss,
};

@interface ZGWKWebViewController : UIViewController


@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, assign) ZGWKWebViewBackType backType;

+(void)openUrl:(NSString*)url navigationController:(UINavigationController *)navigationController backType:(ZGWKWebViewBackType)backType;


@end

NS_ASSUME_NONNULL_END
