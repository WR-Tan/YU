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

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;
@property (weak, nonatomic) IBOutlet UIButton *notRegistBtn;
@property (weak, nonatomic) IBOutlet UIButton *findPsdBtn;

@end

@implementation BSLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    UIEdgeInsets inset = UIEdgeInsetsMake(0, 6, 0, 6) ;
    
    UIImage *loginImage = [[UIImage imageNamed:@"common_button_green"] resizableImageWithCapInsets:inset resizingMode:UIImageResizingModeStretch];
    UIImage *loginImageHightlighted = [[UIImage imageNamed:@"common_button_green_highlighted"] resizableImageWithCapInsets:inset resizingMode:UIImageResizingModeStretch];
    [self.loginBtn setBackgroundImage:loginImage forState:UIControlStateNormal];
     [self.loginBtn setBackgroundImage:loginImageHightlighted forState:UIControlStateHighlighted];
    
    
    
    
    UIImage *registImage = [[UIImage imageNamed:@"common_button_blue"] resizableImageWithCapInsets:inset resizingMode:UIImageResizingModeStretch];
    [self.registBtn setBackgroundImage:registImage forState:UIControlStateNormal];
    
    
    
    UIImage *notRegistImage = [[UIImage imageNamed:@"poi_btn_positioning_background"] resizableImageWithCapInsets:inset resizingMode:UIImageResizingModeStretch];
    [self.notRegistBtn setBackgroundImage:notRegistImage forState:UIControlStateNormal];
    
    
    [self.findPsdBtn  setBackgroundImage:notRegistImage forState:UIControlStateNormal];
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




-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (IBAction)skipRegisterOrLoginAction:(id)sender {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate toMain];
}


@end
