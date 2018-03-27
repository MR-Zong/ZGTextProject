//
//  ZGSTestController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/1/9.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGSTestController.h"
#import "ZGSBaseScrollView.h"
#import "ZGSSubScrollView.h"

#import "ZGSV1Delegate.h"
#import "ZGSV2Delegate.h"
#import "ZGSV3Delegate.h"

@interface ZGSTestController () <UIGestureRecognizerDelegate>

@property (nonatomic,strong) ZGSSubScrollView *sv1;
@property (nonatomic,strong) ZGSSubScrollView *sv2;
@property (nonatomic,strong) ZGSSubScrollView *sv3;
@property (nonatomic,strong) ZGSBaseScrollView *containSV;

@property (nonatomic,strong) ZGSV1Delegate *sv1Delegate;
@property (nonatomic,strong) ZGSV2Delegate *sv2Delegate;
@property (nonatomic,strong) ZGSV3Delegate *sv3Delegate;

@end

@implementation ZGSTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSLog(@"width %f",self.view.bounds.size.width);
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    
    _sv1Delegate = [[ZGSV1Delegate alloc] init];
    _sv2Delegate = [[ZGSV2Delegate alloc] init];
    _sv3Delegate = [[ZGSV3Delegate alloc] init];
    
    
    
    _containSV = [[ZGSBaseScrollView alloc] initWithFrame:self.view.bounds];
    _containSV.pageCount = 3;
    _containSV.contentSize = CGSizeMake(self.view.bounds.size.width * _containSV.pageCount, 0);
    _containSV.scrollEnabled = NO;
    _containSV.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.4];
    
    _sv1Delegate.containSV = _containSV;
    _sv2Delegate.containSV = _containSV;
    _sv3Delegate.containSV = _containSV;

    [self.view addSubview:_containSV];
    
    
    for (int j=0; j<3; j++) {

        ZGSSubScrollView *sv = [[ZGSSubScrollView alloc] initWithFrame:CGRectMake(j*_containSV.bounds.size.width, 0, _containSV.bounds.size.width, _containSV.bounds.size.height)];
        if (j == 0) {
            _sv1 = sv;
            _sv1.delegate = _sv1Delegate;
             sv.backgroundColor = [UIColor redColor];
        }else if(j==1){
            _sv2 = sv;
            _sv2.delegate = _sv2Delegate;
            sv.backgroundColor = [UIColor grayColor];
        }else if(j==2){
            _sv3 = sv;
            _sv3.delegate = _sv3Delegate;
            sv.backgroundColor = [UIColor yellowColor];
        }
        
        sv.pagingEnabled = YES;
        sv.contentSize = CGSizeMake(self.view.bounds.size.width * 3, self.view.bounds.size.height);
        for (int i=0; i<3; i++) {
            UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(i*sv.bounds.size.width, 0, sv.bounds.size.width, sv.bounds.size.height)];
            UILabel *label = [[UILabel alloc] initWithFrame:subView.bounds];
            label.text = [NSString stringWithFormat:@"SV1 - %zd",i];
            label.font = [UIFont systemFontOfSize:50];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor blackColor];
            [subView addSubview:label];
            [sv addSubview:subView];
        }
        [_containSV addSubview:sv];
    }
    

}



@end
