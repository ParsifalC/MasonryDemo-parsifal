//
//  UpdateView.m
//  Masonry-parsifal
//
//  Created by Parsifal on 15/2/2.
//  Copyright (c) 2015年 Parsifal. All rights reserved.
//

#import "UpdateView.h"
#import <Masonry/Masonry.h>
#import <MMPlaceHolder/MMPlaceHolder.h>

@interface UpdateView ()

@property (strong, nonatomic) UIButton *button;
@property (assign, nonatomic) UIEdgeInsets buttonEdges;

@end

@implementation UpdateView
- (instancetype)init
{
    self = [super init];
    if (self) {
        __weak typeof(self) weakSelf = self;
        self.buttonEdges = UIEdgeInsetsMake(120, 120, 120, 120);
        
        [self addSubview:self.button];
        
        //更新constraints
        [self.button addTarget:self action:@selector(update) forControlEvents:(UIControlEventTouchUpInside)];
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf).with.insets(self.buttonEdges);
        }];
        
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

-(void)updateConstraints
{
    __weak typeof(self) weakSelf = self;
    [self.button mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf).with.insets(self.buttonEdges);
    }];
    [super updateConstraints];
}

- (void)update
{
    self.buttonEdges = UIEdgeInsetsMake(self.buttonEdges.bottom - 10, self.buttonEdges.top - 10, self.buttonEdges.left - 10, self.buttonEdges.right - 10);
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
