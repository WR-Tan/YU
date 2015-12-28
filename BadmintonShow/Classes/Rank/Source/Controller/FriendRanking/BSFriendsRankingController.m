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
    [BSRankDataBusiness queryFriendRankDataWithBlock:^(NSArray *objects, NSError *error) {
        [SVProgressHUD dismiss];
        if (error) {
            [self.view addSubview:self.showErrorLabel];
            return ;
        }
        [self.showErrorLabel removeFromSuperview];
        
        _rankArray = objects.mutableCopy;
        [self.tableView reloadData];
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
