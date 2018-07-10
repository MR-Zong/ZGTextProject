//
//  ZGKVOCSubObserver.h
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/7/10.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZGKVOCBaseOberver.h"


/** static 修饰的全局变量 不能被别的模块访问
 * 所以 这样写在头文件 是错误的，留此警示后人
 * 如果这样放到头文件，其他地方好像可以访问，编译会通过，但其实外部访问同名变量，实际是另外一个新变量
 * 只有本模块访问 才会是正确的那个变量
 */
#warning 千万不要犯这个错误
static void * ZGKVOCSubObserverContext = &ZGKVOCSubObserverContext;

@interface ZGKVOCSubObserver : ZGKVOCBaseOberver

@end
