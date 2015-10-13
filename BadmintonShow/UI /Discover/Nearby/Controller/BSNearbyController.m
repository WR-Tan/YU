//
//  BSNearbyController.m
//  BadmintonShow
//
//  Created by lzh on 15/6/30.
//  Copyright (c) 2015年 LZH. All rights reserved.
//  附近-包括附近的人、附近的场地

#import "BSNearbyController.h"
#import "BSNearbyBadmintonHallController.h"
#import "BSNearbyPlayerController.h"

#define kCount 2

@interface BSNearbyController ()<UIScrollViewDelegate>
{
    UIScrollView *_scroll;  // 滚动视图
    UISegmentedControl *_segment;    //分区视图控制器
}
@end

@implementation BSNearbyController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addScrollView];
    
    [self addScrollViews];
    
    [self addSegmentControl];
}

#pragma mark - UI界面初始化

#pragma mark 添加分区视图控制
- (void)addSegmentControl
{
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"附近的人",@"附近场地"] ];
    segment.bounds  = CGRectMake(0, 0,  100 , 30);
    segment.center  = CGPointMake( kScreenWidth / 2,  kScreenHeigth / 2);
    segment.selectedSegmentIndex = 0;
    _segment = segment;
    self.navigationItem.titleView = segment;
    
    [segment addTarget:self action:@selector(didClicksegmentedControlAction:)forControlEvents:UIControlEventValueChanged];
}

-(void)didClicksegmentedControlAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    NSLog(@"Index %ld", Index);
    switch (Index) {
        case 0:
            _scroll.contentOffset = CGPointMake(0, 0);
            break;
        case 1:
             _scroll.contentOffset = CGPointMake(kScreenWidth, 0);
            break;
            
    }
}


#pragma mark 添加滚动视图
- (void)addScrollView
{
    UIScrollView *scroll = [[UIScrollView alloc] init];
    scroll.frame = self.view.bounds;
    CGSize size = scroll.frame.size;
    scroll.contentSize = CGSizeMake(size.width * kCount, 0); // 内容尺寸
    scroll.pagingEnabled = YES; // 分页
    scroll.delegate = self;
    [self.view addSubview:scroll];
    _scroll = scroll;
}


#pragma mark 添加滚动显示的图片
- (void)addScrollViews
{
    BSNearbyPlayerController *nearbyPeople = [[BSNearbyPlayerController alloc] init];
    [self addChildViewController:nearbyPeople];
    [_scroll addSubview:nearbyPeople.view];
    nearbyPeople.view.backgroundColor = [UIColor purpleColor];
    
    
    BSNearbyBadmintonHallController *nearbyBadmintonHall = [[BSNearbyBadmintonHallController alloc] init];
    [self addChildViewController:nearbyBadmintonHall];
    
    CGRect rect = self.view.bounds;
    rect.origin.x = self.view.bounds.size.width;
    nearbyBadmintonHall.view.frame = rect;
    [_scroll addSubview:nearbyBadmintonHall.view];
    nearbyBadmintonHall.view.backgroundColor = [UIColor yellowColor];
}


#pragma mark 滚动视图ScrollView代理
//  结束减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    CGFloat x = scrollView.contentOffset.x;
    
    _segment.selectedSegmentIndex = ( x >= kScreenWidth ) ? 1 : 0;
}

@end
