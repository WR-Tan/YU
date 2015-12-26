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

@interface BSCircleRankingController () <BSCircleMenuViewDelegate>
@property (nonatomic, strong) BSCircleMenuView *menuView;
@end

@implementation BSCircleRankingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"深圳大学";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(jionCircle)];
}

#pragma mark - 加入圈子

- (void)jionCircle{
    if (!self.menuView) {
        self.menuView = [BSCircleMenuView menuView];
        self.menuView.delegate = self;
    }
    [self displayMenuOrNot];
}

- (void)displayMenuOrNot{
    if (self.menuView.superview == self.view) {
        [self.menuView removeFromSuperview];
    } else {
        [self.view addSubview:self.menuView];
    }
}

- (void)menu:(BSCircleMenuView *)menu didClickIndex:(NSUInteger)index {
    [self displayMenuOrNot];
    
    if (index == 0) {
        BSJionCircleViewController *jiosnVC = [[BSJionCircleViewController alloc] init];
        [self.navigationController pushViewController:jiosnVC animated:YES];
    } else {
        BSCreateCircleController *createCircelVC = [[BSCreateCircleController alloc] init];
        [self.navigationController pushViewController:createCircelVC animated:YES];
    }
    
}


- (void)loadRankData{
    [SVProgressHUD show];
    
    [BSRankDataBusiness queryCircleRankDataCircleClass:AVClassSchool property:AVPropertySchool block:^(NSArray *objects, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
        if (error) {
            [self.view addSubview:self.showErrorLabel];
            return ;
        }
        [self.showErrorLabel removeFromSuperview];
        _rankArray = objects.mutableCopy;
        [self.tableView reloadData];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.menuView.superview == self.view) {
        [self.menuView removeFromSuperview];
    }
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
