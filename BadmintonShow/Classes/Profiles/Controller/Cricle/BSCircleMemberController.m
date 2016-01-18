//
//  BSCircleMemberController.m
//  BadmintonShow
//
//  Created by lizhihua on 16/1/6.
//  Copyright © 2016年 LZH. All rights reserved.
//

#import "BSCircleMemberController.h"
#import "BSRankDataBusiness.h"
#import "BSCircleModel.h"
#import "MJRefresh.h"

@interface BSCircleMemberController ()

@end

@implementation BSCircleMemberController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.circle.name;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadRankData];
    }];
}

- (void)loadRankData{
    [self queryRankingInCircle:self.circle];
}

/// 查询某个圈子所有玩家排名。
- (void)queryRankingInCircle:(BSCircleModel *)circle{
    _querySuccessCount = 0;
    _querySkip = 0;
    [BSRankDataBusiness queryRankingInCircle:self.circle limit:kQueryLimit skip:_querySkip block:^(NSArray *objects, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView.mj_header endRefreshing];
            
            if (error) {
                [SVProgressHUD showErrorWithStatus:@"请求数据错误.."];
                return ;
            }
            if (!objects) return;
            
            _querySuccessCount = 1;
            _querySkip = kQueryLimit;
            
            _rankArray = objects.mutableCopy;
            [self.tableView reloadData];
        });
    }];
}


- (void)loadMoreData {
    // 第一次加载。下拉刷新
    [BSRankDataBusiness queryRankingInCircle:self.circle limit:kQueryLimit skip:_querySkip block:^(NSArray *objects, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView.mj_footer endRefreshing];
            
            if (error) {
                [SVProgressHUD showErrorWithStatus:@"请求数据错误.."];
                return ;
            }
            if (!objects) return;
            
            _querySuccessCount ++ ;
            _querySkip = kQueryLimit * _querySuccessCount;
            
            [_rankArray addObjectsFromArray:objects];
            [self.tableView reloadData];
        });
    }];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
