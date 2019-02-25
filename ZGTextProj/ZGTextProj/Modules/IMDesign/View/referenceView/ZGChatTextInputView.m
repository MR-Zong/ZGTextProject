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
CGFloat const kMaxTextViewHeight = 68;
NSString *const kTextViewContentSize = @"contentSize";

@interface ZGChatTextInputView () <UITextViewDelegate>{
    UIViewAnimationCurve _animationCurve;
    CGFloat _animationDuration;
    CGFloat _keyboardHeight;
}

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *audioInputBtn;
@property (nonatomic, strong) UIButton *sendBtn;
@property (nonatomic, assign) CGFloat textView_h;
@property (nonatomic, assign) CGFloat keyboardShowBaseY;
@property (nonatomic, assign) CGFloat keyboardShowBaseContentInsetBottom;

/** 是否系统键盘显示 */
@property (nonatomic, assign, getter=isShowingSystemKeyboard) BOOL showingSystemKeyboard;

@end

@implementation ZGChatTextInputView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_textView removeObserver:self forKeyPath:kTextViewContentSize];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor redColor];
        [self setupConfig];
        
        _textView = [[UITextView alloc] init];
        _textView.backgroundColor = [UIColor purpleColor];
        _textView.delegate = self;
        [_textView addObserver:self forKeyPath:kTextViewContentSize options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
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
    _textView_h = 30;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.textView.frame = CGRectMake(10, 5, ZG_SCREEN_W - 20, _textView_h);
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

#pragma mark - 事件监听 键盘弹出
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
        CGRect tmpF = self.frame;
        tmpF.origin.y = ZG_SCREEN_H - self.frame.size.height - _keyboardHeight;
        self.frame = tmpF;
        self.keyboardShowBaseY = self.frame.origin.y;
        
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, self.frame.size.height + _keyboardHeight+ZGCHAT_TABLEVIEW_CONTENTINESET_PADDING, 0);
        self.keyboardShowBaseContentInsetBottom = self.tableView.contentInset.bottom;
    } completion:nil];
    
}


- (void)keyboardWillHide:(NSNotification *)noti {
    self.showingSystemKeyboard = NO;

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

#pragma mark -
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    CGSize contentSize_old = [change[NSKeyValueChangeOldKey] CGSizeValue];
    if (contentSize_old.height < 0) {
        return;
    }
    CGSize contentSize_new = [change[NSKeyValueChangeNewKey] CGSizeValue];
    CGFloat offsetH = self.textView.textContainerInset.top;
    if (contentSize_new.height == 30) {
        offsetH = 0;
    }

    [UIView animateWithDuration:0.25 animations:^{
        
        _textView_h = contentSize_new.height +offsetH;
        if (_textView_h > kMaxTextViewHeight) {
            _textView_h = kMaxTextViewHeight;
        }
        CGRect tmpF = self.textView.frame;
        tmpF.size.height = _textView_h;
        self.textView.frame = tmpF;
        
        self.audioInputBtn.frame = CGRectMake(10, CGRectGetMaxY(self.textView.frame)+5, kChatInputeBtnH, kChatInputeBtnH);
        CGFloat sendbt_w = 60;
        self.sendBtn.frame = CGRectMake(self.frame.size.width-sendbt_w -10, CGRectGetMaxY(self.textView.frame)+5, sendbt_w, kChatInputeBtnH);
        
        
        tmpF = self.frame;
        tmpF.size.height = _textView_h + kChatInputeBtnH + 3*5;
        tmpF.origin.y = self.keyboardShowBaseY - (tmpF.size.height - ZGChatTextInputView_H);
        self.frame = tmpF;
        
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, self.keyboardShowBaseContentInsetBottom+(tmpF.size.height - ZGChatTextInputView_H), 0);
    }];
}


#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {

    ;
}



- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {

    if ([text isEqualToString:@"\n"]) {
        [self didSend:nil];
        return NO;
    }
    return YES;
    
}

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
    self.textView.text = nil;
    [self textViewDidChange:self.textView];
}

@end
