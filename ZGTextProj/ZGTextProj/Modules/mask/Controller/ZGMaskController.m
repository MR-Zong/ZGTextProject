//
//  ZGMaskController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/7/28.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import "ZGMaskController.h"

@interface ZGMaskController ()

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation ZGMaskController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Mask";
    
    
    /**
     * selector SEL 测试这两个本质是什么
     */
//    [self testSEL];
//
//    [self setupViews];
    
//    [self maskLayer];
    
    /**
     * 测试 修改文件属性
     */
    [self testFileProperty];
}

#pragma mark - 文件操作相关
+ (NSString *)cachesDir {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
}

+ (BOOL)isExistsAtPath:(NSString *)path {
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

+ (NSString *)directoryAtPath:(NSString *)path {
    return [path stringByDeletingLastPathComponent];
}

+ (BOOL)createDirectoryAtPath:(NSString *)path error:(NSError *__autoreleasing *)error {
    NSFileManager *manager = [NSFileManager defaultManager];
    /* createDirectoryAtPath:withIntermediateDirectories:attributes:error:
     * 参数1：创建的文件夹的路径
     * 参数2：是否创建媒介的布尔值，一般为YES
     * 参数3: 属性，没有就置为nil
     * 参数4: 错误信息
     */
    BOOL isSuccess = [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:error];
    return isSuccess;
}

+ (BOOL)createFileAtPath:(NSString *)path overwrite:(BOOL)overwrite error:(NSError *__autoreleasing *)error {
    // 如果文件夹路径不存在，那么先创建文件夹
    NSString *directoryPath = [self directoryAtPath:path];
    if (![self isExistsAtPath:directoryPath]) {
        // 创建文件夹
        if (![self createDirectoryAtPath:directoryPath error:error]) {
            return NO;
        }
    }
    // 如果文件存在，并不想覆盖，那么直接返回YES。
    if (!overwrite) {
        if ([self isExistsAtPath:path]) {
            return YES;
        }
    }
    /*创建文件
     *参数1：创建文件的路径
     *参数2：创建文件的内容（NSData类型）
     *参数3：文件相关属性
     */
    BOOL isSuccess = [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
    
    return isSuccess;
}

- (void)testFileProperty
{
//    NSString *filePath = [[self.class cachesDir] stringByAppendingPathComponent:@"gen.mp3"];
//    NSError *error = nil;
//    [self.class createFileAtPath:filePath overwrite:YES error:&error];
//    NSLog(@"path:%@", filePath);
//    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"horse.png" ofType:nil];
    
    [self readFileAttr:filePath];
    
    // 方案一 直接修改文件原有属性  实践发现不可行
//    NSLog(@"\noriginal file attr\n");
//    [self readFileAttr:filePath];
    
//    BOOL change = [fileManager setAttributes:@{NSFileOwnerAccountName:@"zonggen"} ofItemAtPath:filePath error:&error];
//    NSLog(@"\nchange file attr ,change %zd,error %@\n",change,error);
//    [self readFileAttr:filePath];
    
    
    // 方案二 增加拓展属性
//    [self extendedWithPath:filePath key:@"fullUrl" value:[@"http://www.baidu.com" dataUsingEncoding:NSUTF8StringEncoding]];
//
//    NSData *urlData = [self extendedWithPath:filePath key:@"fullUrl"];
//    NSString *value = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
//    [self readFileAttr:filePath];
//    NSLog(@"value %@",value);
//    
}

- (void)readFileAttr:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *fileInfo = [fileManager attributesOfItemAtPath:filePath error:nil];
    NSLog(@"%@",fileInfo);
}

//为文件增加一个扩展属性
- (BOOL)extendedWithPath:(NSString *)path key:(NSString *)key value:(NSData *)value
{
    NSDictionary *extendedAttributes = [NSDictionary dictionaryWithObject:
                                        [NSDictionary dictionaryWithObject:value forKey:key]
                                                                   forKey:@"NSFileExtendedAttributes"];
    
    NSError *error = NULL;
    BOOL sucess = [[NSFileManager defaultManager] setAttributes:extendedAttributes
                                                   ofItemAtPath:path error:&error];
    return sucess;
}
//读取文件扩展属性
- (NSData *)extendedWithPath:(NSString *)path key:(NSString *)key
{
    NSError *error = NULL;
    NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:&error];
    if (!attributes) {
        return nil;
    }
    NSDictionary *extendedAttributes = [attributes objectForKey:@"NSFileExtendedAttributes"];
    if (!extendedAttributes) {
        return nil;
    }
    return [extendedAttributes objectForKey:key];
}


#pragma mark - ---

- (void)testSEL
{
    SEL s = @selector(setupViews);
}


- (void)setupViews
{
    _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 200, 40)];
    _textLabel.text = @"你又从西厢过，十多年后才有盼头";
    _textLabel.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_textLabel];
    
    
    [self createFadeRightMask];
    CABasicAnimation *basicAnimation = [CABasicAnimation animation];
    basicAnimation.keyPath = @"transform.translation.x";
    basicAnimation.fromValue = @(0);
    basicAnimation.toValue = @(_textLabel.bounds.size.width);
    basicAnimation.duration = 4.0;
    basicAnimation.repeatCount = LONG_MAX;
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.fillMode = kCAFillModeForwards;
    [_textLabel.layer.mask addAnimation:basicAnimation forKey:nil];
    
    
}



- (void)createFadeRightMask{
//    [self.AxcfrontLabel.layer removeAllAnimations];
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = self.textLabel.bounds;
    layer.colors = @[(id)[UIColor clearColor],(id)[UIColor redColor].CGColor,(id)[UIColor blackColor].CGColor,(id)[UIColor clearColor].CGColor];
    layer.locations = @[@(0.01),@(0.1),@(0.9),@(0.99)];
    
    self.textLabel.layer.mask = layer;
}



- (void)maskLayer
{
//    self.maskLayer.frame = CGRectInset(self.bounds, self.edgeWidth, self.edgeWidth);
//    CGFloat radius = self.maskLayer.bounds.size.width /2.0;
//    NSLog(@"radius %f",radius);
//    //    CGRect roundRect = CGRectInset(self.maskLayer.bounds, self.edgeWidth, self.edgeWidth);
//    CGRect roundRect =  self.maskLayer.bounds;
//    //    self.maskLayer.path = [[UIBezierPath bezierPathWithRoundedRect:roundRect cornerRadius:radius] bezierPathByReversingPath].CGPath;
//    self.maskLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.maskLayer.bounds.size.width/2.0, self.maskLayer.bounds.size.width/2.0) radius:radius startAngle:0 endAngle:2*M_PI clockwise:YES].CGPath;
//    self.mask = self.maskLayer;
}


@end
