//
//  ViewController.m
//  导航栏颜色渐变
//
//  Created by 王战胜 on 2016/12/16.
//  Copyright © 2016年 gocomtech. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "TableViewCell.h"
#import "NextViewController.h"
#import "UITableView+Category.h"
#import "XTADScrollView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UILabel *tittleLabel;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
//    self.automaticallyAdjustsScrollViewInsets=NO;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    [self createNavigation];
    [self.view addSubview:self.headView];
    [self.view addSubview:self.tableView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (UIView *)headView{
    if (!_headView) {
        
        _headView=[[UIView alloc]initWithFrame:CGRectMake(0, -100, SCREEN_WIDTH, SCREEN_WIDTH+100)];
        
        XTADScrollView *scrollView=[[XTADScrollView alloc]initWithFrame:CGRectMake(0, 75, SCREEN_WIDTH, SCREEN_WIDTH)];
        scrollView.infiniteLoop=YES;
        scrollView.pageControlPositionType=pageControlPositionTypeRight;
        scrollView.needPageControl=YES;
        scrollView.imageArray=@[@"head",@"head1",@"head2",@"head3",@"head4"];
        [_headView addSubview:scrollView];
        
        _tittleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 15)];
        _tittleLabel.text=@"下拉查看更多精彩";
        _tittleLabel.font=[UIFont systemFontOfSize:13];
        _tittleLabel.center=CGPointMake(SCREEN_WIDTH/2+10, 70);
        _tittleLabel.textAlignment=NSTextAlignmentCenter;
        [_headView addSubview:_tittleLabel];
        
        _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 18, 18)];
        _imageView.tintColor=[UIColor blueColor];
        _imageView.center=CGPointMake(_tittleLabel.center.x-60-10, _tittleLabel.center.y);
        _imageView.image=[UIImage imageNamed:@"arrow"];
        [_headView addSubview:_imageView];
        
    }
    return _headView;
}

- (void)createNavigation{
    
    //导航栏左侧Button
    _leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [_leftBtn setBackgroundImage:[UIImage imageNamed:@"enjoy_icon_back"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:_leftBtn];
    [_leftBtn addTarget:self action:@selector(leftbtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //导航栏右侧Button
    _rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [_rightBtn setBackgroundImage:[UIImage imageNamed:@"enjoy_icon_share"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:_rightBtn];
    
    //此方法设置透明无效果
    //    self.navigationController.navigationBar.barTintColor=[UIColor colorWithWhite:1 alpha:0];
    //设置导航栏背景色
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor colorWithWhite:1 alpha:0]] forBarMetrics:UIBarMetricsDefault];
    
    //去掉导航栏底部的黑线
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)leftbtnClick{
    NSLog(@"左button被点击了");
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
        self.tableView.showsVerticalScrollIndicator=NO;
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        view.backgroundColor=[UIColor colorWithWhite:0.9 alpha:1];
        _tableView.tableFooterView=view;
        [_tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
        
        NextViewController *detailVC = [[NextViewController alloc] init];
        [self addChildViewController:detailVC];
        
        // just for force load view
        if (detailVC.view != nil) {
//            self.tableView.secondScrollView = detailVC.tableView;
            self.tableView.secondScrollView=detailVC.tableView;
        }
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.imageview.image=[UIImage imageNamed:[NSString stringWithFormat:@"image%ld",(long)indexPath.row+1]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300;
}

//设置透明组头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
    view.backgroundColor=[UIColor clearColor];
    return view;
}

//作图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SCREEN_WIDTH;
}

#pragma mark -- 核心(手指滑动时tableView的回调)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY=scrollView.contentOffset.y;
    CGFloat halfheight=SCREEN_WIDTH/2;
    if (offsetY<=0) {
        
        //图片放大
        CGRect frame=_headView.frame;
        frame.origin.y=-offsetY-100;
        _headView.frame=frame;
        
        //导航栏初始化状态
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"enjoy_icon_back"]forState:UIControlStateNormal];
        _leftBtn.alpha=1;
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"enjoy_icon_share"] forState:UIControlStateNormal];
        _rightBtn.alpha=1;
        [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor colorWithWhite:1 alpha:0]] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
        
        //下拉状态
        if (-offsetY<=40) {
            _tittleLabel.text=@"下拉查看更多精彩";
            _imageView.transform = CGAffineTransformMakeRotation(0);
        }else if(-offsetY<=80) {
            _tittleLabel.text=@"下拉查看更多精彩";
            _imageView.transform = CGAffineTransformMakeRotation((-offsetY-40)/12.7);
        }else{
            _tittleLabel.text=@"释放查看更多精彩";
             _imageView.transform = CGAffineTransformMakeRotation(3.15);
        }
        
        
    }else{
        
        //图片上移
        CGRect frame=_headView.frame;
        frame.origin.y=-offsetY/2.5-100;
        _headView.frame=frame;
        
        //导航栏itm的变化方法
        if (offsetY<=halfheight) {
            
            //恢复左侧导航栏图片和透明度
            [_leftBtn setBackgroundImage:[UIImage imageNamed:@"enjoy_icon_back"]forState:UIControlStateNormal];
            _leftBtn.alpha=1-offsetY/halfheight;
            
            //恢复右侧导航栏图片和透明度
            [_rightBtn setBackgroundImage:[UIImage imageNamed:@"enjoy_icon_share"] forState:UIControlStateNormal];
            _rightBtn.alpha=1-offsetY/halfheight;
            
            //导航栏底部不显示灰线
            [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
            
            //背景色透明度
            [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor colorWithWhite:1 alpha:offsetY/(SCREEN_WIDTH-64)]] forBarMetrics:UIBarMetricsDefault];
            
        }else if(offsetY<=(SCREEN_WIDTH-64)){
            
            //更换左侧导航栏图片和透明度
            [_leftBtn setBackgroundImage:[UIImage imageNamed:@"app_back"] forState:UIControlStateNormal];
            _leftBtn.alpha=(offsetY-halfheight)/(halfheight-60);
            
            //更换右侧导航栏图片和透明度
            [_rightBtn setBackgroundImage:[UIImage imageNamed:@"uc_img_share"] forState:UIControlStateNormal];
             _rightBtn.alpha=(offsetY-halfheight)/(halfheight-60);
            
            //导航栏底部显示灰线
            [self.navigationController.navigationBar setShadowImage:[self imageWithColor:[UIColor colorWithWhite:0.9 alpha:(offsetY-halfheight)/(halfheight-60)]]];
            [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor colorWithWhite:1 alpha:offsetY/(SCREEN_WIDTH-60)]] forBarMetrics:UIBarMetricsDefault];
            
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

#pragma mark -- 手指离开时tableView的回调
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    
    if (scrollView.contentOffset.y<=-80) {
        
        SecondViewController *twoVC = [[SecondViewController alloc]init];
        twoVC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        
        // 核心代码
        self.definesPresentationContext = YES;
        // 可以使用的Style
        // UIModalPresentationOverCurrentContext
        // UIModalPresentationOverFullScreen
        // UIModalPresentationCustom
        // 使用其他Style会黑屏
        twoVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        
//        typedef enum {
//            UIModalTransitionStyleCoverVertical=0,//默认方式，竖向上推
//            UIModalTransitionStyleFlipHorizontal, //水平反转
//            UIModalTransitionStyleCrossDissolve,//隐出隐现
//            UIModalTransitionStylePartialCurl,//部分翻页效果
//        } UIModalTransitionStyle;
        twoVC.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
        [self.navigationController presentViewController:twoVC animated:YES completion:nil];

    }
    
}


@end
