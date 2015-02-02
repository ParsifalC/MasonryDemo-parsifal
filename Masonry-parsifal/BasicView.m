//
//  BasicView.m
//  Masonry-parsifal
//
//  Created by Parsifal on 15/2/2.
//  Copyright (c) 2015年 Parsifal. All rights reserved.
//

#import "BasicView.h"
#import <Masonry/Masonry.h>
#import <MMPlaceHolder/MMPlaceHolder.h>


@implementation BasicView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        __weak typeof(self)weakSelf = self;
        
        //三个视图 上面两个(等间距10排列) 下面一个
        NSInteger padding = 10;
        
        UIView *view1 = [UIView new];
        [self addSubview:view1];
        [view1 showPlaceHolder];
        UIView *view2 = [UIView new];
        [self addSubview:view2];
        [view2 showPlaceHolder];
        UIView *view3 = [UIView new];
        [self addSubview:view3];
        [view3 showPlaceHolder];
        
        view1.backgroundColor = [UIColor redColor];
        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(@150);
//            make.centerY.equalTo(weakSelf.mas_centerY);
            make.left.equalTo(weakSelf.mas_left).with.offset(padding);
            make.right.equalTo(view2.mas_left).with.offset(-padding);
            make.width.equalTo(view2.mas_width);
            make.top.equalTo(weakSelf.mas_top).with.offset(padding);
            make.bottom.equalTo(view3.mas_top).with.offset(-padding);
            make.height.equalTo(@[view2.mas_height, view3.mas_height]);
        }];
        
        view2.backgroundColor = [UIColor greenColor];
        [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(@150);
//            make.centerY.equalTo(weakSelf.mas_centerY);
            make.left.equalTo(view1.mas_right).with.offset(padding);
            make.right.equalTo(weakSelf.mas_right).with.offset(-padding);
            make.width.equalTo(view1.mas_width);
            make.top.equalTo(weakSelf.mas_top).with.offset(padding);
            make.bottom.equalTo(view3.mas_top).with.offset(-padding);
            make.height.equalTo(@[view1.mas_height, view3.mas_height]);
        }];
        
        view3.backgroundColor = [UIColor blackColor];
        [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).with.offset(padding);
            make.right.equalTo(weakSelf.mas_right).with.offset(-padding);
            make.top.equalTo(@[view1.mas_bottom, view2.mas_bottom]).with.offset(padding);
            make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-padding);
            make.height.equalTo(@[view1.mas_height, view2.mas_height]);
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
