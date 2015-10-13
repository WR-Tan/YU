//
//  BSChatListViewController.m
//  BadmintonShow
//
//  Created by mac on 15/10/13.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import "BSChatListViewController.h"
#import "BSAddContactsViewController.h"

@interface BSChatListViewController ()

@end

@implementation BSChatListViewController

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
    
    BSAddContactsViewController *addContacts = [[BSAddContactsViewController alloc] init];
    [self.navigationController pushViewController:addContacts animated:YES];
    
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
