//
//  ZGRegexViewController.m
//  ZGTextProj
//
//  Created by XuZongGen on 2019/12/24.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGRegexViewController.h"

#import "RegexKitLite.h"

@interface ZGRegexViewController ()

@end

@implementation ZGRegexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // @[scheme]://@[ip]@[path]?wsHost=@[host]&wsiphost=ipdbm
    NSMutableString *format = [NSMutableString stringWithString:@"@[scheme]://@[ip]@[path]?wsHost=@[host]&wsiphost=ipdbm"];
    NSLog(@"format %@",format);
    [format replaceOccurrencesOfRegex:@"@\\[url]" withString:@"http://www.baidu.com"];
    [format replaceOccurrencesOfRegex:@"@\\[scheme]" withString:@"rtmp"];
    [format replaceOccurrencesOfRegex:@"@\\[host]" withString:@"192.168.1.3"];
    [format replaceOccurrencesOfRegex:@"@\\[path]" withString:@"/abc"];
    [format replaceOccurrencesOfRegex:@"@\\[query]" withString:@""];
    NSLog(@"after format %@",format);
    
    NSLog(@"  - - - -  - - - - - - - - -  ");
    NSString *format2 = @"@[scheme]://@[ip]@[path]?wsHost=@[host]&wsiphost=ipdbm";
    NSLog(@"format2 %@",format2);

    format2 = [format2 stringByReplacingOccurrencesOfString:@"@[url]" withString:@"http://www.baidu.com"];
    format2 = [format2 stringByReplacingOccurrencesOfString:@"@[scheme]" withString:@"rtmp"];
    format2 = [format2 stringByReplacingOccurrencesOfString:@"@[host]" withString:@"192.168.1.3"];
    format2 = [format2 stringByReplacingOccurrencesOfString:@"@[path]" withString:@"/abc"];
    format2 = [format2 stringByReplacingOccurrencesOfString:@"@[query]" withString:@""];
    NSLog(@"after format2 %@",format2);
    
    if ([format2 isEqualToString:format]) {
        NSLog(@"equal");
    }
}

@end
