//
//  ViewController.m
//  PopTransparentView
//
//  Created by QC.L on 16/5/31.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

static NSString * const kTableViewCell = @"cell";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *testTableView;
@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.array = [NSMutableArray arrayWithObjects:@"ContainNavgation", @"NoContainNavgation", nil];
    self.title = @"模态透明视图VC";
    
    
}

#pragma - mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCell];
    cell.textLabel.text = self.array[indexPath.row];
    return cell;
}

#pragma - mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *presentVC = [[SecondViewController alloc] init];
    presentVC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    
    if ([self.array[indexPath.row] isEqualToString:@"ContainNavgation"]) {
        presentVC = [[UINavigationController alloc] initWithRootViewController:presentVC];
    }
    // 核心代码
    self.definesPresentationContext = YES;
    // 可以使用的Style
    // UIModalPresentationOverCurrentContext
    // UIModalPresentationOverFullScreen
    // UIModalPresentationCustom
    // 使用其他Style会黑屏
    presentVC.modalPresentationStyle = UIModalPresentationCustom;
    
    
    [self.navigationController presentViewController:presentVC animated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
