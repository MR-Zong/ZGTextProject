//
//  ZGFontController.m
//  ZGTextProj
//
//  Created by ali on 2018/9/26.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGFontController.h"

@interface ZGFontController ()
@property (nonatomic, strong) UILabel *label;

@end

@implementation ZGFontController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self printSystemFonts2];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 40)];
    _label.backgroundColor = [UIColor blackColor];
    _label.textColor = [UIColor whiteColor];
    _label.textAlignment = NSTextAlignmentCenter;
    
    UIFont *font = [UIFont fontWithName:@"Cairo-Regular" size:12];
    _label.font = font;
    _label.text = @"لا مزيد من البيانات";
    [self.view addSubview:_label];
}

- (void)printSystemFonts
{
    UIFont *font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    NSLog(@"当前字体。。。 %@",font);
    NSMutableArray *familyNameArray = [[NSMutableArray alloc] init];
    NSArray* familyNamesAll = [UIFont familyNames];
    for (id family in familyNamesAll) {
        NSArray* fonts = [UIFont fontNamesForFamilyName:family];
        for (id font in fonts)
        {
                [familyNameArray addObject:font];
                
            }
        
    }
    NSLog(@"所有字体 %@",familyNameArray);

}

- (void)printSystemFonts2
{
    for (NSString *fontfamilyname in [UIFont familyNames])
    {
        NSLog(@"family:'%@'",fontfamilyname);
        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
        {
            NSLog(@"\tfont:'%@'",fontName);
        }
        NSLog(@"-------------");
    }
    
}


@end
