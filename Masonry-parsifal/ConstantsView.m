//
//  ConstantsView.m
//  Masonry-parsifal
//
//  Created by Parsifal on 15/2/2.
//  Copyright (c) 2015年 Parsifal. All rights reserved.
//

#import "ConstantsView.h"
#import <Masonry/Masonry.h>
#import <MMPlaceHolder/MMPlaceHolder.h>


@implementation ConstantsView
- (instancetype)init
{
    self = [super init];
    if (self) {
        UIView *view1 = [UIView new];
        view1.backgroundColor = [UIColor greenColor];
        [self addSubview:view1];
        [view1 showPlaceHolder];
        
        UIView *view2 = [UIView new];
        view2.backgroundColor = [UIColor redColor];
        [self addSubview:view2];
        [view2 showPlaceHolder];
        
        UIView *view3 = [UIView new];
        view3.backgroundColor = [UIColor blueColor];
        [view1 addSubview:view3];
        [view3 showPlaceHolder];
        
        __weak typeof (self)weakSelf = self;
        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf).insets(UIEdgeInsetsMake(20, 20, 20, 20));
        }];
        //将view2放在view1的中下方 view2的top为view1的中间线 view1 view2平级
        [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view1.mas_centerX);
            make.left.equalTo(view1.mas_left).with.offset(10);
            make.right.equalTo(view1.mas_right).with.offset(-10);
            make.top.equalTo(view1.mas_centerY).with.offset(5);
            make.bottom.equalTo(view1.mas_bottom).with.offset(-10);
        }];
        
        
        //将view3放在view1的中上方 view3的bottom为view1的中间线 view3为view1的子视图
        [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view1.mas_centerX);
            make.left.equalTo(view1.mas_left).with.offset(10);
            make.right.equalTo(view1.mas_right).with.offset(-10);
            make.top.equalTo(view1.mas_top).with.offset(10);
            make.bottom.equalTo(view1.mas_centerY).with.offset(-5);
        }];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
