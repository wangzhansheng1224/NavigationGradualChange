//
//  ViewController.m
//  tableview和image效果展示
//
//  Created by lxk on 16/7/29.
//  Copyright © 2016年 lxk. All rights reserved.
//

#import "ViewController.h"
#import "CycleView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) CycleView *scroll;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor redColor];
    [UIApplication sharedApplication].statusBarHidden = YES;
    [self createTableView];
    [self createCycleView];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)createTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    
}
-(void)createCycleView{
    _scroll = [[CycleView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    [_scroll updataWithArray:@[@"101.jpg",@"102.jpg",@"103.jpg",@"104.jpg",@"105.jpg",]];
    [self.view addSubview:_scroll];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"heh"];
    if (cell == nil) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"heh"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"我是第%ld行",indexPath.row];
    return cell;
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_scroll) {
        [_scroll stopTimer];
    }
    NSLog(@"%lf",scrollView.contentOffset.y);
    
    if (scrollView.contentOffset.y <= 0) {
        CGRect rect = _scroll.frame;
        rect.size.width = (1 - scrollView.contentOffset.y/200.0)*self.view.bounds.size.width;
        rect.size.height = (1 - scrollView.contentOffset.y/200.0)*200;
        rect.origin.x = -(rect.size.width - self.view.bounds.size.width)/2.0;
        _scroll.frame = rect;
        [self.view bringSubviewToFront:_scroll];
        
        [_scroll layoutSubviews];
        [_scroll updateFrame];
        
    }else{
        [self.view bringSubviewToFront:scrollView];
        CGRect rect = _scroll.frame;
        rect.origin.y = -(scrollView.contentOffset.y)/2.5;
        _scroll.frame = rect;
        [_scroll layoutSubviews];
        [_scroll updateFrame];
        
    }

    if (_scroll) {
        [_scroll startTimer];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    view.backgroundColor = [UIColor clearColor];
    
    return view;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 200;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}
@end
