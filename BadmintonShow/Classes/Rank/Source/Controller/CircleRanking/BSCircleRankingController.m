//
//  BSCircleRankingController.m
//  BadmintonShow
//
//  Created by lizhihua on 12/23/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSCircleRankingController.h"
#import "BSRankDataBusiness.h"
#import "SVProgressHUD.h"
#import "BSCircleMenuView.h"
#import "BSCreateCircleController.h"
#import "BSJionCircleViewController.h"
#import "BSSwitchCircleView.h"
#import "BSCircleBusiness.h"



@implementation DowArrowButton
@end


static NSTimeInterval animationTime = 0.5;


@interface BSCircleRankingController () <BSCircleMenuViewDelegate, BSSwitchCircleViewDelegate>
@property (nonatomic, strong) BSCircleMenuView *menuView;
@property (nonatomic, strong) BSSwitchCircleView *switchView;
@property (nonatomic, strong) DowArrowButton *titleButton;
@property (nonatomic, strong) NSMutableArray *jionedCircles;
@property (nonatomic, strong) BSCircleModel *selectedCircle;
@end

@implementation BSCircleRankingController

#pragma mark - public

- (void)loadRankData{
    [self queryJionedCircles];
}


#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self constructBaseView];
    [self queryJionedCircles]; //加入了什么圈子
}

- (void)constructBaseView{
    @weakify(self);
    DowArrowButton *titleButton = [DowArrowButton buttonWithType:UIButtonTypeCustom];
    titleButton.hidden = YES;
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titleButton.frame = CGRectMake(0, 0, 300, 30);
    [titleButton addTarget:self forControlEvents:UIControlEventTouchUpInside action:^(id sender) {
        [weak_self displayCategoryOrNot];
    }];
    self.navigationItem.titleView = titleButton;
    self.titleButton = titleButton;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrowdown_grey"] style:UIBarButtonItemStyleDone target:self action:@selector(displayCategoryOrNot)];
    
    // 上拉刷新查询更多
    // 上拉刷新
    }


/// 获取用户加入了什么圈子.  内部做缓存
- (void)queryJionedCircles{
    [SVProgressHUD show];
    [BSCircleBusiness queryMyCirclesWithBlock:^(NSArray *objects, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"获取分类出错"];
            return ;
        }
        if (!objects.count)  return;
        
        
        [self.switchView reloadDataWith:objects];
        [self setTitleAndQueryRanking:(BSCircleModel *)(objects.firstObject)];
    }];
}


/// 设置title，并且查询圈内玩家排名
- (void)setTitleAndQueryRanking:(BSCircleModel *)circle{
    self.titleButton.hidden = NO;
    [self.titleButton setTitle:circle.name forState:UIControlStateNormal];
    
    self.selectedCircle = circle;
    [self queryRankingInCircle];
}

/// 查询某个圈子所有玩家排名。
- (void)queryRankingInCircle{
    // 第一次加载。下拉刷新
    _querySuccessCount = 0;
    _querySkip = 0;
    
    [SVProgressHUD show];
    [BSRankDataBusiness queryRankingInCircle:self.selectedCircle limit:kQueryLimit skip:_querySkip block:^(NSArray *objects, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView.mj_header endRefreshing];
            
            if (error) {
                [SVProgressHUD showErrorWithStatus:@"请求数据错误.."];
                return ;
            }
            [SVProgressHUD dismiss];
            if (!objects) return;
            
            _querySuccessCount = 1;
            _querySkip = kQueryLimit;
            
            _rankArray = objects.mutableCopy;
            [self.tableView reloadData];
        });
    }];
}


- (void)loadMoreData{
    // 第一次加载。下拉刷新
        [SVProgressHUD show];
    [BSRankDataBusiness queryRankingInCircle:self.selectedCircle limit:kQueryLimit skip:_querySkip block:^(NSArray *objects, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView.mj_footer endRefreshing];
            
            
            if (error) {
                [SVProgressHUD showErrorWithStatus:@"请求数据错误.."];
                return ;
            }
            [SVProgressHUD dismiss];
            if (!objects) return;
            
            _querySuccessCount ++ ;
            _querySkip = kQueryLimit * _querySuccessCount;
            
            [_rankArray addObjectsFromArray:objects];
            [self.tableView reloadData];
        });
    }];
    
    
    
   
}


#pragma mark - 加载排名数据


#pragma mark - 切换分类

- (BSSwitchCircleView *)switchView {
    if (!_switchView) {
        _switchView = [BSSwitchCircleView switchView];
        _switchView.delegate = self;
    }
    return _switchView;
}

//static bool _isArrowDown = YES;

- (void)displayCategoryOrNot{
    
//    UIButton *button = (UIButton *)self.navigationItem.rightBarButtonItem.customView;
//    UIImageView *imageView = button.imageView;
//    if (_isArrowDown) {
//        imageView.transform = CGAffineTransformMakeRotation( M_PI);
//    } else {
//        imageView.transform = CGAffineTransformMakeRotation( -M_PI);
//    }
//    _isArrowDown = !_isArrowDown;
    
    if (self.switchView.superview == self.view) {
        [UIView animateWithDuration:animationTime animations:^{
            [self.switchView removeFromSuperview];
        }];
        
    } else {
        [UIView animateWithDuration:animationTime animations:^{
            [self.view addSubview:self.switchView];
        }];
    }
}

- (void)switchView:(BSSwitchCircleView *)switchView didSelectCircle:(BSCircleModel *)circle {
    [self displayCategoryOrNot];
    
    [self setTitleAndQueryRanking:circle];
}

#pragma mark - 加入圈子

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
 
    if (self.switchView.superview == self.view) {
        [self.switchView removeFromSuperview];
    }
}


#pragma mark - lazy

- (NSMutableArray *)jionedCircles {
    if (!_jionedCircles) {
        _jionedCircles = [NSMutableArray array];
    }
    return _jionedCircles;
}


@end
