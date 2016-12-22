//
//  SecondViewController.m
//  导航栏颜色渐变
//
//  Created by 王战胜 on 2016/12/20.
//  Copyright © 2016年 gocomtech. All rights reserved.
//

#import "SecondViewController.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //上方图片
    self.view.backgroundColor=[UIColor redColor];
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
    imageview.image=[UIImage imageNamed:@"presentimage"];
    [self.view addSubview:imageview];
    
    //下方透明图片,主要是为了加点击事件
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 300, SCREEN_WIDTH, SCREEN_HEIGHT-300)];
    [self.view addSubview:view];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGR)];
    [view addGestureRecognizer:tap];
}

- (void)tapGR{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
