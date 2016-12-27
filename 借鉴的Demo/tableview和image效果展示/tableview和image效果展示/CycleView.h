//
//  CycleView.h
//  NewJiaDe
//
//  Created by lxk on 16/6/17.
//  Copyright © 2016年 artron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CycleView : UIView<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scorllView;
@property (nonatomic,strong) NSTimer *timer;
-(void)updataWithArray:(NSArray *)dataArray;
@property (nonatomic,strong) UIImageView * centerImageView;
@property (nonatomic,strong) UIImageView * leftImageView;
@property (nonatomic,strong) UIImageView * rightImageView;
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,assign) NSInteger index;
-(void)updateFrame;
-(void)startTimer;
-(void)stopTimer;
@end
