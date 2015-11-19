//
//  BSProfileViewController.m
//  BadmintonShow
//
//  Created by mac on 15/10/16.
//  Copyright © 2015年 LZH. All rights reserved.
//  我-设置-界面

#import "BSProfileViewController.h"
#import "CDChatManager.h"
#import "AppDelegate.h"
#import "CDUserManager.h"

#import <LeanCloudFeedback/LeanCloudFeedback.h>

@interface BSProfileViewController ()

@end

@implementation BSProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadDataSource {
    [self showProgress];
    [[CDUserManager manager] getBigAvatarImageOfUser:[AVUser currentUser] block:^(UIImage *image) {
        [[LCUserFeedbackAgent sharedInstance] countUnreadFeedbackThreadsWithBlock:^(NSInteger number, NSError *error) {
            [self hideProgress];
            self.dataSource = [NSMutableArray array];

            [self.dataSource addObject:@[@{ kMutipleSectionTitleKey:@"消息通知", kMutipleSectionSelectorKey:NSStringFromSelector(@selector(goPushSetting)) }, @{ kMutipleSectionTitleKey:@"意见反馈", kMutipleSectionBadgeKey:@(number), kMutipleSectionSelectorKey:NSStringFromSelector(@selector(goFeedback)) }, @{ kMutipleSectionTitleKey:@"用户协议", kMutipleSectionSelectorKey:NSStringFromSelector(@selector(goTerms)) }, @{kMutipleSectionTitleKey:@"分享应用", kMutipleSectionSelectorKey:SELECTOR_TO_STRING(shareApp:)}]];
            [self.dataSource addObject:@[@{ kMutipleSectionTitleKey:@"退出登录", kMutipleSectionLogoutKey:@YES, kMutipleSectionSelectorKey:NSStringFromSelector(@selector(logout)) }]];
            [self.tableView reloadData];
        }];
    }];
}


/**
 *  重写logout方法，看情况是否还需要退出AVOSCloud
 */
- (void)logout {
    [[CDChatManager manager] closeWithCallback: ^(BOOL succeeded, NSError *error) {
        DLog(@"%@", error);
        [self deleteAuthDataCache];
        [AVUser logOut];
        //        CDAppDelegate *delegate = (CDAppDelegate *)[UIApplication sharedApplication].delegate;
        //        [delegate toLogin];
        
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        [delegate toLogin];
        
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
