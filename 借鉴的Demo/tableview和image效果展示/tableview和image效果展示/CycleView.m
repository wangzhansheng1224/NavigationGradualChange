//
//  CycleView.m
//  NewJiaDe
//
//  Created by lxk on 16/6/17.
//  Copyright © 2016年 artron. All rights reserved.
//

#import "CycleView.h"
//#import "LunboModel.h"
#define W self.bounds.size.width
#define H self.bounds.size.height

@implementation CycleView

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}
//创建主体scrollview
-(void)createView{
    _scorllView = [[UIScrollView alloc]initWithFrame:self.bounds];
    [self addSubview:_scorllView];
    
    _scorllView.pagingEnabled = YES;
    _scorllView.bounces = NO;
    _scorllView.showsVerticalScrollIndicator = NO;
    _scorllView.showsHorizontalScrollIndicator = NO;
    _scorllView.delegate = self;
    self.scorllView.contentSize = CGSizeMake(W * 3, 0);
    self.scorllView.contentOffset = CGPointMake(W, 0);
    //    创建三个UIImageView
    _centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(W, 0, W, H)];
    _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, W, H)];
    _rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(W * 2, 0, W, H)];
    //设置图片方式
    _centerImageView.contentMode = UIViewContentModeScaleAspectFit;
    _leftImageView.contentMode = UIViewContentModeScaleAspectFit;
    _rightImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.scorllView addSubview:_centerImageView];
    [self.scorllView addSubview:_leftImageView];
    [self.scorllView addSubview:_rightImageView];

}
//数据传入,开始滚动
-(void)updataWithArray:(NSArray *)dataArray{

    [self stopTimer];
    _dataArray = dataArray;
    self.index = 0;
    [self setImage];
    [self startTimer];
}
//开启定时器
-(void)startTimer{
    if (_timer == nil) {
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(rollImage) userInfo:nil repeats:YES];
        //如果不添加下面这条语句，在UITableView拖动的时候，会阻塞定时器的调用
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:UITrackingRunLoopMode];
    }
}
//图片滚动
-(void)rollImage{
    self.scorllView.contentOffset = CGPointMake(0, 0);
    [self.scorllView setContentOffset:CGPointMake(W, 0) animated:YES];
    _index++;
    if (_index  > _dataArray.count-1 ) {
        _index = 0;
    }
    [self setImage];
}
-(void)updateFrame{
    _scorllView.frame = self.bounds;
    [_scorllView layoutSubviews];
    _scorllView.contentOffset = CGPointMake(W, 0);
    _centerImageView.frame = CGRectMake(W, 0, W, H);
    _leftImageView.frame = CGRectMake(0, 0, W, H);
    _rightImageView.frame = CGRectMake(W * 2, 0, W, H);
    [_rightImageView layoutSubviews];
    [_centerImageView layoutSubviews];
    [_leftImageView layoutSubviews];
    
}

//关闭定时器
-(void)stopTimer{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}
//拽动的时候取消定时器
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopTimer];
}
//停止之后重新开启定时器
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.x < W/2.0) {
        scrollView.contentOffset = CGPointMake(W, 0);
        _index--;
        if (_index < 0) {
            _index = _dataArray.count-1;
        }
    }
    if (scrollView.contentOffset.x > W *1.5) {
        scrollView.contentOffset = CGPointMake(W, 0);
        _index++;
        if (_index  > _dataArray.count-1 ) {
            _index = 0;
        }
    }
    [self setImage];
    [self startTimer];
}
//设置图片的方法
-(void)setImage{

    if (_dataArray.count > 0) {
        NSString *str1 = _dataArray[_index];
        NSString *str2 = _dataArray[_index-1>=0?_index-1:_dataArray.count-1];
        NSString *str3 = _dataArray[_index+1 <=_dataArray.count-1?_index+1:0];
        _centerImageView.image = [UIImage imageNamed:str1];
        _leftImageView.image = [UIImage imageNamed:str2];
        _rightImageView.image = [UIImage imageNamed:str3];
        
    }else{
    
        _centerImageView.image = nil;
        _leftImageView.image = nil;
        _rightImageView.image = nil;
        
    }
    
}
@end
