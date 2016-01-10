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

@interface BSCircleMemberController ()

@end

@implementation BSCircleMemberController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.circle.name;
}

- (void)loadRankData{
    [self queryRankingInCircle:self.circle];
}

/// 查询某个圈子所有玩家排名。
- (void)queryRankingInCircle:(BSCircleModel *)circle{
    [BSRankDataBusiness queryRankingInCircle:circle  limit:10 skip:10 block:^(NSArray *objects, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView.mj_header endRefreshing];
            
            if (error) {
                [SVProgressHUD showErrorWithStatus:@"请求数据错误.."];
                return ;
            }
            
            if (!objects) return;
            _rankArray = objects.mutableCopy;
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
