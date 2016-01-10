//
//  BSSkyLadderViewController.m
//  BadmintonShow
//
//  Created by lzh on 15/9/1.
//  Copyright (c) 2015年 LZH. All rights reserved.
//

#import "BSSkyLadderViewController.h"
#import "SVProgressHUD.h"
#import "BSRankDataBusiness.h"

@interface BSSkyLadderViewController ()  
@end

@implementation BSSkyLadderViewController


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"羽秀·天梯";
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
}

- (void)loadRankData{
    // 第一次加载。下拉刷新
    _querySuccessCount = 0;
    _querySkip = 0;
    
    [BSRankDataBusiness queryRankUserDataWithLimit:kQueryLimit skip:_querySkip block:^(NSArray *objects, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [SVProgressHUD dismiss];
        
        if (error) {
           [SVProgressHUD showErrorWithStatus:@"获取排名出错，请检查网络"];
            return ;
        }
        
        _querySuccessCount = 1;
        _querySkip = kQueryLimit;
        _rankArray = objects.mutableCopy;
        
        [self.showErrorLabel removeFromSuperview];
        [self.tableView reloadData];
    }];
}

- (void)loadMoreData{
    [BSRankDataBusiness queryRankUserDataWithLimit:kQueryLimit skip:_querySkip block:^(NSArray *objects, NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"获取排名出错，请检查网络"];
            return ;
        }
        
        if (!objects) return;
        
        _querySuccessCount ++ ;
        _querySkip = kQueryLimit * _querySuccessCount;
        [_rankArray addObjectsFromArray:objects];
        
        [self.showErrorLabel removeFromSuperview];
        [self.tableView reloadData];
    }];
    
    
    
  
}


@end

