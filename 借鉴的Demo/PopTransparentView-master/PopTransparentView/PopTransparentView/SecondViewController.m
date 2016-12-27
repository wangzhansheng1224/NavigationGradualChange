//
//  SecondViewController.m
//  PopTransparentView
//
//  Created by QC.L on 16/5/31.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 100, 100);
    button.center = CGPointMake(CGRectGetWidth(self.view.bounds) / 2, CGRectGetHeight(self.view.bounds) / 2);
    [self.view addSubview:button];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
