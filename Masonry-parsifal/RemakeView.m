//
//  RemakeView.m
//  Masonry-parsifal
//
//  Created by Parsifal on 15/2/2.
//  Copyright (c) 2015年 Parsifal. All rights reserved.
//

#import "RemakeView.h"
#import <Masonry/Masonry.h>
#import <MMPlaceHolder/MMPlaceHolder.h>

@interface RemakeView ()

@property (strong, nonatomic) UIButton *button;
@property (assign, nonatomic) UIEdgeInsets edges;

@end

@implementation RemakeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.button];
        __weak typeof (self)weakSelf = self;
        
        self.edges = UIEdgeInsetsMake(100, 100, 100, 100);
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf).with.insets(weakSelf.edges);
        }];
        
        [self.button addTarget:self action:@selector(remake) forControlEvents:(UIControlEventTouchUpInside)];
        [self.button showPlaceHolder];
    }
    return self;
}

- (UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_button setTitle:@"点击我" forState:(UIControlStateNormal)];
        _button.backgroundColor = [UIColor grayColor];
    }
    
    return _button;
}

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

- (void)updateConstraints
{
    __weak typeof (self)weakSelf = self;
    [self.button mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf).with.insets(weakSelf.edges);
    }];
    [super updateConstraints];
}

- (void)remake
{
    NSInteger top = arc4random() % 100;
    NSInteger bottom = arc4random() % 100;
    NSInteger left = arc4random() % 100;
    NSInteger right = arc4random() % 100;
    self.edges = UIEdgeInsetsMake(top, left, bottom, right);
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [UIView animateWithDuration:1 animations:^{
        [self layoutIfNeeded];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
