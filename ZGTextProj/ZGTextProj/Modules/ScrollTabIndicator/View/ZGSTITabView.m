//
//  ZGSTITabView.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2018/7/27.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGSTITabView.h"
#import "ZGSTIScrollManager.h"

@interface ZGSTITabView ()

@property (nonatomic,strong) UIButton *selectedBtn;
@property (nonatomic,strong) UIButton *hotBtn;
@property (nonatomic,strong) UIButton *storyBtn;
@property (nonatomic,strong) UIButton *discoveryBtn;
@property (nonatomic,strong) NSMutableArray *btnsArray;

@property (nonatomic,strong) UIView *indicatorView;


@end


@implementation ZGSTITabView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _btnsArray = [NSMutableArray arrayWithCapacity:5];
        
        _hotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _hotBtn.tag = 0;
        _hotBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_hotBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_hotBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [_hotBtn setTitle:@"热门" forState:UIControlStateNormal];
        [_hotBtn addTarget:self action:@selector(didHotBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_hotBtn];
        [_btnsArray addObject:_hotBtn];
        
        _discoveryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _discoveryBtn.tag = 1;
        _discoveryBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_discoveryBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_discoveryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [_discoveryBtn setTitle:@"发现" forState:UIControlStateNormal];
        [_discoveryBtn addTarget:self action:@selector(didDiscoveryBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_discoveryBtn];
        [_btnsArray addObject:_discoveryBtn];
        
        
        _storyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _storyBtn.tag = 2;
        _storyBtn.titleLabel.font =  [UIFont systemFontOfSize:17];
        [_storyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_storyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [_storyBtn setTitle:@"故事" forState:UIControlStateNormal];
        [_storyBtn addTarget:self action:@selector(didStoryBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_storyBtn];
        [_btnsArray addObject:_storyBtn];
        
        
        CGFloat btnWidth = 60;
        CGFloat btnHeight = 44;
        CGFloat btnMargin = 22;
        for (int i=0; i<_btnsArray.count; i++) {
            UIButton *btn = _btnsArray[i];
            btn.frame = CGRectMake(i * (btnWidth + btnMargin), 0, btnWidth, btnHeight);
        }
        
        // 指示view
        //        _indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height -3, btnWidth, 3)];
        //        UIView *realIndicatorView = [[UIView alloc] initWithFrame:CGRectMake((_indicatorView.bounds.size.width - 16)/2.0, 0, 16, 3)];
        //        realIndicatorView.layer.cornerRadius= 1.5;
        //        realIndicatorView.layer.masksToBounds = YES;
        //        realIndicatorView.backgroundColor = [UIColor kc_colorWithHexValue:0x0e84d7];
        //        realIndicatorView.themeMap = @{
        //                                       kCXTThemeSelectorUIViewBackgroundColor:key_cxt_theme_color_main,
        //                                       };
        //        [_indicatorView addSubview:realIndicatorView];
        //        [self addSubview:_indicatorView];
        
        
        _indicatorView = [[UIView alloc] initWithFrame:CGRectMake((btnWidth - 16)/2.0, self.bounds.size.height - 3, 16, 3)];
        _indicatorView.layer.cornerRadius= 1.5;
        _indicatorView.layer.masksToBounds = YES;
        _indicatorView.backgroundColor = [UIColor orangeColor];
        [self addSubview:_indicatorView];
        
        // 设置默认选项
        self.selectedBtn = _hotBtn;
        self.selectedBtn.selected = YES;
        
    }
    return self;
}

//#pragma mark - didScroll方案 处理 indicatorView
//- (void)tabIndicatorWithSrollView:(UIScrollView *)scrollView contentOffset:(CGPoint)contentOffset
//{
//    if (contentOffset.x < 0) {
//        return;
//    }
//
//    CGFloat btnMargin = 22;
//    CGFloat indicationViewWidth = 16;
//    CGFloat s = scrollView.bounds.size.width;
//    CGFloat w = (self.hotBtn.bounds.size.width + btnMargin);
//
//
//    // indicateView 的 startX
//    CGFloat btnW = self.hotBtn.bounds.size.width;
//    CGFloat baseX = (btnW-indicationViewWidth)/2.0;
//    CGFloat indicateViewStartX = baseX + self.selectedIndex * (btnW + btnMargin);
//
//    // 手滑的 和代码滑的不同处理
//    if (scrollView.dragging || scrollView.isDecelerating) {
//
//        // scrollView的 startX
//        CGFloat startX = self.selectedIndex * scrollView.bounds.size.width;
//        CGFloat detaS = contentOffset.x - startX;
//        CGFloat detaW = w / (s / detaS);
//
//
//        CGRect tmpFrame = self.indicatorView.frame;
//        // 有个很重要的是 当前contentOffset.x 是否大于startX
//        if (contentOffset.x >= startX) {
//
//            tmpFrame.size.width = indicationViewWidth + detaW;
//        }else {
//            // 此时 detaW 是负数 ，但我们肯定是要正数 ，所以要取反
//            tmpFrame.size.width = indicationViewWidth + (-detaW);
//            tmpFrame.origin.x = indicateViewStartX - (-detaW);
//        }
//        self.indicatorView.frame = tmpFrame;
//
//    }else { // 代码scroll
//
//        CGFloat rate = w / s;
//        CGRect tmpFrame = self.indicatorView.frame;
//        tmpFrame.origin.x = baseX + contentOffset.x  * rate;
//        self.indicatorView.frame = tmpFrame;
//    }
//
//}

#pragma mark - didScroll方案 处理 indicatorView
- (void)tabIndicatorWithSrollView:(UIScrollView *)scrollView contentOffset:(CGPoint)contentOffset
{
    if (contentOffset.x < 0) {
        return;
    }
    
    /**
     * 注意： 用selectedIndex 来处理的时候，不会出现 下面右滑的情况了！！！
     */
    NSInteger selectedIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
    //    NSLog(@"selectedIndex %zd, self.selectedIndex %zd",selectedIndex,self.selectedIndex);
    CGFloat btnMargin = 22;
    CGFloat indWidth = 16;
    CGFloat s = scrollView.bounds.size.width / 2.0;
    CGFloat w = (self.hotBtn.bounds.size.width + btnMargin);
    CGFloat indMaxWidth = indWidth + w;
    
    
    // indicateView 的 startX
    CGFloat btnW = self.hotBtn.bounds.size.width;
    CGFloat baseX = (btnW-indWidth)/2.0;
    CGFloat indStartX = baseX + selectedIndex * (btnW + btnMargin);
    //    NSLog(@"indStartX %f",indStartX);
    // scrollView的 startX
    CGFloat startX = selectedIndex * scrollView.bounds.size.width;
    
    // 手滑的 和代码滑的不同处理
    if (scrollView.dragging || scrollView.isDecelerating) {
        
        CGRect tmpFrame = self.indicatorView.frame;
        // 有个很重要的是 当前contentOffset.x 是否大于startX
        if (contentOffset.x >= startX) { // 左滑
            CGFloat centerX = startX + scrollView.bounds.size.width / 2.0;
            if (contentOffset.x >= centerX) {
                CGFloat detaS = contentOffset.x - centerX;
                CGFloat detaW = w / (s / detaS);
                tmpFrame.size.width = indMaxWidth - detaW;
                tmpFrame.origin.x =  indStartX + detaW;
                
            }else {
                CGFloat detaS = contentOffset.x - startX;
                CGFloat detaW = w / (s / detaS);
                tmpFrame.size.width = indWidth + detaW;
                tmpFrame.origin.x = indStartX;
            }
            
        }else { // 右滑
            
            /**
             * 注意： 用selectedIndex 来处理的时候，不会出现 下面右滑的情况了！！！
             * 所以这里的代码，根本不会执行
             */
            NSLog(@"右滑");
            CGFloat centerX = startX - scrollView.bounds.size.width / 2.0;
            CGFloat indEndX = indStartX - w;
            NSLog(@"indEndX %f",indEndX);
            if (contentOffset.x < centerX) {
                CGFloat detaS = contentOffset.x - centerX;
                CGFloat detaW = w / (s / detaS);
                // 此时 detaW 是负数
                tmpFrame.size.width = indMaxWidth + detaW;
                tmpFrame.origin.x = indEndX;
            }else {
                CGFloat detaS = contentOffset.x - startX;
                CGFloat detaW = w / (s / detaS);
                // 此时 detaW 是负数 ，但我们肯定是要正数 ，所以要取反
                tmpFrame.size.width = indWidth + (-detaW);
                tmpFrame.origin.x = indStartX - (-detaW);
            }
            
        }
        self.indicatorView.frame = tmpFrame;
        
    }else { // 代码scroll
        
        CGFloat rate = w / (s*2);
        CGRect tmpFrame = self.indicatorView.frame;
        tmpFrame.origin.x = baseX + contentOffset.x  * rate;
        self.indicatorView.frame = tmpFrame;
    }
    
}

//#pragma mark - KVO方案 处理 indicatorView
//- (void)tabIndicatorWithSrollView:(UIScrollView *)scrollView change:(NSDictionary<NSKeyValueChangeKey,id> *)change
//{
//    CGPoint oldContentOffset  = [change[@"old"] CGPointValue];
//    CGPoint newContentOffset  = [change[@"new"] CGPointValue];
//    CGFloat detaS = newContentOffset.x - oldContentOffset.x;
//
//    CGFloat btnMargin = 22;
//    CGFloat btnW = self.hotBtn.bounds.size.width;
//    CGFloat indWidth = 16;
//    CGFloat s = scrollView.bounds.size.width / 2.0;
//    CGFloat w = self.hotBtn.bounds.size.width + btnMargin;
//    CGFloat detaW = w / (s / detaS);
//
//    CGFloat baseX = (btnW-indWidth)/2.0;
////    CGFloat indStartX = baseX + self.selectedIndex * (btnW + btnMargin);
//    CGFloat startX = self.selectedIndex * scrollView.bounds.size.width;
//
//
//    // 手滑的 和代码滑的不同处理
//    if (scrollView.dragging || scrollView.isDecelerating) {
//
//
//        CGRect tmpFrame = self.indicatorView.frame;
//        // 有个很重要的是 当前contentOffset.x 是否大于startX
//        if (newContentOffset.x >= startX) { // 左滑
//
//
//            CGFloat centerX = startX + scrollView.bounds.size.width / 2.0;
//            // 是否 达到centerX
//            if (newContentOffset.x >= centerX) {
//                tmpFrame.size.width -= detaW;
//                tmpFrame.origin.x += detaW;
//                NSLog(@"right indWidth %f",tmpFrame.size.width);
//            }else {
//                tmpFrame.size.width += detaW;
//            }
//
//        }else { // 右滑
//
//             CGFloat centerX = startX - scrollView.bounds.size.width / 2.0;
//
//            // 是否 达到centerX
//            if (newContentOffset.x <= centerX) {
//                // 此时 detaW 是负数
//                tmpFrame.size.width += detaW;
//                NSLog(@"left indWidth %f",tmpFrame.size.width);
//            }else {
//                // 此时 detaW 是负数 ，但我们肯定是要正数 ，所以要取反
//                tmpFrame.size.width += (-detaW);
//                tmpFrame.origin.x += detaW;
//            }
//
//        }
//        self.indicatorView.frame = tmpFrame;
//
//    }else { // 代码scroll
//
//        CGFloat rate = w / (s*2);
//        CGRect tmpFrame = self.indicatorView.frame;
//        tmpFrame.origin.x = baseX + newContentOffset.x  * rate;
//        self.indicatorView.frame = tmpFrame;
//    }
//}

#pragma mark - action
- (void)didHotBtn:(UIButton *)btn
{
    [[ZGSTIScrollManager shareInstance] tabBarDidSelectedIndex:btn.tag];
}

- (void)didStoryBtn:(UIButton *)btn
{
    [[ZGSTIScrollManager shareInstance] tabBarDidSelectedIndex:btn.tag];
}

- (void)didDiscoveryBtn:(UIButton *)btn
{
    [[ZGSTIScrollManager shareInstance] tabBarDidSelectedIndex:btn.tag];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    
    // 处理indicationView
    //    CGFloat btnMargin = 22;
    //    CGFloat indicationViewWidth = 16;
    //    CGFloat btnW = self.hotBtn.bounds.size.width;
    //    CGFloat baseX = (btnW-indicationViewWidth)/2.0;
    //    [UIView animateWithDuration:0.15 animations:^{
    //        self.indicatorView.frame = CGRectMake(baseX + selectedIndex * (btnW + btnMargin), self.bounds.size.height - 3, indicationViewWidth, 3);
    //    }];
    
    self.selectedBtn.selected = NO;
    if (selectedIndex == 0) {
        self.selectedBtn = _hotBtn;
    }else if (selectedIndex == 1) {
        self.selectedBtn = _discoveryBtn;
    }else if (selectedIndex == 2) {
        self.selectedBtn = _storyBtn;
    }
    self.selectedBtn.selected = YES;
}
@end
