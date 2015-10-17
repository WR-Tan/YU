//
//  BSProfileViewController.m
//  BadmintonShow
//
//  Created by mac on 15/10/16.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import "BSProfileViewController.h"
#import "CDChatManager.h"
#import "AppDelegate.h"

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
        // delegate toLogin
        
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
