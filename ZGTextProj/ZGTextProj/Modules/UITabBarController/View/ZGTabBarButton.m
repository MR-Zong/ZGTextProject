//
//  ZGTabBarButton.m
//  ZGTextProj
//
//  Created by ali on 2019/2/13.
//  Copyright © 2019 XuZonggen. All rights reserved.
//

#import "ZGTabBarButton.h"


@interface ZGTabBarButton ()

@property (nonatomic, strong) id target;
@property (nonatomic, assign) SEL action;

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ZGTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _imgView = [[UIImageView alloc] init];
        _imgView.hidden = YES;
        [self addSubview:_imgView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _titleLabel.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.target) {
        [self.target performSelector:self.action withObject:self];
    }
}

- (void)addTarget:(id)target action:(SEL)action
{
    self.target = target;
    self.action = action;
}

- (void)setColor:(UIColor *)color state:(ZGTabBarButtonState)state
{
    ;
}

- (void)setTabBarItem:(UITabBarItem *)tabBarItem
{
    _tabBarItem = tabBarItem;
    
    self.titleLabel.text = tabBarItem.title;
    self.imgView.image = tabBarItem.image;
}

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    if (isSelected) {
        self.titleLabel.textColor = [UIColor redColor];
        self.imgView.image = self.tabBarItem.selectedImage;
    }else {
        self.titleLabel.textColor = [UIColor blackColor];
        self.imgView.image = self.tabBarItem.image;
    }
}

@end
