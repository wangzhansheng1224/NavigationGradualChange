//
//  UITableView+Category.m
//  导航栏颜色渐变
//
//  Created by 王战胜 on 2016/12/22.
//  Copyright © 2016年 gocomtech. All rights reserved.
//

#import "MJRefresh.h"
#import "UITableView+Category.h"

static const float kAnimationDuration = 0.25f;
static const char jy_originContentHeight;
static const char jy_secondScrollView;

@interface UITableView()

@property (nonatomic, assign) float originContentHeight;

@end

@implementation UITableView (Category)

- (void)setOriginContentHeight:(float)originContentHeight {
    objc_setAssociatedObject(self, &jy_originContentHeight, @(originContentHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (float)originContentHeight {
    return [objc_getAssociatedObject(self, &jy_originContentHeight) floatValue];
}


- (void)setFirstScrollView:(UITableView *)firstScrollView {
    [self addFirstScrollViewFooter];
}

- (UITableView *)secondScrollView {
    return objc_getAssociatedObject(self, &jy_secondScrollView);
}

- (void)setSecondScrollView:(UITableView *)secondScrollView {
    objc_setAssociatedObject(self, &jy_secondScrollView, secondScrollView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self addFirstScrollViewFooter];
    
    CGRect frame = self.bounds;
    frame.origin.y = self.contentSize.height + self.footer.frame.size.height;
    secondScrollView.frame = frame;
    
    [self addSubview:secondScrollView];
    
    [self addSecondScrollViewHeader];
}

- (void)addFirstScrollViewFooter {
    __weak __typeof(self) weakSelf = self;
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf endFooterRefreshing];
    }];
//    footer.appearencePercentTriggerAutoRefresh = 2;
    [footer setTitle:@"继续拖动,查看图文详情" forState:MJRefreshStateIdle];
    
    self.footer = footer;
}

- (void)addSecondScrollViewHeader {
    __weak __typeof(self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf endHeaderRefreshing];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"下拉,返回宝贝详情" forState:MJRefreshStateIdle];
    [header setTitle:@"释放,返回宝贝详情" forState:MJRefreshStatePulling];
    
    self.secondScrollView.header = header;
}

- (void)endFooterRefreshing {
    [self.footer endRefreshing];
    self.footer.hidden = YES;
    self.scrollEnabled = NO;
    
    self.secondScrollView.header.hidden = NO;
    self.secondScrollView.scrollEnabled = YES;
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.contentInset = UIEdgeInsetsMake(-self.contentSize.height - self.footer.frame.size.height+64, 0, 0, 0);
    }];
    
    self.originContentHeight = self.contentSize.height;
    self.contentSize = self.secondScrollView.contentSize;
}

- (void)endHeaderRefreshing {
    [self.secondScrollView.header endRefreshing];
    self.secondScrollView.header.hidden = YES;
    self.secondScrollView.scrollEnabled = NO;
    
    self.scrollEnabled = YES;
    
    NSLog(@"%f",self.footer.frame.size.height);
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }];
    self.contentSize = CGSizeMake(0, self.originContentHeight);
    
    [self setContentOffset:CGPointZero animated:YES];
    
    [self addFirstScrollViewFooter];
}

@end
