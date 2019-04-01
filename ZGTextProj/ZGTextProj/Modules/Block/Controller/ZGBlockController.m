//
//  ZGBlockController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/1/3.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGBlockController.h"
#import "ZGBlockPeople.h"

@interface ZGBlockController ()

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) ZGBlockPeople *p;
@property (nonatomic, weak) void(^zg_stackBlcok)(void);

@end

@implementation ZGBlockController

- (void)dealloc
{
    NSLog(@"ZGBlockController dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 怎么破block循环引用
//    [self testBlockRecyle];
    
    // 三种block 全局，栈 堆block
    [self testBlockClass];
    
    
}

#pragma mark  - 三种block 全局，栈 堆block
- (void)testBlockClass
{
    self.zg_stackBlcok = ^(){
        NSLog(@"xxxx");
        NSLog(@"self %@",self);
    };
    
    
    __weak void(^tmpBlock)(void) = ^(void){
        NSLog(@"yyyyyy");
        NSLog(@"self %@",self);
    };
    
    void (^gloableBlock)(void) = ^(void){
        NSLog(@"xxxxxxx");
    };
    
    NSLog(@"zg_stackBlcok %@",self.zg_stackBlcok);
    NSLog(@"tmpBlock %@",tmpBlock);
    NSLog(@"gloableBlock %@",gloableBlock);
    
    // 好神奇的block 正常nsobject类是不能用weak 来引用初始化的
    __weak NSObject *aobj = [NSObject new];
    NSLog(@"aobj %@",aobj);
}

#pragma mark  - 怎么破block循环引用
- (void)testBlockRecyle
{
    
    _p = [[ZGBlockPeople alloc] init];
    [_p setupSayBlock:^(NSString *str) {
        self.name = @"zonggen";
        NSLog(@"%@",str);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            self.name = @"宗根";
            NSLog(@"%@",self.name);
        });
    }];
    
    [_p say];
    
    NSLog(@"%@",self.name);
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [btn addTarget:self action:@selector(didBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)didBtn:(UIButton *)btn
{
    NSLog(@"%@",self.name);
}


@end
