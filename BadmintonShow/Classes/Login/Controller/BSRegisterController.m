//
//  BSRegisterController.m
//  BadmintonShow
//
//  Created by lzh on 15/6/23.
//  Copyright (c) 2015年 LZH. All rights reserved.
//  手机注册界面

#import "BSRegisterController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "RegularExpressionUtils.h"
#import "BSRegisterUserNameController.h"
#import "AppDelegate.h"



@interface BSRegisterController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *phoneBgView;
@property (weak, nonatomic) IBOutlet UIView *verifyCodeBgView;


@end

@implementation BSRegisterController
{
    NSString *_password;
    BOOL      _didSendSmsCode;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"注册";
    
    _phoneNumTF.delegate = self;
    _verifyCodeTF.delegate = self;
    _passwordTF.delegate = self;
    
    
    [self.phoneBgView.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.phoneBgView.layer setBorderWidth:1.0f];
    self.phoneBgView.layer.cornerRadius = 3.0f;
    
    [self.verifyCodeBgView.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.verifyCodeBgView.layer setBorderWidth:1.0f];
    self.verifyCodeBgView.layer.cornerRadius = 3.0f;
    
    UIEdgeInsets inset = UIEdgeInsetsMake(0, 6, 0, 6) ;
    
    UIImage *loginImage = [[UIImage imageNamed:@"common_button_green"] resizableImageWithCapInsets:inset resizingMode:UIImageResizingModeStretch];
    UIImage *loginImageHightlighted = [[UIImage imageNamed:@"common_button_green_highlighted"] resizableImageWithCapInsets:inset resizingMode:UIImageResizingModeStretch];
    [self.verifyCodeBtn setBackgroundImage:loginImage forState:UIControlStateNormal];
    [self.verifyCodeBtn setBackgroundImage:loginImageHightlighted forState:UIControlStateHighlighted];
    
    UIImage *registImage = [[UIImage imageNamed:@"common_button_blue"] resizableImageWithCapInsets:inset resizingMode:UIImageResizingModeStretch];
    [self.nextStepButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.nextStepButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [self.nextStepButton setBackgroundImage:registImage forState:UIControlStateNormal];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - textField代理
-(void)textFieldDidEndEditing:(UITextField *)textField{

    // 手机号码
    
}


#pragma mark - 发送验证码
- (IBAction)sendVerifyCode:(id)sender {
    [self.view endEditing:YES];
    
    NSString *phoneNum =  _phoneNumTF.text ;
    if (![self verifyInputWith:phoneNum]) {
        return;
    };
    
    self.verifyCodeBtn.enabled = NO;
    
    NSString *originBtnTitle = [self.verifyCodeBtn titleForState:UIControlStateNormal];
    __block NSInteger second = 60;
   self.timer =  [NSTimer scheduledTimerWithTimeInterval:1 block:^(NSTimer *timer) {
        NSString *title = [NSString stringWithFormat:@"重新发送 %ld s",--second];
        [self.verifyCodeBtn setTitle:title forState:UIControlStateDisabled];
        if (second == 0) {
            [timer fire];
            self.verifyCodeBtn.enabled = YES;
            [self.verifyCodeBtn setTitle:originBtnTitle forState:UIControlStateNormal];
        }
    } repeats:YES];
    
    
    [self checkIfVerifiedPhone:phoneNum block:^(BOOL succeeded, NSError *error) {
        
         if (!succeeded) {
             [self.timer fire];
             self.verifyCodeBtn.enabled = YES;
             [self.verifyCodeBtn setTitle:originBtnTitle forState:UIControlStateNormal];
             
            return ;
        }
        
        // 没有通过验证的手机才进行验证。
        [self sendSMSTo:phoneNum];
    }];
}


- (BOOL)verifyInputWith:(NSString *)phoneNum{
    if (phoneNum.length != 11) {
        [MBProgressHUD showText:@"手机号码应为11位数字" atView:self.view animated:YES];
        return NO;
    }
    
    BOOL isPhoneNum = [RegularExpressionUtils validateMobile:phoneNum];
    if (!isPhoneNum) {
        [MBProgressHUD showText:@"手机号错误，请填写手机号" atView:self.view animated:YES];
        return NO;
    }
    return YES;
}

- (void)checkIfVerifiedPhone:(NSString *)phoneNum block:(BSBooleanResultBlock)block{
    AVQuery *query = [AVQuery queryWithClassName:AVClassUser];
    [query whereKey:AVPropertyMobilePhoneNumer equalTo:phoneNum];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
       
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"网络请求失败，请检查网络"];
            block(NO, error);
            return ;
        }
        
        if (objects.count) {
            [SVProgressHUD showInfoWithStatus:@"手机号码注册过了"];
            block(NO, nil);
            return;
        }
        
        block(YES, nil);
    }];
}


- (void)sendSMSTo:(NSString *)phoneNum{
    //发送验证码
    [AVOSCloud requestSmsCodeWithPhoneNumber:phoneNum callback:^(BOOL succeeded, NSError *error) {
        //  发送成功
        if ([error.localizedDescription rangeOfString:@"短信发送过于频繁"].length) {
            [MBProgressHUD showText:@"短信发送过于频繁" atView:self.view animated:YES];
        }else if(succeeded){
            [MBProgressHUD showText:@"短信验证码已发送" atView:self.view animated:YES];
            _didSendSmsCode = YES;
        } else {
            [MBProgressHUD showText:@"验证码发送失败" atView:self.view animated:YES];
        }
    }];
}

#pragma mark -  密码是否可见
- (IBAction)visiableAction:(id)sender {
    _passwordTF.secureTextEntry = !_passwordTF.secureTextEntry;
}

#pragma mark -  注册的下一步
- (IBAction)nextStepAction:(id)sender {
    
    
    
    NSString *smsCode = _verifyCodeTF.text;
    NSString *phoneNum = _phoneNumTF.text;
    
    //  1.如果任意条件不符合，则返回
    if (  !_verifyCodeTF.text.length || !_phoneNumTF.text.length ) {
        return;
    }
    
    if (!_verifyCodeTF.text.length) {
        [MBProgressHUD showText:@"请输入验证码" atView:self.view animated:YES];
        return;
    }
    
    BOOL isVerifyCodeNum = [RegularExpressionUtils validateVerifyCode:_verifyCodeTF.text];
    if (!isVerifyCodeNum ) {
        [MBProgressHUD showText:@"验证码必须是数字" atView:self.view animated:YES];
        return;
    }
    
    //
   MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    HUD.labelText = @"验证短信验证码...";
    [HUD show:YES];
//    [self verifyingCodingWithPhone:phoneNum code:smsCode ];
    
    //  2.1使用验证码注册用户。
    [AVUser signUpOrLoginWithMobilePhoneNumberInBackground:phoneNum smsCode:smsCode block:^(AVUser *user, NSError *error) {
        
        [HUD hide:YES];
        if (user) {
            //跳转到下个页面修改用户名和密码
            BSRegisterUserNameController *userNameVC = [[BSRegisterUserNameController alloc] init];
            userNameVC.tempPassword = user.password;
            [self.navigationController pushViewController:userNameVC animated:YES];
            return ;
        }
        [MBProgressHUD showText:error.localizedDescription atView:self.view animated:YES];
    }];
}

- (void)verifyingCodingWithPhone:(NSString *)phoneNum code:(NSString *)code hud:(MBProgressHUD *)hud {
  
}




-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)dealloc {
    [self.timer fire];
    self.timer = nil;
}

@end
