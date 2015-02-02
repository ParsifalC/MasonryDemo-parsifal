//
//  ExampleViewController.m
//  Masonry-parsifal
//
//  Created by Parsifal on 15/2/2.
//  Copyright (c) 2015年 Parsifal. All rights reserved.
//

#import "ExampleViewController.h"

@interface ExampleViewController ()

@property (strong, nonatomic) UIView *viewClass;

@end

@implementation ExampleViewController

- (instancetype)initWithTitle:(NSString *)title viewClass:(UIView *)viewClass
{
    self = [super init];
    if (self) {
        self.viewClass = viewClass;
        self.title = title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    self.view = self.viewClass;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
}

#ifdef __IPHONE_7_0
- (UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeNone;
}
#endif

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
