//
//  NSString+ZGMD5.m
//  ZGTextProj
//
//  Created by XuZongGen on 2019/11/6.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "NSString+ZGMD5.h"

#import <CommonCrypto/CommonDigest.h>


@implementation NSString (ZGMD5)


- (NSString *)md5String {
    const char *source = [self UTF8String];
    unsigned char md5[CC_MD5_DIGEST_LENGTH];
    CC_MD5(source, (CC_LONG)strlen(source), md5);
    
    NSString *retString = [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                           md5[0], md5[1], md5[2], md5[3], md5[4], md5[5],
                           md5[6], md5[7], md5[8], md5[9], md5[10],
                           md5[11], md5[12], md5[13], md5[14], md5[15]];
    return retString;
}

@end
