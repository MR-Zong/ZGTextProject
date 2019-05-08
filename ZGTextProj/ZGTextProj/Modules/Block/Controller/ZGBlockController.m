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

@property (nonatomic, strong) NSArray *zgAry;

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
//    [self testBlockClass];
    
    // ARC下 怎么生成 栈block
    [self testARC_StackBlock];
    
    
    /**
     * 测试 数组是否会强引用元素
     * 结果，是会强引用元素
     */
//    _zgAry = @[@1,self];
    
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


#pragma mark - 测试ARC下 怎么生成 栈block
-(NSArray *) getBlockArray{
    int val =10;
    int val2 =10;
    int val3 =10;
    
    /**
     * 发现 数组中除了第一个block是mallocBlock，其他都会是stackBlock
     * 为什么呢？
     */
    NSArray *blockAry = [NSArray arrayWithObjects:
     ^{NSLog(@"blk0:%d",val);},
     ^{NSLog(@"blk1:%d",val2);},
     ^{NSLog(@"blk2:%d",val3);},nil];
    /**
     * 解决方法：手动叫copy
     */
//    NSArray *blockAry = [NSArray arrayWithObjects:
//                         ^{NSLog(@"blk0:%d",val);},
//                         [^{NSLog(@"blk1:%d",val2);} copy],
//                         [^{NSLog(@"blk2:%d",val3);} copy],nil];
    NSLog(@"blockAry %@",blockAry);
    
    /**
     * 测试 字典会不会同样问题
     * 结果，字典居然没有问题
     */
    NSDictionary *blockDic = @{@"a":^{NSLog(@"blk0:%d",val);},@"b":^{NSLog(@"blk1:%d",val);}};
    NSLog(@"blockDic %@",blockDic);
    return nil;
}

- (void)testARC_StackBlock
{
    NSArray *blockAry = [self getBlockArray];
    typedef void (^blk_t)(void);
    blk_t blk = (blk_t)[blockAry objectAtIndex:0];
    blk();
    
//    void(^bb)(void) = [self returnBlock];
//    bb();

}

-(void(^)(void))returnBlock{
    __block int add=10;
    void(^blk_h)(void)  =^{printf("add=%d\n",++add);};
    return blk_h;
}




@end
