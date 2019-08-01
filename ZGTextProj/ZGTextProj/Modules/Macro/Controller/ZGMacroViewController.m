//
//  ZGMacroViewController.m
//  ZGTextProj
//
//  Created by XuZongGen on 2019/7/25.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGMacroViewController.h"
#import <objc/message.h>

#import "ZGTestSelector.h"

#define macro(args) args

@interface ZGMacroViewController ()

@end

@implementation ZGMacroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    macro({
        NSLog(@"safsa");
        NSLog(@"safsa");
        NSLog(@"safsa");
        NSLog(@"safsa");
    })
    
    
    id md = [ZGTestSelector alloc];
//    [md init];
//    ZGTestSelector *ss = [md performSelector:@selector(init) withObject:nil];
    NSData *data = [NSData new];
    ((id (*)(id, SEL, NSData *))objc_msgSend)(md, NSSelectorFromString(@"initWithData:"), data);
    
    
    /**
     * 测试 NSValue 放指针的时候 ,崩溃问题
     */
    [self testValuePointer2];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -  测试 NSValue 放指针的时候 ,崩溃问题
- (void)testValuePointer
{
  
    int num = 10;
    int *p = &num;
    NSValue *value1 = [NSValue valueWithPointer:p];
    int *p2 = (int*)[value1 pointerValue];
     NSLog(@"num = %d",*(p2));
    
    
    
//    [NSJSONSerialization];
    NSError *err = [NSError errorWithDomain:@"gen" code:8 userInfo:nil];
    NSLog(@"err %@ , &err %p",err,&err);
    NSValue *value  = [NSValue valueWithBytes:&err objCType:@encode(NSError *)];
//    err = nil;

    @try {
        // 测试 NSValue 放指针的时候 ,崩溃问题
        // 因为err  和 ep 都指向d同一个对象,但retainCount 还是1
        // 所以 在函数退出时候,系统会对err ep 置nil ,因为err ep 都是strong 所以会err release 再对ep release 对同一个对象两次release,所以会崩溃
        __weak NSError *ep = nil; // 这里必须用weak 否则会崩溃
        if (@available(iOS 11.0, *)) {
            [value getValue:&ep size:sizeof(NSError *)];
        } else {
            // Fallback on earlier versions
        }
        NSLog(@"ep %@",ep);


        ep = [NSError errorWithDomain:@"zong" code:78 userInfo:nil];
        NSLog(@"ep %@",ep);

    } @catch (NSException *exception) {
        NSLog(@"exception %@",exception);
    } @finally {
        NSLog(@"xxxx");
    }
    
    
}

- (void)testValuePointer2
{
    
    //    [NSJSONSerialization];
    NSError *err = [NSError errorWithDomain:@"gen" code:8 userInfo:nil];
    NSLog(@"err %@ , &err %p",err,&err);
    NSValue *value  = [NSValue valueWithPointer:(void *)&err];
    
    
    void *ep = (void *)value.pointerValue;
    void *a = *ep;
    
    
    
    
    
    
    NSLog(@"ep %@",ep);
    
}

- (void)errParse:(NSError **)err
{
    *err = [NSError errorWithDomain:@"sdfds" code:21 userInfo:nil];
}

@end
