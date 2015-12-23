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

@property (weak, nonatomic) IBOutlet UIView *inputBgView;
@property (weak, nonatomic) IBOutlet UIView *topLineView;
@property (weak, nonatomic) IBOutlet UIView *midLineView;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;


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
 
    self.title = @"羽秀";
    
    self.inputBgView.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.inputBgView.layer.cornerRadius =  2;
    self.inputBgView.clipsToBounds = YES ;
    self.topLineView.hidden = YES;
    self.bottomLineView.hidden = YES;
    
    UIEdgeInsets inset = UIEdgeInsetsMake(0, 6, 0, 6) ;
    
    UIImage *loginImage = [[UIImage imageNamed:@"common_button_green"] resizableImageWithCapInsets:inset resizingMode:UIImageResizingModeStretch];
    UIImage *loginImageHightlighted = [[UIImage imageNamed:@"common_button_green_highlighted"] resizableImageWithCapInsets:inset resizingMode:UIImageResizingModeStretch];
    [self.loginBtn setBackgroundImage:loginImage forState:UIControlStateNormal];
     [self.loginBtn setBackgroundImage:loginImageHightlighted forState:UIControlStateHighlighted];
    
    
    
    
    UIImage *registImage = [[UIImage imageNamed:@"common_button_blue"] resizableImageWithCapInsets:inset resizingMode:UIImageResizingModeStretch];
    [self.registBtn setBackgroundImage:registImage forState:UIControlStateNormal];
    [self.registBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    
    UIImage *notRegistImage = [[UIImage imageNamed:@"poi_btn_positioning_background"] resizableImageWithCapInsets:inset resizingMode:UIImageResizingModeStretch];
    [self.notRegistBtn setBackgroundImage:notRegistImage forState:UIControlStateNormal];
    
    
    [self.findPsdBtn  setBackgroundImage:notRegistImage forState:UIControlStateNormal];
}


- (IBAction)registerActoin:(id)sender {
    BSRegisterController *registerVC = [[BSRegisterController alloc] initWithNibName:@"BSRegisterController" bundle:nil];
    [self.navigationController  pushViewController:registerVC animated:YES ];
}

#pragma mark - 用户登录
- (IBAction)loginAction:(id)sender {
    if (!_phoneNumTF.text.length) {
        [SVProgressHUD showInfoWithStatus:@"请输入用户名或手机号码"];
        return;
    }
    if (!_passwordTF.text.length) {
        [SVProgressHUD showInfoWithStatus:@"请输入密码"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在登陆中"];
    [AVUser logInWithUsernameInBackground:_phoneNumTF.text password:_passwordTF.text block:^(AVUser *user, NSError *error) {
        [SVProgressHUD dismiss];
        if (user) {
            AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
            [delegate toMainCtl];
        } else {
            NSString *errorMsg;
            if (error.code == 211 ) {
               errorMsg =  @"找不到该用户";
            } else if (error.code == 210 ) {
                errorMsg = @"用户名或密码不正确";
            } else {
                errorMsg = @"网络请求失败";
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showText:errorMsg atView:self.view animated:YES];
            });

        }
    }];
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end
