//
//  AnimatedView.m
//  Masonry-parsifal
//
//  Created by Parsifal on 15/2/3.
//  Copyright (c) 2015年 Parsifal. All rights reserved.
//

#import "AnimatedView.h"
#import <Masonry/Masonry.h>
#import <MMPlaceHolder/MMPlaceHolder.h>
@interface AnimatedView()

@property (assign, nonatomic) NSInteger padding;
@property (assign, nonatomic) BOOL shouldAnimated;
@property (assign, nonatomic) BOOL isZoomOut;
@property (strong, nonatomic) NSMutableArray *animatableConstraints;

@end

@implementation AnimatedView

- (instancetype)init
{
    self = [super init];
    if (self) {
        __weak typeof (self)weakSelf = self;
        self.padding = 10;
        
        UIView *view1 = [UIView new];
        view1.backgroundColor = [UIColor redColor];
        [self addSubview:view1];
        [view1 showPlaceHolder];
        
        UIView *view2 = [UIView new];
        view2.backgroundColor = [UIColor greenColor];
        [self addSubview:view2];
        [view2 showPlaceHolder];
        
        UIView *view3 = [UIView new];
        view3.backgroundColor = [UIColor blueColor];
        [self addSubview:view3];
        [view3 showPlaceHolder];
        
        //view1 view2 在上半部分 view3在下半部分
        //view1 view2横向等间距 view1/view2 view3 纵向等间距
        //三个view等高
        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            [self.animatableConstraints addObjectsFromArray:@[
                                                              make.top.equalTo(weakSelf.mas_top).with.offset(weakSelf.padding),
                                                              make.left.equalTo(weakSelf.mas_left).with.offset(weakSelf.padding)]];
            
            make.bottom.equalTo(weakSelf.mas_centerY).with.offset(-weakSelf.padding);
            make.right.equalTo(view2.mas_left).with.offset(-weakSelf.padding);
            make.width.equalTo(view2.mas_width);
        }];
        
        [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(view1.mas_height);
            make.left.equalTo(view1.mas_right).with.offset(weakSelf.padding);
            
            [self.animatableConstraints addObjectsFromArray:@[
                                                              make.right.equalTo(weakSelf.mas_right).with.offset(-weakSelf.padding),
                                                              make.top.equalTo(weakSelf.mas_top).with.offset(weakSelf.padding)]];
        }];
        
        [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mas_centerY).with.offset(weakSelf.padding);
            make.height.equalTo(@[view1.mas_height, view2.mas_height]);
            
            [self.animatableConstraints addObjectsFromArray:@[
                                                              make.left.equalTo(weakSelf.mas_left).with.offset(weakSelf.padding),
                                                              make.right.equalTo(weakSelf.mas_right).with.offset(-weakSelf.padding)]];
        }];
        
    }
    return self;
}

- (NSMutableArray *)animatableConstraints
{
    if (!_animatableConstraints) {
        _animatableConstraints = [NSMutableArray new];
    }
    
    return _animatableConstraints;
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    [self layoutIfNeeded];
    
    self.shouldAnimated = YES;
    if (self.window) {
        [self zoomAnimated:self.isZoomOut];
    }
}

- (void)removeFromSuperview
{
    self.shouldAnimated = NO;
    [super removeFromSuperview];
}

- (void)zoomAnimated:(BOOL)isZoomOut
{
    __weak typeof (self)weakSelf = self;
    if (!self.shouldAnimated) {
        return;
    }
    self.padding = isZoomOut ? 10:100;
    UIEdgeInsets insets = UIEdgeInsetsMake(self.padding, self.padding, self.padding, self.padding);
    for (MASConstraint *make in self.animatableConstraints) {
        make.insets = insets;
    }
    
    [UIView animateWithDuration:1 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [weakSelf zoomAnimated:!isZoomOut];
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
