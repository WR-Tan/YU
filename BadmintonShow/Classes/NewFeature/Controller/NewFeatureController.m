//
//  NewFeatureController.m
//  BadmintonShow
//
//  Created by lzh on 15/6/22.
//  Copyright (c) 2015年 LZH. All rights reserved.
//

#import "NewFeatureController.h"
#import "BSRankController.h"
#import "AppDelegate.h"
#import "BSTabBarController.h"
#import "BSLoginController.h"
#import "AppDelegate.h"

#define kCount 4

@interface NewFeatureController () <UIScrollViewDelegate>
{
    UIPageControl *_page;
    UIScrollView  *_scroll;
}
@end

@implementation NewFeatureController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.添加UIScrollView
    [self addScrollView];
    
    // 2.添加图片
    [self addScrollImages];
    
    // 3.添加UIPageControl
    [self addPageControl];
}

#pragma mark - UI界面初始化
#pragma mark 添加滚动视图
- (void)addScrollView
{
    UIScrollView *scroll = [[UIScrollView alloc] init];
    scroll.frame = self.view.bounds;
    scroll.showsHorizontalScrollIndicator = NO; // 隐藏水平滚动条
    CGSize size = scroll.frame.size;
    scroll.contentSize = CGSizeMake(size.width * kCount, 0); // 内容尺寸
    scroll.pagingEnabled = YES; // 分页
    scroll.delegate = self;
    [self.view addSubview:scroll];
    _scroll = scroll;
}

#pragma mark 添加滚动显示的图片
- (void)addScrollImages
{
    CGSize size = _scroll.frame.size;
    
    NSArray *imageNamesArray = @[@"LinDan.jpg",@"LiZongWei.jpg",@"Taufik.jpg",@"Gade.jpg"];
    
    for (int i = 0; i<kCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        // 1.显示图片
        NSString *name =   imageNamesArray[i] ;
        imageView.image = [UIImage imageNamed:name];
        // 2.设置frame
        imageView.frame = CGRectMake(i * size.width, 0, size.width, size.height);
        [_scroll addSubview:imageView];
        
        
    }
    
    // 最后一页，添加2个按钮
        // 3.注册
        UIButton *signup = [UIButton buttonWithType:UIButtonTypeCustom];
        signup.backgroundColor = [UIColor yellowColor];
        [signup setTitle:@"注册" forState:UIControlStateNormal];
        [signup setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        signup.center = CGPointMake(size.width * 0.5, size.height * 0.8);
        signup.bounds = (CGRect){CGPointZero, {80,40}};
        [signup addTarget:self action:@selector(signup) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:signup];
        
        // 4.登录
        UIButton *share = [UIButton buttonWithType:UIButtonTypeCustom];
        share.backgroundColor = [UIColor yellowColor];
        [share setTitle:@"登录" forState:UIControlStateNormal];
        [share setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        // 普通状态显示的图片（selected=NO）
        UIImage *shareNormal = [UIImage imageNamed:@"new_feature_share_false.png"];
        [share setBackgroundImage:shareNormal forState:UIControlStateNormal];
        // 选中状态显示的图片（selected=YES）
        [share setBackgroundImage:[UIImage imageNamed:@"new_feature_share_true.png"] forState:UIControlStateSelected];
        
        share.center = CGPointMake(signup.center.x, signup.center.y - 50);
        share.bounds = (CGRect){CGPointZero, {80,40}};
        [share addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
        
        share.selected = YES;
        
        // 按钮在高亮的时候不需要变灰色
        share.adjustsImageWhenHighlighted = NO;
        
        [self.view addSubview:share];
        
        self.view.userInteractionEnabled = YES;
        
        DLog(@"signup = %@ , share = %@",NSStringFromCGRect(signup.frame),NSStringFromCGRect(share.frame));

}

#pragma mark 添加分页指示器
- (void)addPageControl
{
    CGSize size = self.view.frame.size;
    UIPageControl *page = [[UIPageControl alloc] init];
    page.center = CGPointMake(size.width * 0.5, size.height * 0.95);
    page.numberOfPages = kCount;
    page.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_checked_point.png"]];
    page.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_point.png"]];
    page.bounds = CGRectMake(0, 0, 150, 0);
    [self.view addSubview:page];
    _page = page;
}

#pragma mark - 监听按钮点击
#pragma mark 注册
- (void)signup
{
    DLog(@"注册");
    // 显示状态栏
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.view.window.rootViewController = [[BSLoginController alloc] initWithNibName:@"BSLoginController" bundle:nil] ;
}

#pragma mark 登录
- (void)share:(UIButton *)btn
{

//    [(AppDelegate *)[UIApplication sharedApplication].delegate toMainCtl];
    self.view.window.rootViewController = [[BSLoginController alloc] initWithNibName:@"BSLoginController" bundle:nil] ;
}

#pragma mark - 滚动代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _page.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
}

- (void)dealloc
{
    DLog(@"new----销毁");
}


@end
