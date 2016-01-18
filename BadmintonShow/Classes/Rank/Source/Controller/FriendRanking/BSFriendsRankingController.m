//
//  BSFriendsRankingController.m
//  BadmintonShow
//
//  Created by lizhihua on 12/22/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSFriendsRankingController.h"
#import "BSRankDataBusiness.h"
#import "SVProgressHUD.h"
#import "BSProfileUserModel.h"

@interface BSFriendsRankingController ()

@end

@implementation BSFriendsRankingController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"好友排名";
}

- (void)loadRankData {
    [SVProgressHUD show];
//    _querySuccessCount = 0;
//    _querySkip = 0;
    [BSRankDataBusiness queryFriendRankDataWithBlock:^(NSArray *objects, NSError *error) {
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        if (error) {
            [self.view addSubview:self.showErrorLabel];
            return ;
        }
        
        [self arrary:objects sortUserByScore:^(NSMutableArray *arr) {
            _rankArray = arr;
            [self.showErrorLabel removeFromSuperview];
            [self.tableView reloadData];
        }];
    }];
}


- (void)arrary:(NSArray *)array sortUserByScore:(void(^)(NSMutableArray *arr))block{
    
    NSMutableArray *descentArr = array.mutableCopy;
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:AVPropertyScore ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    [descentArr sortUsingDescriptors:sortDescriptors];
    block(descentArr);
}


- (void)loadMoreData {
//    [BSRankDataBusiness queryFriendRankDataWithLimit:kQueryLimit skip:_querySkip block:^(NSArray *objects, NSError *error) {
//        [SVProgressHUD dismiss];
//        [self.tableView.mj_footer endRefreshing];
//        if (error) {
//            [self.view addSubview:self.showErrorLabel];
//            return ;
//        }
//        
//        _querySuccessCount ++ ;
//        _querySkip = kQueryLimit * _querySuccessCount;
//        [_rankArray addObjectsFromArray:objects];
//        
//        [self.showErrorLabel removeFromSuperview];
//        [self.tableView reloadData];
//    }];

    
    
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
