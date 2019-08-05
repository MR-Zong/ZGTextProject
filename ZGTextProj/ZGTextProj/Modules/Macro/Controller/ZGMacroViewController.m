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
//    [self testValuePointer2];
    
    /**
     *  测试 文件空间分配
     */
//    [self testFileAllocation];
    
    
    /**
     * 测试 关联获取不到属性
     */
    [self testAssociation];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - 文件空间分配
- (void)testFileAllocation
{
    // 获取Library中的Cache
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesPath = [paths lastObject];
    NSLog(@"NSCachesDirectory: %@", cachesPath);
    
    NSString *filePath = [self createFile:cachesPath fileName:@"gen.txt"];
    
    // 打开文件 写
    NSFileHandle *writeHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];

    // 注：覆盖了指定位置/指定长度的内容
//    [writeHandle seekToFileOffset:1024*5];
    [writeHandle writeData:[@"CDEFG" dataUsingEncoding:NSUTF8StringEncoding]];
    
//    [writeHandle seekToEndOfFile];
//    [writeHandle writeData:[@"一二三四五六" dataUsingEncoding:NSUTF8StringEncoding]];
    [writeHandle closeFile];
}

// 检查文件、文件夹是否存在
- (BOOL)fileExistsAtPath:(NSString *)path isDirectory:(BOOL *)isDir {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL exist = [fileManager fileExistsAtPath:path isDirectory:isDir];
    return exist;
}

// 创建路径
- (void)createDirectory:(NSString *)path {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    BOOL exist = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    if (!isDir) {
        [fileManager removeItemAtPath:path error:nil];
        exist = NO;
    }
    if (!exist) {
        // 注：直接创建不会覆盖原文件夹
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
}



// 创建文件
- (NSString *)createFile:(NSString *)filePath fileName:(NSString *)fileName {
    
    // 先创建路径
    [self createDirectory:filePath];
    
    // 再创建路径上的文件
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [filePath stringByAppendingPathComponent:fileName];
    BOOL isDir;
    BOOL exist = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    if (isDir) {
        [fileManager removeItemAtPath:path error:nil];
        exist = NO;
    }
    if (!exist) {
        // 注：直接创建会被覆盖原文件
        [fileManager createFileAtPath:path contents:nil attributes:nil];
    }
    return path;
}

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

//    void *a = *ep;
    NSLog(@"ep %@",ep);
    
}

- (void)errParse:(NSError **)err
{
    *err = [NSError errorWithDomain:@"sdfds" code:21 userInfo:nil];
}


#pragma mark - 关联对象
- (void)testAssociation
{
    NSObject *obj = [NSObject new];
    
    void (^tBlock) (NSObject *) = ^(NSObject *this){
        objc_setAssociatedObject(this, @"zong", @"value_zong", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    };
    tBlock(obj);
    
    NSString *value = objc_getAssociatedObject(obj, @"zong");
    NSLog(@"value %@",value);
    
}

@end
