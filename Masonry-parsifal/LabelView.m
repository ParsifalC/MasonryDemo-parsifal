//
//  LabelView.m
//  Masonry-parsifal
//
//  Created by Parsifal on 15/2/5.
//  Copyright (c) 2015年 Parsifal. All rights reserved.
//

#import "LabelView.h"
#import <Masonry/Masonry.h>
#import <MMPlaceHolder/MMPlaceHolder.h>
@interface LabelView ()

@property (strong, nonatomic) UILabel *longLabel;
@property (strong, nonatomic) UILabel *shortLabel;

@end

@implementation LabelView

- (instancetype)init
{
    self = [super init];
    if (self) {
        __weak typeof (self)weakSelf = self;
        //两个label并排显示，一个长内容多行显示，一个短内容单行显示
        self.longLabel = [UILabel new];
        self.longLabel.numberOfLines = 0;
        self.longLabel.text = @"Semantic annotations and other metadata can be associated with these artifacts to offer insight to potential users of the service on how and when it can be used, and what purposes it serves.";
        [self addSubview:self.longLabel];
        
        self.shortLabel = [UILabel new];
        self.shortLabel.numberOfLines = 1;
        self.shortLabel.text = @"UILabel";
        self.shortLabel.textColor = [UIColor redColor];
        [self addSubview:self.shortLabel];
        
        //布局
        [self.longLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mas_top).with.offset(20);
            make.left.equalTo(weakSelf.mas_left).with.offset(20);
        }];
        
        [self.shortLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf).with.offset(-20);
            make.centerY.equalTo(weakSelf.longLabel.mas_centerY);
        }];
        
    }
    return self;
}

-(void)layoutSubviews
{
    //修改布局前执行父类布局方法
    [super layoutSubviews];
    
    //必须在布局之后，才会计算得出autolayout后的frame
    self.longLabel.preferredMaxLayoutWidth = self.bounds.size.width - self.shortLabel.bounds.size.width - 20;
    
    //修改布局后再次执行父类布局方法
    [super layoutSubviews];
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
