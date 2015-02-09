//
//  ArrayView.m
//  Masonry-parsifal
//
//  Created by Parsifal on 15/2/9.
//  Copyright (c) 2015年 Parsifal. All rights reserved.
//

#import "ArrayView.h"
#import <Masonry/Masonry.h>


#define kIncrement 10
#define kPadding 10

@interface ArrayView ()

@property (strong, nonatomic) NSArray *buttonViews;
@property (assign, nonatomic) NSInteger offset;

@end

@implementation ArrayView

- (instancetype)init
{
    self = [super init];
    if (self) {
        __weak typeof (self)weakSelf = self;
        
        //三个button 添加入数组 统一管理
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [leftButton setTitle:@"down" forState:(UIControlStateNormal)];
        [leftButton addTarget:self action:@selector(raiseOffset) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:leftButton];
        
        UIButton *centerButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [centerButton setTitle:@"center" forState:(UIControlStateNormal)];
        [centerButton addTarget:self action:@selector(clearOffset) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:centerButton];
        
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [rightButton setTitle:@"up" forState:(UIControlStateNormal)];
        [rightButton addTarget:self action:@selector(lowerOffset) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:rightButton];
        
        //设置横向约束 UIButton可根据title大小自适应width
        [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).with.offset(kPadding);
        }];
        
        [centerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf);
        }];
        
        [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf).with.offset(-kPadding);
        }];
        
        self.buttonViews = @[leftButton, centerButton, rightButton];
        self.offset = 0;
    }
    return self;
}

- (void)raiseOffset
{
    self.offset += kIncrement;
}

- (void)lowerOffset
{
    self.offset -= kIncrement;
}

- (void)clearOffset
{
    self.offset = 0;
}

//每次更改offset的时候，更新constraints
- (void)setOffset:(NSInteger)offset
{
    _offset = offset;
    [self setNeedsUpdateConstraints];
}

-(void)updateConstraints
{
    __weak typeof (self)weakSelf = self;
    //补充设置纵向约束
    [self.buttonViews mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf).with.offset(self.offset);
    }];
    
    [super updateConstraints];
}

- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
