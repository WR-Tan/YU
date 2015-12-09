//
//  BSHomePageViewController.m
//  BadmintonShow
//
//  Created by LZH on 15/12/5.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import "BSHomePageViewController.h"
#import "BSGameTipsViewController.h"
#import "HMSegmentedControl.h"
//#import "BSGameGIFViewController.h"


@interface BSHomePageViewController ()<
    UIScrollViewDelegate
>
@property (nonatomic, strong) UIScrollView *contentScrollView ;
@end

#define kSegmentedCtrolHeight 20

@implementation BSHomePageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.navigationController.navigationBar.hidden = YES ;
    
    HMSegmentedControl *seg = [[HMSegmentedControl alloc] init];
    seg.sectionTitles = @[@"百度",@"腾讯"];
    seg.frame = CGRectMake(0, 20, self.view.bounds.size.width, 44);
    seg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:seg];
    
    // 关闭ios7scrollview的自动布局
    self.automaticallyAdjustsScrollViewInsets = NO;
    _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64-49)];
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.bounces = NO;
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    _contentScrollView.contentSize = CGSizeMake(2 * self.view.bounds.size.width, 0);
    _contentScrollView.delegate = self;
    _contentScrollView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_contentScrollView];
    
    CGFloat viewWidth = _contentScrollView.frame.size.width;
    
    BSGameTipsViewController *vc = [[BSGameTipsViewController alloc] init];

    vc.view.frame = CGRectMake(0, 0, viewWidth * 2, _contentScrollView.frame.size.height);
    vc.tableView.contentInset = UIEdgeInsetsMake(0, 0, 76, 0);
    [_contentScrollView addSubview: vc.view];
    [self addChildViewController:vc];

}





 @end
