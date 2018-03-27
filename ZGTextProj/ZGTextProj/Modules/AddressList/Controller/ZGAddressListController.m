//
//  ZGAddressListController.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/9/8.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import "ZGAddressListController.h"
#import "ZGAddressListCell.h"
#import "PinYin4Objc.h"
#import "ZGLetterSectionModel.h"


@interface ZGAddressListController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic,strong)NSArray *indexArray;
@property(nonatomic,strong)NSMutableDictionary *letterModelDic;

@end

@implementation ZGAddressListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 测试
//    NSString *str = @"xhkljhkjhlkh";
//    [self transform:str];
//    [self chineseToPinyin:str];
    
    [self initialize];
    
    [self setupViews];
    
    
}

- (NSString *)transform:(NSString *)chinese
{
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
//    NSLog(@"transform %@", pinyin);
    return [pinyin uppercaseString];
}


- (void)chineseToPinyin:(NSString *)chineseStr
{
    NSString *sourceText = chineseStr;
    HanyuPinyinOutputFormat *outputFormat=[[HanyuPinyinOutputFormat alloc] init];
    [outputFormat setToneType:ToneTypeWithoutTone];
    [outputFormat setVCharType:VCharTypeWithV];
    [outputFormat setCaseType:CaseTypeLowercase];
    
    [PinyinHelper toHanyuPinyinStringWithNSString:sourceText withHanyuPinyinOutputFormat:outputFormat withNSString:@" " outputBlock:^(NSString *pinYin) {
        
        NSLog(@"pinYin %@",pinYin);
        
    }];

}


- (BOOL)indexArray:(NSArray *)indexArray cotainLetter:(NSString *)letter
{
    for (NSString *str in indexArray) {
        if ([str isEqualToString:letter]) {
            return YES;
        }
    }
    return NO;
}

- (void)indexArrayAndLetterResultArrWithStringsArray:(NSArray *)stringArray
{
    NSMutableArray *indexArray = [NSMutableArray arrayWithCapacity:stringArray.count];
    for (NSString *str in stringArray){
        if (str.length == 0) {
            continue;
        }
        NSString *pinYinString = [self transform:str];
        //3.去除掉首尾的空白字符和换行字符
        pinYinString = [pinYinString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString *pinYinFirstChar = [pinYinString substringToIndex:1];
        
        NSString *letter = pinYinFirstChar;
        if ([self indexArray:indexArray cotainLetter:letter] == NO) {
            [indexArray addObject:letter];
        }
        
        ZGLetterSectionModel *model = self.letterModelDic[letter];
        if (model) {
            [model.stringsArray addObject:str];
        }else {
            model = [ZGLetterSectionModel letterSectionWithLetter:letter string:str];
        }
        [self.letterModelDic setObject:model forKey:letter];
        
    }
    
    NSArray *indexArraySort = [indexArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSLiteralSearch];
    }];
    self.indexArray = indexArraySort;
}




- (void)initialize
{
    NSArray *stringsToSort = [NSArray arrayWithObjects:
                              @"￥hhh, .$",@" ￥Chin ese ",@"开源中国 ",@"www.oschina.net",
                              @"开源技术",@"社区",@"开发者",@"传播",
                              @"2014",@"a1",@"100",@"中国",@"暑假作业",
                              @"键盘", @"鼠标",@"hello",@"world",@"b1",
                              nil];
    
    _letterModelDic = [NSMutableDictionary dictionary];
    [self indexArrayAndLetterResultArrWithStringsArray:stringsToSort];
    
}

- (void)setupViews
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.sectionIndexColor = [UIColor greenColor];
    [_tableView registerClass:[ZGAddressListCell class] forCellReuseIdentifier:ZGAddressListCellReusedID];
    [self.view addSubview:_tableView];
}


#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indexArray;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *key = [self.indexArray objectAtIndex:section];
    return key;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.indexArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *letter = self.indexArray[section];
    ZGLetterSectionModel *model = self.letterModelDic[letter];
    return model.stringsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZGAddressListCell *cell = [tableView dequeueReusableCellWithIdentifier:ZGAddressListCellReusedID];
    NSString *letter = self.indexArray[indexPath.section];
    ZGLetterSectionModel *model = self.letterModelDic[letter];
    cell.textLabel.text = model.stringsArray[indexPath.row];
    return cell;
}

//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
//{
//    return index;
//}

#pragma mark - UITableViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *lab = [UILabel new];
    lab.backgroundColor = [UIColor groupTableViewBackgroundColor];
    lab.text = [self.indexArray objectAtIndex:section];
    lab.textColor = [UIColor whiteColor];
    return lab;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *letter = self.indexArray[indexPath.section];
    ZGLetterSectionModel *model = self.letterModelDic[letter];
    NSString *message = model.stringsArray[indexPath.row];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"YES" otherButtonTitles:nil];
    [alert show];
}



@end
