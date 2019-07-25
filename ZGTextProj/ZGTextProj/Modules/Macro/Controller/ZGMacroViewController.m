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
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
