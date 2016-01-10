//
//  BSChatListViewController.m
//  BadmintonShow
//
//  Created by mac on 15/10/13.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import "BSFriendListViewController.h"
#import "BSAddFriendViewController.h"
#import "CDAddFriendVC.h"
#import "BSProfileUserModel.h"

@interface BSFriendListViewController ()

@end

@implementation BSFriendListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

   
    [self setupUI];
}

- (void)setupUI{
    
     self.title = @"通讯录";
    
    UIButton *rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
    rightItem.frame = CGRectMake(0, 0, 20, 20);
    [rightItem setImage:[UIImage imageNamed:@"contact_IconAdd@2x"] forState:UIControlStateNormal];
    [rightItem addTarget:self action:@selector(addContact) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightItem];
}

- (void)addContact{
    BSAddFriendViewController * add = [ [BSAddFriendViewController alloc] init ];
    [[self navigationController] pushViewController:add animated:YES];
}


@end
