//
//  BSChatController.m
//  BadmintonShow
//
//  Created by lzh on 15/6/14.
//  Copyright (c) 2015年 LZH. All rights reserved.
//  聊天列表界面

#import "BSChatController.h"
#import <AVOSCloudIM.h>
#import "BSFriendListViewController.h"
#import "BSCommonTool.h"
#import "BSContactMainController.h"



@interface BSChatController () <AVIMClientDelegate>


@end

@implementation BSChatController


-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI{
    
    UIButton *rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
    rightItem.frame = CGRectMake(0, 0, 20, 20);
    [rightItem setImage:[UIImage imageNamed:@"user-green-128*128"] forState:UIControlStateNormal];
    [rightItem addTarget:self action:@selector(contacts) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightItem];
    self.navigationItem.leftBarButtonItem = [BSCommonTool createRightBarButtonItem:@"通讯录" target:self selector:@selector(gotoContactController) ImageName:nil];
}

- (void)gotoContactController{
    BSContactMainController *vc = [[BSContactMainController alloc] init];
    BSProfileUserModel *user1 =  [[BSProfileUserModel alloc] init];
    user1.nickName = @"SB";
    user1.userName = @"tanworong";
    user1.avatarUrl = @"http://c.hiphotos.baidu.com/image/pic/item/5bafa40f4bfbfbed91fbb0837ef0f736aec31faf.jpg";
    
    BSProfileUserModel *user2 =  [[BSProfileUserModel alloc] init];
    user2.nickName = @"天才";
    user2.userName = @"swelzh";
    user2.avatarUrl = @"http://pic.818today.com/imgsy/image/201511/17_101628yg.jpg";
    
    vc.products = @[user1,user2];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)contacts{
    
    BSFriendListViewController *chatList = [[BSFriendListViewController alloc] init];
    [self.navigationController pushViewController:chatList animated:YES];
    
}







@end
