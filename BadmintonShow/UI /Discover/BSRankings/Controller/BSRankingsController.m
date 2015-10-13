//
//  BSRankingsController.m
//  BadmintonShow
//
//  Created by lzh on 15/7/5.
//  Copyright (c) 2015年 LZH. All rights reserved.
//

#import "BSRankingsController.h"

#define kCount 4

@interface BSRankingsController ()<UIScrollViewDelegate>
{
    UIScrollView *_scroll;  // 滚动视图
    UISegmentedControl *_segment;    //分区视图控制器
}
@end

@implementation BSRankingsController

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
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"好友排名",@"地区排名",@"中国排名",@"世界排名"] ];
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

    _scroll.contentOffset = CGPointMake(kScreenWidth * Index , 0);
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
//    addSubviews,addChildController
}


#pragma mark 滚动视图ScrollView代理
//  结束减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGFloat x = scrollView.contentOffset.x;
    
//    _segment.selectedSegmentIndex = ( x >= kScreenWidth ) ? 1 : 0;
}

@end