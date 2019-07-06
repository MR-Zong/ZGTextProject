//
//  ZGUrlSessionViewController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2019/7/6.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGUrlSessionViewController.h"


@interface ZGUrlSessionViewController () <NSURLSessionDataDelegate>

/** 接受响应体信息 */
@property (nonatomic, strong) NSFileHandle *handle;
@property (nonatomic, assign) NSInteger totalSize;
@property (nonatomic, assign) NSInteger currentSize;
@property (nonatomic, strong) NSString *fullPath;

@end

@implementation ZGUrlSessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    /**
     * 测试 cdn能否只鉴权 不下载
     */
    [self testCdnAuthorize];
}

#pragma mark - test
- (void)testCdnAuthorize
{
    // 1562149185000
    // http://cdnauth.183me.com/audio/2019/06/27/5051163086446365190_ud.mp3?sign=4026D87B010FB1129E1BA141390D6344B58379937D93100D8318E85C6B6DF5DE&token=85D09D031EFF4F1E4C49F3A74EA67196E39C26B146E7C29F7900743A46FBF80B&t=1563120000000&v=1
    NSURL *url = [NSURL URLWithString:@"http://cdnauth.183me.com/audio/2019/06/27/5051163086446365190_ud.mp3?sign=4026D87B010FB1129E1BA141390D6344B58379937D93100D8318E85C6B6DF5DE&token=85D09D031EFF4F1E4C49F3A74EA67196E39C26B146E7C29F7900743A46FBF80B&t=1563120000000&v=1"];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    [req setValue:@"ios.lizhi.fm" forHTTPHeaderField:@"Referer"];
    //    [req setHTTPMethod:@"HEAD"];  HEAD 请求不走鉴权
    //    [req setValue:@"Bytes=0-24" forHTTPHeaderField:@"Range"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:req];
    [dataTask resume];
}

#pragma mark - NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
willPerformHTTPRedirection:(NSHTTPURLResponse *)response
        newRequest:(NSURLRequest *)request
 completionHandler:(void (^)(NSURLRequest * _Nullable))completionHandler
{
    NSLog(@"willPerformHTTPRedirection");
}


- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(nonnull NSURLResponse *)response completionHandler:(nonnull void (^)(NSURLSessionResponseDisposition))completionHandler
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    NSLog(@"statusCode %zd",httpResponse.statusCode);
    //    [dataTask cancel];
    completionHandler(NSURLSessionResponseCancel);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    NSLog(@"didReceiveData");
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didBecomeDownloadTask:(NSURLSessionDownloadTask *)downloadTask
{
    NSLog(@"didBecomeDownloadTask");
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didBecomeStreamTask:(NSURLSessionStreamTask *)streamTask
{
    NSLog(@"didBecomeStreamTask");
}



#pragma mark ----------------------
#pragma mark NSURLSessionDataDelegate
/**
 *  1.接收到服务器的响应 它默认会取消该请求
 *
 *  @param session           会话对象
 *  @param dataTask          请求任务
 *  @param response          响应头信息
 *  @param completionHandler 回调 传给系统
 */
//-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
//{
//
//    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//    NSLog(@"statusCode %zd",httpResponse.statusCode);
//
//    //获得文件的总大小
//    self.totalSize = response.expectedContentLength;
//
//    //获得文件全路径
//    self.fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
//
//    //创建空的文件
//    [[NSFileManager defaultManager]createFileAtPath:self.fullPath contents:nil attributes:nil];
//
//    //创建文件句柄
//    self.handle = [NSFileHandle fileHandleForWritingAtPath:self.fullPath];
//
//    [self.handle seekToEndOfFile];
//    /*
//     NSURLSessionResponseCancel = 0,取消 默认
//     NSURLSessionResponseAllow = 1, 接收
//     NSURLSessionResponseBecomeDownload = 2, 变成下载任务
//     NSURLSessionResponseBecomeStream        变成流
//     */
//    completionHandler(NSURLSessionResponseAllow);
//}
//
///**
// *  接收到服务器返回的数据 调用多次
// *
// *  @param session           会话对象
// *  @param dataTask          请求任务
// *  @param data              本次下载的数据
// */
//-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
//{
//
//    //写入数据到文件
//    [self.handle writeData:data];
//
//    //计算文件的下载进度
//    self.currentSize += data.length;
//    NSLog(@"%f",1.0 * self.currentSize / self.totalSize);
//
//    self.proessView.progress = 1.0 * self.currentSize / self.totalSize;
//}
//
///**
// *  请求结束或者是失败的时候调用
// *
// *  @param session           会话对象
// *  @param dataTask          请求任务
// *  @param error             错误信息
// */
//-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
//{
//    NSLog(@"%@",self.fullPath);
//
//    //关闭文件句柄
//    [self.handle closeFile];
//    self.handle = nil;
//}




@end
