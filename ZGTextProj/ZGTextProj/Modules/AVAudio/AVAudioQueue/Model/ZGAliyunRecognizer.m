//
//  ZGAliyunRecognizer.m
//  ZGTextProj
//
//  Created by ali on 2019/3/15.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGAliyunRecognizer.h"

#import "AliyunNlsSdk/NlsVoiceRecorder.h"
#import "AliyunNlsSdk/NlsSpeechRecognizerRequest.h"
#import "AliyunNlsSdk/RecognizerRequestParam.h"
#import "AliyunNlsSdk/AliyunNlsClientAdaptor.h"
#import "AliyunNlsSdk/AccessToken.h"

@interface ZGAliyunRecognizer()<NlsSpeechRecognizerDelegate>{
    Boolean recognizerStarted;
}

@property(nonatomic,strong) NlsClientAdaptor *nlsClient;
@property(nonatomic,strong) NlsSpeechRecognizerRequest *recognizeRequest;
@property(nonatomic,strong) RecognizerRequestParam *recognizeRequestParam;

@end

@implementation ZGAliyunRecognizer

- (instancetype)init {
    if (self = [super init]) {
        ;
        //1. 全局参数初始化操作
        //1.1 初始化识别客户端,将recognizerStarted状态置为false
        _nlsClient = [[NlsClientAdaptor alloc]init];
        recognizerStarted = false;
        //1.3 初始化识别参数类
        _recognizeRequestParam = [[RecognizerRequestParam alloc]init];
        //1.4 设置log级别
        [_nlsClient setLog:NULL logLevel:LOGINFO];
    }
    return self;
}

- (void)startRecognize {
    if (recognizerStarted) {
        NSLog(@"already started!");
        return;
    }
    //2. 创建请求对象和开始识别
    if(_recognizeRequest!= NULL){
        [_recognizeRequest releaseRequest];
        _recognizeRequest = NULL;
    }
    //2.1 创建请求对象，设置NlsSpeechRecognizerDelegate回调
    _recognizeRequest = [_nlsClient createRecognizerRequest];
    _recognizeRequest.delegate = self;
    
    //2.2 设置RecognizerRequestParam请求参数
    [_recognizeRequestParam setFormat:@"opu"];
    [_recognizeRequestParam setEnableIntermediateResult:true];
    //请使用https://help.aliyun.com/document_detail/72153.html 动态生成token
    //或者采用本Demo的_generateTokeng方法获取token
    // <AccessKeyId> <AccessKeySecret> 请使用您的阿里云账户生成 https://ak-console.aliyun.com/
    [_recognizeRequestParam setToken:@"2a162ccd03d941c497c5313ff84aa9d3"];
    //    [_recognizeRequestParam setToken:[self _generateToken:@"AccessKeyId" withSecret:@"AccessKeyId"]];
    //请使用阿里云语音服务管控台(https://nls-portal.console.aliyun.com/)生成您的appkey
    [_recognizeRequestParam setAppkey:@"pESkkpmclH3AENzd"];
    
    //2.3 传入请求参数
    [_recognizeRequest setRecognizeParams:_recognizeRequestParam];
    
    //2.4 启动录音和识别，将recognizerStarted置为
    [_recognizeRequest start];
    recognizerStarted = true;
}

- (void)stopRecognize {
    //3 结束识别 停止录音，停止识别请求
    [_recognizeRequest stop];
    recognizerStarted = false;
    _recognizeRequest = NULL;
}

/**
 *4. NlsSpeechRecognizerDelegate回调方法
 */
//4.1 识别回调，本次请求失败
-(void)OnTaskFailed:(NlsDelegateEvent)event statusCode:(NSString*)statusCode errorMessage:(NSString*)eMsg{
    recognizerStarted = false;
    NSLog(@"OnTaskFailed, error message is: %@",eMsg);
}

//4.2 识别回调，服务端连接关闭
-(void)OnChannelClosed:(NlsDelegateEvent)event statusCode:(NSString*)statusCode errorMessage:(NSString*)eMsg{
    recognizerStarted = false;
    NSLog(@"OnChannelClosed, statusCode is: %@",statusCode);
}

//4.3 识别回调，识别结果结束
-(void)OnRecognizedCompleted:(NlsDelegateEvent)event result:(NSString *)result statusCode:(NSString*)statusCode errorMessage:(NSString*)eMsg{
    recognizerStarted = false;
    dispatch_async(dispatch_get_main_queue(), ^{
        // UI更新代码
        self.textView.text = result;
        NSLog(@"%@", result);
    });
}

//4.4 识别回调，识别中间结果
-(void)OnRecognizedResultChanged:(NlsDelegateEvent)event result:(NSString *)result statusCode:(NSString*)statusCode errorMessage:(NSString*)eMsg{
    dispatch_async(dispatch_get_main_queue(), ^{
        // UI更新代码
        NSLog(@"%@", result);
        self.textView.text = result;
    });
}

#pragma mark - -  - -  -
//5.1 录音数据回调
- (void)voiceRecorded:(NSData *)frame {
    if (_recognizeRequest != nil &&recognizerStarted) {
        //录音线程回调的数据传给识别服务
        NSLog(@"frame.len %zd",frame.length);
        [_recognizeRequest sendAudio:frame length:(short)frame.length];
    }
}

- (void)voiceVolume:(NSInteger)volume {
    // onVoiceVolume if you need.
}

/**
 *生成AccessToken的iOS实现
 *为安全考虑，我们建议您不要使用这个接口生成token
 *建议您采用服务端生成token，分发到服务端使用。
 *expireTime 为本次token的过期时间
 */

-(NSString*)_generateToken:(NSString*)accessKey withSecret:(NSString*)accessSecret{
    AccessToken *accessToken = [[AccessToken alloc]initWithAccessKeyId:accessKey andAccessSecret:accessSecret];
    [accessToken apply];
    NSLog(@"Token expire time is %ld",[accessToken expireTime]);
    return [accessToken token];
}


@end
