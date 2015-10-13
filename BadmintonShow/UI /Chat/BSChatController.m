//
//  BSChatController.m
//  BadmintonShow
//
//  Created by lzh on 15/6/14.
//  Copyright (c) 2015年 LZH. All rights reserved.
//

#import "BSChatController.h"
#import <AVOSCloudIM.h>
#import "BSChatListViewController.h"


@interface BSChatController () <AVIMClientDelegate>


@end

@implementation BSChatController


-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self setupUI];
//
}

- (void)setupUI{
    
//    self.title = @"羽秀";
    
    UIButton *rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
    rightItem.frame = CGRectMake(0, 0, 20, 20);
    [rightItem setImage:[UIImage imageNamed:@"user-green-128*128"] forState:UIControlStateNormal];
    [rightItem addTarget:self action:@selector(contacts) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightItem];
}

- (void)contacts{
    
    BSChatListViewController *chatList = [[BSChatListViewController alloc] init];
    [self.navigationController pushViewController:chatList animated:YES];
    
}







@end
