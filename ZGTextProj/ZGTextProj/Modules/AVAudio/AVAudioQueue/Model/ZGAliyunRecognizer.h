//
//  ZGAliyunRecognizer.h
//  ZGTextProj
//
//  Created by ali on 2019/3/15.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZGAliyunRecognizer : NSObject

@property (nonatomic, weak) UITextView *textView;

- (void)voiceRecorded:(NSData *)frame;

- (void)startRecognize;
- (void)stopRecognize;
@end

NS_ASSUME_NONNULL_END
