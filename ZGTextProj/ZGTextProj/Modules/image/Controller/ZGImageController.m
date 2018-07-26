//
//  ZGImageController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/7/25.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGImageController.h"

@interface ZGImageController ()

@end

@implementation ZGImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"title";
    
    [self testPNGToJpg];
//    [self testCGImageData];
//    [self testImageData];
//    [self testImage];
}

- (void)testImage
{
    UIImage *img = [UIImage imageNamed:@"kid_bottom_list_icon_clean"];
    NSLog(@"wid %f, hei %f",img.size.width,img.size.height);
}

- (void)testImageData
{
    // news_pop_six_winged_demon@2x
//    NSString *fileP = [[NSBundle mainBundle] pathForResource:@"news_pop_six_winged_demon@2x" ofType:@"png"];
//    NSData *data = [NSData dataWithContentsOfFile:fileP];
//    NSLog(@"data.len %ld",data.length);
//    UIImage *img1 = [UIImage imageWithData:data];
//     UIImage *img2 = [UIImage imageWithContentsOfFile:fileP];
    
//    CGFloat cgImageBytesPerRow = CGImageGetBytesPerRow(img2.CGImage);
//    CGFloat cgImageHeight = CGImageGetHeight(img2.CGImage);
//    NSUInteger size  = cgImageHeight * cgImageBytesPerRow;
//    NSLog(@"size:%lu",(unsigned long)size);
    
    // 证明 UIImagePNGRepresentation 生成的data.length 就是图片文件大小
    UIImage *img = [UIImage imageNamed:@"news_pop_six_winged_demon"];
//    UIImage *img4 = [UIImage imageNamed:@"kid_bottom_list_icon_clean"];
//    NSLog(@"wid %f, hei %f",img.size.width,img.size.height);
//    NSData *imgData = UIImagePNGRepresentation(img);
//    NSLog(@"imgData.len %ld",imgData.length);
//    NSString *saveFileDocument = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask , YES) firstObject];
//    NSLog(@"saveFileDocument %@",saveFileDocument);
//    NSString *fileName = [saveFileDocument stringByAppendingPathComponent:@"img.png"];
//    [imgData writeToFile:fileName atomically:YES];
//
//    NSData *filedata = [NSData dataWithContentsOfFile:fileName];
//    NSLog(@"filedata.len %ld",filedata.length);
    
    
}

- (void)testCGImageData
{
    UIImage *image = [UIImage imageNamed:@"news_pop_six_winged_demon"];
    CFDataRef bitmapData = CGDataProviderCopyData(CGImageGetDataProvider(image.CGImage));
    NSUInteger len =  CFDataGetLength(bitmapData);
    CFRelease(bitmapData);
    NSLog(@"len %ld",len);
}

- (void)testPNGToJpg
{
    UIImage *image = [UIImage imageNamed:@"news_pop_six_winged_demon"];
    NSData *imageData = UIImageJPEGRepresentation(image,1);
    NSLog(@"imageData.len %ld",imageData.length);
    NSString *saveFileDocument = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask , YES) firstObject];
    NSLog(@"saveFileDocument %@",saveFileDocument);
    NSString *fileName = [saveFileDocument stringByAppendingPathComponent:@"img.jpg"];
    [imageData writeToFile:fileName atomically:YES];
    
    
    UIImage *img2 = [UIImage imageWithContentsOfFile:fileName];
    CFDataRef bitmapData = CGDataProviderCopyData(CGImageGetDataProvider(img2.CGImage));
    NSUInteger len =  CFDataGetLength(bitmapData);
    CFRelease(bitmapData);
    
    NSUInteger width = CGImageGetWidth(img2.CGImage);
     NSUInteger height = CGImageGetHeight(img2.CGImage);
     NSUInteger bitsPerComponent = CGImageGetBitsPerComponent(img2.CGImage);
    NSUInteger bitsPerPixel = CGImageGetBitsPerPixel(img2.CGImage);
    NSUInteger bytesPerRow = CGImageGetBytesPerRow(img2.CGImage);
    CGBitmapInfo info = CGImageGetBitmapInfo(img2.CGImage);
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(img2.CGImage);
    NSLog(@"len %ld",len);
    NSLog(@"bytesPerRow *height %ld",bytesPerRow *height);
    NSLog(@"alphaInfo %u",alphaInfo);
    
    NSLog(
          @"\n"
          "===== %@ =====\n"
          "CGImageGetHeight: %d\n"
          "CGImageGetWidth:  %d\n"
          "CGImageGetColorSpace: %@\n"
          "CGImageGetBitsPerPixel:     %d\n"
          "CGImageGetBitsPerComponent: %d\n"
          "CGImageGetBytesPerRow:      %d\n"
          "CGImageGetBitmapInfo: 0x%.8X\n"
          "  kCGBitmapAlphaInfoMask     = %s\n"
          "  kCGBitmapFloatComponents   = %s\n"
          "  kCGBitmapByteOrderMask     = %s\n"
          "  kCGBitmapByteOrderDefault  = %s\n"
          "  kCGBitmapByteOrder16Little = %s\n"
          "  kCGBitmapByteOrder32Little = %s\n"
          "  kCGBitmapByteOrder16Big    = %s\n"
          "  kCGBitmapByteOrder32Big    = %s\n",
          fileName,
          (int)width,
          (int)height,
          CGImageGetColorSpace(img2.CGImage),
          (int)bitsPerPixel,
          (int)bitsPerComponent,
          (int)bytesPerRow,
          (unsigned)info,
          (info & kCGBitmapAlphaInfoMask)     ? "YES" : "NO",
          (info & kCGBitmapFloatComponents)   ? "YES" : "NO",
          (info & kCGBitmapByteOrderMask)     ? "YES" : "NO",
          (info & kCGBitmapByteOrderDefault)  ? "YES" : "NO",
          (info & kCGBitmapByteOrder16Little) ? "YES" : "NO",
          (info & kCGBitmapByteOrder32Little) ? "YES" : "NO",
          (info & kCGBitmapByteOrder16Big)    ? "YES" : "NO",
          (info & kCGBitmapByteOrder32Big)    ? "YES" : "NO"
          );
    
}

@end
