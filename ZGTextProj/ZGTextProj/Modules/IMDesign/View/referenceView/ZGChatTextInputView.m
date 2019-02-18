//
//  ZGChatTextInputView.m
//  ZGTextProj
//
//  Created by ali on 2019/2/18.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGChatTextInputView.h"
#import <Masonry.h>
#import "ZGChatConst.h"

CGFloat ZGChatTextInputView_H = 65;
CGFloat kChatInputeBtnH = 20;

@interface ZGChatTextInputView () <UITextViewDelegate>{
    UIViewAnimationCurve _animationCurve;
    CGFloat _animationDuration;
    CGFloat _keyboardHeight;
}

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *audioInputBtn;
@property (nonatomic, strong) UIButton *sendBtn;

/** 是否系统键盘显示 */
@property (nonatomic, assign, getter=isShowingSystemKeyboard) BOOL showingSystemKeyboard;

@end

@implementation ZGChatTextInputView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor redColor];
        [self setupConfig];
        
        _textView = [[UITextView alloc] init];
        _textView.backgroundColor = [UIColor purpleColor];
        _textView.delegate = self;
        [self addSubview:_textView];
        
        _audioInputBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _audioInputBtn.backgroundColor = [UIColor greenColor];
        [self addSubview:_audioInputBtn];
        
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendBtn.backgroundColor = [UIColor orangeColor];
        [_sendBtn setTitle:@"send" forState:UIControlStateNormal];
        [_sendBtn addTarget:self action:@selector(didSend:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_sendBtn];
        
       
    }
    return self;
}

- (void)setupConfig {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.textView.frame = CGRectMake(10, 5, ZG_SCREEN_W - 20, 30);
    self.audioInputBtn.frame = CGRectMake(10, CGRectGetMaxY(self.textView.frame)+5, kChatInputeBtnH, kChatInputeBtnH);
    CGFloat sendbt_w = 60;
    self.sendBtn.frame = CGRectMake(self.frame.size.width-sendbt_w -10, CGRectGetMaxY(self.textView.frame)+5, sendbt_w, kChatInputeBtnH);
}

- (BOOL)becomeFirstResponder
{
    BOOL b = [super becomeFirstResponder];
    [self.textView becomeFirstResponder];
    return b;
}

#pragma mark - 事件监听
/**
 *  键盘弹出
 *
 *  @param notice 通知
 */
- (void)keyboardWillShow:(NSNotification *)notice {
    self.showingSystemKeyboard = YES;
    
    NSDictionary *userInfo = [notice userInfo];
    CGRect endFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _keyboardHeight = (endFrame.origin.y != ZG_SCREEN_H) ? endFrame.size.height:0;
    if (!_keyboardHeight) return;
    
    CGRect beginRect = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if(!(beginRect.size.height > 0 && ( fabs(beginRect.origin.y - endRect.origin.y) > 0))) return;
    
    _animationDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    _animationCurve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    [UIView animateWithDuration:_animationDuration delay:0 options:(_animationCurve << 16 | UIViewAnimationOptionBeginFromCurrentState) animations:^{
        // 修改frame
        CGRect tmpF = self.frame;
        tmpF.origin.y = ZG_SCREEN_H - self.frame.size.height - _keyboardHeight;
        self.frame = tmpF;
        
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, self.frame.size.height + _keyboardHeight+ZGCHAT_TABLEVIEW_CONTENTINESET_PADDING, 0);
    } completion:nil];
    
//    // 添加动画
//    if (self.emojiKeyboard) { // 当前展示的是表情键盘
//        [UIView animateWithDuration:_animationDuration delay:0 options:(_animationCurve << 16 | UIViewAnimationOptionBeginFromCurrentState) animations:^{
//            self.emojiView.y = SCREEN_H - kChatEmojiHeight;
//            [self.superview layoutIfNeeded];
//        } completion:^(BOOL finished) {
//            self.emojiView.y = SCREEN_H;
//            self.moreView.y = SCREEN_H - kChatMoreHeight;
//            [self.emojiView removeFromSuperview];
//        }];
//
//    } else if (self.isMoreKeyboard) { // 当前展示的是工具
//        [UIView animateWithDuration:_animationDuration delay:0 options:(_animationCurve << 16 | UIViewAnimationOptionBeginFromCurrentState) animations:^{
//            self.moreView.y = SCREEN_H - kChatMoreHeight;
//            [self.superview layoutIfNeeded];
//        } completion:^(BOOL finished) {
//            [self.moreView removeFromSuperview];
//        }];
//    }
}


- (void)keyboardWillHide:(NSNotification *)noti {
    self.showingSystemKeyboard = NO;
    //获取键盘的高度
    NSDictionary *userInfo = [noti userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    _keyboardHeight = [aValue CGRectValue].size.height;
    
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    [UIView animateWithDuration:duration delay:0 options:(curve << 16 | UIViewAnimationOptionBeginFromCurrentState) animations:^{
        
        CGRect tmpF = self.frame;
        tmpF.origin.y = ZG_SCREEN_H;
        self.frame = tmpF;
        
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    } completion:nil];
}


//#pragma mark - UITextViewDelegate
//- (void)textViewDidChange:(UITextView *)textView {
//
//    static CGFloat maxHeight = 80.0f;
//    CGRect frame = textView.frame;
//    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
//    CGSize size = [textView sizeThatFits:constraintSize];
//    if (size.height >= maxHeight) {
//        size.height = maxHeight;
//        textView.scrollEnabled = YES;   // 允许滚动
//        [textView scrollRectToVisible:CGRectMake(0, textView.contentSize.height-7.5, textView.contentSize.width, 10) animated:NO];
//    } else {
//        textView.scrollEnabled = NO;    // 不允许滚动，当textview的大小足以容纳它的text的时候，需要设置scrollEnabed为NO，否则会出现光标乱滚动的情况
//    }
//
//    [UIView animateWithDuration:_animationDuration delay:0 options:(_animationCurve << 16 | UIViewAnimationOptionBeginFromCurrentState) animations:^{
//        // 调整整个InputToolBar 的高度
//        self.height = (15 + size.height) - kChatBarHeight < 5 ? kChatBarHeight : 15 + size.height;
//        CGFloat keyboardHeight = _keyboardHeight;
//        if (self.moreBtn.selected) {
//            keyboardHeight = kChatMoreHeight;
//        }
//        else if (self.emojiBtn.selected) {
//            keyboardHeight = kChatEmojiHeight;
//        }
//
//        self.y = SCREEN_H - self.height - keyboardHeight;
//        _tableView.height = self.y - kNavBarHeight;
//        [self layoutIfNeeded];
//    } completion:nil];
//}
//
//
//
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
//    if (!text.length) {
//        NSRange range = [self isPresenceExpressionWithText:textView.text];
//        if (range.length) {
//            [self deleteEmoji:textView.text range:range];
//            return NO;
//        }
//        return YES;
//    }
//    else {
//        // 判断按了return(send) 调用发送内容的方法
//        if ([text isEqualToString:@"\n"]) {
//            !self.sendContent ? : self.sendContent(self.contentModel);
//            [self resetState];
//            return NO;
//        }
//        return YES;
//    }
//}

#pragma mark - 公共方法
- (void)hideKeyboard {
    [self.superview endEditing:YES];
}

#pragma mark -
- (void)didSend:(UIButton *)btn
{
    if (self.sendBlock) {
        ZGChatInputInfoModel *inputInfoModel = [[ZGChatInputInfoModel alloc] init];
        inputInfoModel.text = self.textView.text;
        self.sendBlock(inputInfoModel);
    }
}

@end
