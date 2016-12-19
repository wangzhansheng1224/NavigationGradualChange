//
//  ViewController.m
//  导航栏颜色渐变
//
//  Created by 王战胜 on 2016/12/16.
//  Copyright © 2016年 gocomtech. All rights reserved.
//

#import "ViewController.h"
#import "CycleView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIImageView *headView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithWhite:0.95 alpha:1];
//    self.automaticallyAdjustsScrollViewInsets=NO;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    [self createNavigation];
    [self.view addSubview:self.headView];
    [self.view addSubview:self.tableView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (UIImageView *)headView{
    if (!_headView) {
        _headView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
        _headView.image=[UIImage imageNamed:@"bg_head1"];
    }
    return _headView;
}

- (void)createNavigation{
    
    //导航栏左侧Button
    _leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
    [_leftBtn setBackgroundImage:[UIImage imageNamed:@"enjoy_icon_back"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:_leftBtn];
    
    //导航栏右侧Button
    _rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
    [_rightBtn setBackgroundImage:[UIImage imageNamed:@"enjoy_icon_share"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:_rightBtn];
    
    //此方法设置透明无效果
    //    self.navigationController.navigationBar.barTintColor=[UIColor colorWithWhite:1 alpha:0];
    //设置导航栏背景色
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor colorWithWhite:1 alpha:0]] forBarMetrics:UIBarMetricsDefault];
    
    //去掉导航栏底部的黑线
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

//  颜色转换为背景图片
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=[UIColor clearColor];
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        view.backgroundColor=[UIColor colorWithWhite:0.9 alpha:1];
        _tableView.tableFooterView=view;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text=[NSString stringWithFormat:@"我是第%ld行",(long)indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
    view.backgroundColor=[UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 300;
}

#pragma mark -- 核心
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY=scrollView.contentOffset.y;
    if (scrollView.contentOffset.y<=0) {
        
        //图片放大
        CGRect frame=_headView.frame;
        frame.size.width=(1-offsetY/300)*SCREEN_WIDTH;
        frame.size.height=(1-offsetY/300)*300;
        frame.origin.x=-(frame.size.width-SCREEN_WIDTH)/2;
        frame.origin.y=0;
        _headView.frame=frame;
        
        //导航栏初始化状态
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"enjoy_icon_back"]forState:UIControlStateNormal];
        _leftBtn.alpha=1;
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"enjoy_icon_share"] forState:UIControlStateNormal];
        _rightBtn.alpha=1;
        [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor colorWithWhite:1 alpha:0]] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
        
    }else{
        
        //图片上移
        CGRect frame=_headView.frame;
        frame.size.width=SCREEN_WIDTH;
        frame.size.height=300;
        frame.origin.x=0;
        frame.origin.y=-offsetY/2.5;
        _headView.frame=frame;
        
        
        //导航栏itm的变化方法
        if (scrollView.contentOffset.y<=150) {
            
            //恢复左侧导航栏图片和透明度
            [_leftBtn setBackgroundImage:[UIImage imageNamed:@"enjoy_icon_back"]forState:UIControlStateNormal];
            _leftBtn.alpha=1-offsetY/150;
            
            //恢复右侧导航栏图片和透明度
            [_rightBtn setBackgroundImage:[UIImage imageNamed:@"enjoy_icon_share"] forState:UIControlStateNormal];
            _rightBtn.alpha=1-offsetY/150;
            
            //导航栏底部不显示灰线
            [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
            
            //背景色透明度
            [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor colorWithWhite:1 alpha:offsetY/240]] forBarMetrics:UIBarMetricsDefault];
            
        }else if(scrollView.contentOffset.y<=236){
            
            //更换左侧导航栏图片和透明度
            [_leftBtn setBackgroundImage:[UIImage imageNamed:@"app_back"] forState:UIControlStateNormal];
            _leftBtn.alpha=(offsetY-150)/86;
            
            //更换右侧导航栏图片和透明度
            [_rightBtn setBackgroundImage:[UIImage imageNamed:@"uc_img_share"] forState:UIControlStateNormal];
             _rightBtn.alpha=(offsetY-150)/86;
            
            //导航栏底部显示灰线
            [self.navigationController.navigationBar setShadowImage:[self imageWithColor:[UIColor colorWithWhite:0.9 alpha:1]]];
            [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor colorWithWhite:1 alpha:offsetY/240]] forBarMetrics:UIBarMetricsDefault];
            
        }else{
            
            [_leftBtn setBackgroundImage:[UIImage imageNamed:@"app_back"] forState:UIControlStateNormal];
            _leftBtn.alpha=1;
            
            //更换右侧导航栏图片和透明度
            [_rightBtn setBackgroundImage:[UIImage imageNamed:@"uc_img_share"] forState:UIControlStateNormal];
            _rightBtn.alpha=1;
            
            //导航栏底部显示灰线
            [self.navigationController.navigationBar setShadowImage:[self imageWithColor:[UIColor colorWithWhite:0.9 alpha:1]]];
            
            //透明度不可以>=1,不然从后台进入前台后tableView下移64(此处为一个坑,常见的坑)
            [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor colorWithWhite:1 alpha:0.99]] forBarMetrics:UIBarMetricsDefault];
        }
        
    }
}


@end
