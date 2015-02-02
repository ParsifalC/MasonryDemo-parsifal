//
//  SidesView.m
//  Masonry-parsifal
//
//  Created by Parsifal on 15/2/2.
//  Copyright (c) 2015年 Parsifal. All rights reserved.
//

#import "SidesView.h"
#import <Masonry/Masonry.h>
#import <MMPlaceHolder/MMPlaceHolder.h>
#define RANDOMCOLOR arc4random() % 256 / 256.0
#define PADDING 20


@interface SidesView ()

@property (strong, nonatomic) NSMutableArray *mulArray;
@property (strong, nonatomic) NSTimer *timer;

@end
@implementation SidesView

- (instancetype)init
{
    self = [super init];
    if (self) {
        __weak typeof (self)weakSelf = self;
        for (int i = 1; i < 6; i++) {
            UIView *subView = [UIView new];
            subView.backgroundColor = [UIColor colorWithRed:RANDOMCOLOR green:RANDOMCOLOR blue:RANDOMCOLOR alpha:1];
            [self addSubview:subView];
            [subView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(weakSelf).with.insets(UIEdgeInsetsMake(PADDING * i, PADDING * i,  PADDING * i, PADDING * i));
            }];
            
            [self.mulArray addObject:subView];
            [subView showPlaceHolder];
        }
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeViews) userInfo:nil repeats:YES];
        
    }
    return self;
}

- (NSMutableArray *)mulArray
{
    if (!_mulArray) {
        _mulArray = [NSMutableArray new];
    }
    
    return _mulArray;
}

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

- (void)updateConstraints
{
    __weak typeof (self)weakSelf = self;
    [self.mulArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx < self.mulArray.count - 1) {
            UIView *subView = obj;
            [subView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(weakSelf).with.insets(UIEdgeInsetsMake(PADDING * idx, PADDING * idx, PADDING * idx, PADDING * idx));
            }];
        }
    }];
    
    
    [super updateConstraints];
}

//第一种方法 不通过增删view 直接通过修改背景颜色实现霓虹灯
//- (void)changeViews
//{
//    int count = (int)self.mulArray.count;
//    for (int i = count - 1; i >= 0; i--) {
//        if (i) {
//            UIView *view1 = self.mulArray[i];
//            UIView *view2 = self.mulArray[i - 1];
//            
//            view1.backgroundColor = view2.backgroundColor;
//        }
//        else
//        {
//            UIView *firstView = self.mulArray[i];
//            firstView.backgroundColor = [UIColor colorWithRed:RANDOMCOLOR green:RANDOMCOLOR blue:RANDOMCOLOR alpha:1];
//            NSLog(@"%@", NSStringFromCGRect(firstView.frame));
//        }
//    }
//}

//第二种方法 通过增删viwe 实现霓虹灯 每次将最外层的视图移除 并添加一个视图到最内层 其他各层依次变大
- (void)changeViews
{
    __weak typeof (self)weakSelf = self;
    [self.mulArray.firstObject removeFromSuperview];
    [self.mulArray removeObjectAtIndex:0];
    UIView *view = [UIView new];
    [view showPlaceHolder];
    [self addSubview:view];
    view.backgroundColor = [UIColor colorWithRed:RANDOMCOLOR green:RANDOMCOLOR blue:RANDOMCOLOR alpha:1];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf).with.insets(UIEdgeInsetsMake(PADDING * self.mulArray.count, PADDING * self.mulArray.count, PADDING * self.mulArray.count, PADDING * self.mulArray.count));
    }];
    [self.mulArray addObject:view];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)removeFromSuperview
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    [super removeFromSuperview];
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
