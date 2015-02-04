//
//  EqualWidthView.m
//  Masonry-parsifal
//
//  Created by Parsifal on 15/2/4.
//  Copyright (c) 2015年 Parsifal. All rights reserved.
//

#import "EqualWidthView.h"
#import <Masonry/Masonry.h>
#import <MMPlaceHolder/MMPlaceHolder.h>

#define kBigPadding 100
#define kSmallPadding 10

@interface EqualWidthView()

@property (strong, nonatomic) NSMutableArray *constrainsArray;

@end


@implementation EqualWidthView

- (instancetype)init
{
    self = [super init];
    if (self) {
        __weak typeof (self)weakSelf = self;
        //设置父视图
        UIView *superView = [UIView new];
        superView.backgroundColor = [UIColor whiteColor];
        superView.layer.borderWidth = 2;
        superView.layer.borderColor = [UIColor blackColor].CGColor;
        [self addSubview:superView];
        [superView showPlaceHolder];
        
        UIView *subView1 = [UIView new];
        subView1.backgroundColor = [UIColor redColor];
        [superView addSubview:subView1];
        [subView1 showPlaceHolder];
        
        UIView *subView2 = [UIView new];
        subView2.backgroundColor = [UIColor redColor];
        [superView addSubview:subView2];
        [subView2 showPlaceHolder];
        
        UIView *subView3 = [UIView new];
        subView3.backgroundColor = [UIColor redColor];
        [superView addSubview:subView3];
        [subView3 showPlaceHolder];
        
        //设置约束 子视图等宽左右两个视图距离父视图20 子视图间距10 等高 等宽
        [superView mas_makeConstraints:^(MASConstraintMaker *make) {
            [self.constrainsArray addObject:make.edges.equalTo(weakSelf).with.insets(UIEdgeInsetsMake(kSmallPadding, kSmallPadding, kSmallPadding, kSmallPadding))];
        }];
        
        [subView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.equalTo(superView).with.offset(20);
            make.bottom.equalTo(superView).with.offset(-20);
            make.centerY.equalTo(superView.mas_centerY);
            make.right.equalTo(subView2.mas_left).with.offset(-kSmallPadding);
            make.width.and.height.equalTo(@[subView2,subView3]);
        }];
        
        [subView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(subView1.mas_right).with.offset(kSmallPadding);
            make.centerY.equalTo(superView.mas_centerY);
            make.right.equalTo(subView3.mas_left).with.offset(-kSmallPadding);
            make.width.and.height.equalTo(@[subView1,subView3]);
        }];
        
        [subView3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(subView2.mas_right).with.offset(kSmallPadding);
            make.centerY.equalTo(superView.mas_centerY);
            make.right.equalTo(superView.mas_right).with.offset(-20);
            make.width.and.height.equalTo(@[subView1,subView2]);
        }];
    }
    return self;
}

- (NSMutableArray *)constrainsArray
{
    if (!_constrainsArray) {
        _constrainsArray = [NSMutableArray new];
    }
    
    return _constrainsArray;
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    [self layoutIfNeeded];
    
    if (self.superview) {
        [self changeSuperViewSize:NO];
    }
}

- (void)changeSuperViewSize:(BOOL)zoomout
{
    __weak typeof (self)weakSelf = self;
    int padding = zoomout ? kSmallPadding : kBigPadding;
    UIEdgeInsets insets = UIEdgeInsetsMake(padding, padding, padding, padding);
    for (MASConstraint *make in self.constrainsArray) {
        make.insets = insets;
    }
    
    [UIView animateWithDuration:1 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [weakSelf changeSuperViewSize:!zoomout];
    }];
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
