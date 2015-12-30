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

@interface BSCircleRankingController () <BSCircleMenuViewDelegate, BSSwitchCircleViewDelegate>
@property (nonatomic, strong) BSCircleMenuView *menuView;
@property (nonatomic, strong) BSSwitchCircleView *switchView;
@end

@implementation BSCircleRankingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"深圳大学";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(displayMenuOrNot)];
    
    @weakify(self);
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleButton setTitle:@"SZU" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titleButton.frame = CGRectMake(0, 0, 80, 30);
    [titleButton addTarget:self forControlEvents:UIControlEventTouchUpInside action:^(id sender) {
        [weak_self displayCategoryOrNot];
    }];
    self.navigationItem.titleView = titleButton;
    
    // 获取用户加入了什么圈子.
    
}

#pragma mark - 切换分类

- (BSSwitchCircleView *)switchView {
    if (!_switchView) {
        _switchView = [BSSwitchCircleView switchView];
        _switchView.delegate = self;
    }
    return _switchView;
}

- (void)displayCategoryOrNot{
    if (self.menuView.superview == self.view) {
        [self.menuView removeFromSuperview];
    }
    
    if (self.switchView.superview == self.view) {
        [self.switchView removeFromSuperview];
    } else {
        [self.view addSubview:self.switchView];
    }
}

- (void)switchView:(BSSwitchCircleView *)switchView didSelectCircle:(BSCircelModel *)circle {
    
    
    [self displayCategoryOrNot];
}

#pragma mark - 加入圈子

- (BSCircleMenuView *)menuView {
    if (!_menuView) {
        _menuView = [BSCircleMenuView menuView];
        _menuView.delegate = self;
    }
    return _menuView;
}

- (void)displayMenuOrNot{
    if (self.switchView.superview == self.view) {
        [self.switchView removeFromSuperview];
    }
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

#pragma mark - 加载排名数据

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
    if (self.switchView.superview == self.view) {
        [self.switchView removeFromSuperview];
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
