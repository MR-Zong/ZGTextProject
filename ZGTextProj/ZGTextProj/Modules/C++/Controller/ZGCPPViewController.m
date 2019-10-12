//
//  ZGC++ViewController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2019/8/24.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGCPPViewController.h"

static NSString *const kLZCdnAudioDomainWhiteListPattern = @"^cdnauth\\w*\\.\\w+\\.\\w+$";

typedef NS_OPTIONS(NSInteger, ZGTestFLagOp) {
    ZGTestFLagOpHttp = 1<<0, // 1 做过
    ZGTestFLagOpTcp = 1<<1,// 1 做过
    ZGTestFLagOpPriorityHttp = 1 << 2, // http 优先
};


@interface ZGCPPViewController ()

@property (nonatomic, assign) ZGTestFLagOp op;

@end

@implementation ZGCPPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    
//    NSString *text = @"zong";
//    int w = [text ];
    
    // bundle 地址
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"img.jpg" ofType:nil];
    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    NSString *host = [fileUrl host];
    
    // 网络地址
    NSString *testPath = @"http:///baidu/index";
    NSURL *testUrl = [NSURL URLWithString:testPath];
    
    
    // 沙盒地址 获取cache目录路径
    NSString *cachesDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES) firstObject];
    NSURL *shaheUrl = [NSURL fileURLWithPath:[cachesDir stringByAppendingPathComponent:@"zong.txt"]];
    
    
    [self isMatchWhiteListPatternWithUrl:testUrl];
    
    // 测试三元操作符 的省略写法
    NSLog(@"sanYuan %d",188?:9);
    
    
    /**
     * 理解 __has_include 的作用
     * 此宏传入一个你想引入文件的名称作为参数，如果该文件能够被引入则返回1，否则返回0。
     * 本质是检测到某个文件,是否在工程中被包含（注意是工程，在工程中说明可以引用该文件）
     */
#if __has_include("xxx.h")
    NSLog(@"能包含");
#else
//    NSLog(@"不能包含");
#endif
    
//    [self testSwitch];
    [self testFlag:NO];
}

#pragma mark - 白名单规则
- (BOOL)isMatchWhiteListPatternWithUrl:(NSURL *)url
{
    if (url.absoluteString.length == 0) {
        NSLog(@"url length == 0，url %@",url.absoluteString);
        return NO;
    }
    if ([url isFileURL]) {
        NSLog(@"url isFileURL，url %@",url.absoluteString);
        
        return NO;
    }
    NSString *host = [url host];
    if (host.length == 0) {
        NSLog(@"host 为空，url %@",url.absoluteString);
        return NO;
    }
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:kLZCdnAudioDomainWhiteListPattern options:0 error:nil];
    NSArray *results = [regex matchesInString:host options:0 range:NSMakeRange(0, host.length)];
    BOOL isMath = results.count>0?YES:NO;
    return isMath;
}

- (void)testSwitch
{
    int a = 9;
    switch (a) {
        case 1:
            NSLog(@"1");
            break;
            
        default:
            NSLog(@"default");
            break;
    }
    
    // int 类型的内存大小
    NSLog(@"sizeof(int) %zd",sizeof(int));
    NSLog(@"sizeof(int8_t) %zd",sizeof(int8_t));
    NSLog(@"sizeof(int16_t) %zd",sizeof(int16_t));
    NSLog(@"sizeof(int32_t) %zd",sizeof(int32_t));
    NSLog(@"sizeof(int64_t) %zd",sizeof(int64_t));
}

- (void)testFlag:(BOOL)httpFirst
{
    if ( (_op & ZGTestFLagOpHttp) && (_op & ZGTestFLagOpTcp)) {
        NSLog(@"HTTP AND TCP ALL DONE");
        return;
    }
    
    if (_op == 0 && httpFirst) _op |= ZGTestFLagOpPriorityHttp;
    
    
    if ( (_op&ZGTestFLagOpPriorityHttp) && !(_op & ZGTestFLagOpHttp) ) {
        NSLog(@"DO HTTP");
        _op |= ZGTestFLagOpHttp;
        [self testFlag:httpFirst];
    }else {
        NSLog(@"DO TCP");
        _op |= ZGTestFLagOpTcp;
        _op |= ZGTestFLagOpPriorityHttp;
        [self testFlag:httpFirst];
    }
    
    
}


@end
