//
//  BSLoginController.m
//  BadmintonShow
//
//  Created by lzh on 15/6/23.
//  Copyright (c) 2015年 LZH. All rights reserved.
//

#import "BSLoginController.h"
#import "BSRegisterController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "AppDelegate.h"
#import "BSAVBusiness+Register.h"
#import "SVProgressHUD.h"

@interface BSLoginController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@property (copy, nonatomic) NSString *phoneNumber ;
@property (copy, nonatomic) NSString *password;

@end

@implementation BSLoginController

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (IBAction)registerActoin:(id)sender {
    
    BSRegisterController *registerVC = [[BSRegisterController alloc] init];
    [self.navigationController  pushViewController:registerVC animated:YES ];
}

#pragma mark - 用户登录
- (IBAction)loginAction:(id)sender {
    
    [AVUser logInWithUsernameInBackground:_phoneNumTF.text password:_passwordTF.text block:^(AVUser *user, NSError *error) {
        
        if (user) {
            AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
            [delegate toMainCtl];
            
            [self createPlayerInfoIfNeeded];
            
        } else {
            
        }
    }];
}
- (void)createPlayerInfoIfNeeded
{
    [BSAVBusiness checkPlayerInfoExistence:^(bool isExisted) {
        if (isExisted) {
            return ;
        }
        
        [BSAVBusiness createPlayerInfo:^(bool success) {
            if (success) return ;
            
            [SVProgressHUD showErrorWithStatus:@"创建玩家信息类失败"];
        }];
        
    }];
}

- (IBAction)securityAction:(id)sender {
    
    _passwordTF.secureTextEntry = !_passwordTF.secureTextEntry ;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (IBAction)skipRegisterOrLoginAction:(id)sender {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate toMain];
}


@end
