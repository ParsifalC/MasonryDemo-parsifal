//
//  ScrollView.m
//  Masonry-parsifal
//
//  Created by Parsifal on 15/2/5.
//  Copyright (c) 2015年 Parsifal. All rights reserved.
//

#import "ScrollView.h"
#import <Masonry/Masonry.h>
#import <MMPlaceHolder/MMPlaceHolder.h>

#define RANDOMCOLOR arc4random() % 256 / 256.0
static UIEdgeInsets insets = {10, 10 ,10 ,10};

@implementation ScrollView

- (instancetype)init
{
    self = [super init];
    if (self) {
        __weak typeof (self)weakSelf = self;
        //滚动视图
        UIScrollView *scrollView = [UIScrollView new];
        scrollView.backgroundColor = [UIColor colorWithRed:0.811 green:1.000 blue:0.590 alpha:1.000];
        [self addSubview:scrollView];
        [scrollView showPlaceHolder];
        
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf).with.insets(insets);
        }];
        
        //增加一层内容视图
        UIView *containerView = [UIView new];
        containerView.backgroundColor = [UIColor colorWithRed:0.513 green:0.587 blue:1.000 alpha:1.000];
        [scrollView addSubview:containerView];
        [containerView showPlaceHolder];
        
        //布局container
        [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(scrollView);
            //固定横向大小
            make.width.equalTo(scrollView);
        }];
        
        UIView *lastView = nil;
        
        for (int i = 1; i < 15; i++) {
            UIView *subView = [UIView new];
            subView.backgroundColor = [UIColor colorWithRed:RANDOMCOLOR green:RANDOMCOLOR blue:RANDOMCOLOR alpha:1.0];
            [containerView addSubview:subView];
            
            [subView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.and.right.equalTo(containerView);
                make.height.equalTo(@(20 * i));
                
                if (lastView) {
                    make.top.equalTo(lastView.mas_bottom).with.offset(5);
                }
                else {
                    make.top.equalTo(containerView.mas_top).with.offset(5);
                }
            }];
            
            lastView = subView;
        }
        
        [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(lastView.mas_bottom);
        }];
    }
    return self;
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
