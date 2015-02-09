//
//  ViewController.m
//  Masonry-parsifal
//
//  Created by Parsifal on 15/1/4.
//  Copyright (c) 2015年 Parsifal. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import <MMPlaceHolder/MMPlaceHolder.h>
#import "ExampleViewController.h"
#import "BasicView.h"
#import "UpdateView.h"
#import "RemakeView.h"
#import "ConstantsView.h"
#import "SidesView.h"
#import "AnimatedView.h"
#import "EqualWidthView.h"
#import "LabelView.h"
#import "ScrollView.h"

static NSString *cellID = @"cell";

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *mulArray;
@end

@implementation ViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //register cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    
    [self.mulArray addObjectsFromArray:@[@"basic", @"update", @"remake", @"using constrant", @"side view", @"animated view", @"equal width view", @"label view", @"scroll view"]];
}

- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            ExampleViewController *exampleVC = [[ExampleViewController alloc] initWithTitle:@"basic" viewClass:[BasicView new]];
            [self.navigationController pushViewController:exampleVC animated:YES];
            break;
        }
        case 1:
        {
            ExampleViewController *exampleVC = [[ExampleViewController alloc] initWithTitle:@"update" viewClass:[UpdateView new]];
            [self.navigationController pushViewController:exampleVC animated:YES];
            break;
        }
           
        case 2:
        {
            ExampleViewController *exampleVC = [[ExampleViewController alloc] initWithTitle:@"remake" viewClass:[RemakeView new]];
            [self.navigationController pushViewController:exampleVC animated:YES];
            break;
        }
        case 3:
        {
            ExampleViewController *exampleVC = [[ExampleViewController alloc] initWithTitle:@"using constant" viewClass:[ConstantsView new]];
            [self.navigationController pushViewController:exampleVC animated:YES];
            break;
        }
            
        case 4:
        {
            ExampleViewController *exampleVC = [[ExampleViewController alloc] initWithTitle:@"side view" viewClass:[SidesView new]];
            [self.navigationController pushViewController:exampleVC animated:YES];
            break;
        }
            
        case 5:
        {
            ExampleViewController *exampleVC = [[ExampleViewController alloc] initWithTitle:@"animated view" viewClass:[AnimatedView new]];
            [self.navigationController pushViewController:exampleVC animated:YES];
            break;
        }
            
        case 6:
        {
            ExampleViewController *exampleVC = [[ExampleViewController alloc] initWithTitle:@"equal width view" viewClass:[EqualWidthView new]];
            [self.navigationController pushViewController:exampleVC animated:YES];
            break;
        }
        case 7:
        {
            ExampleViewController *exampleVC = [[ExampleViewController alloc] initWithTitle:@"label view" viewClass:[LabelView new]];
            [self.navigationController pushViewController:exampleVC animated:YES];
            break;
        }
            
        case 8:
        {
            ExampleViewController *exampleVC = [[ExampleViewController alloc] initWithTitle:@"scroll view" viewClass:[ScrollView new]];
            [self.navigationController pushViewController:exampleVC animated:YES];
            break;
        }
        default:
        {
            break;
        }
    }
}

#pragma mark - tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mulArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = self.mulArray[indexPath.row];    
    
    return cell;
}
#pragma mark - private method
- (NSMutableArray *)mulArray
{
    if (!_mulArray) {
        _mulArray = [NSMutableArray new];
    }
    
    return _mulArray;
}





@end
