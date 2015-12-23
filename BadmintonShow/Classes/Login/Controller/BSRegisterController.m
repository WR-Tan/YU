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

@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *verifyCodeBtn;

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
}

#pragma mark - textField代理
-(void)textFieldDidEndEditing:(UITextField *)textField{

    // 手机号码
    
}


#pragma mark - 发送验证码
- (IBAction)sendVerifyCode:(id)sender {
    
    
    NSString *phoneNum =  _phoneNumTF.text ;
    if (phoneNum.length != 11) {
        [MBProgressHUD showText:@"手机号码应为11位数字" atView:self.view animated:YES];
        return;
    }
    
    BOOL isPhoneNum = [RegularExpressionUtils validateMobile:phoneNum];
    if (!isPhoneNum) {
        [MBProgressHUD showText:@"手机号错误，请填写手机号" atView:self.view animated:YES];
        return;
    }
    
    
    self.verifyCodeBtn.enabled = NO;
    
    NSString *originBtnTitle = [self.verifyCodeBtn titleForState:UIControlStateNormal];
    __block NSInteger second = 60;
    [NSTimer scheduledTimerWithTimeInterval:1 block:^(NSTimer *timer) {
        NSString *title = [NSString stringWithFormat:@"重新发送 %ld s",--second];
        [self.verifyCodeBtn setTitle:title forState:UIControlStateDisabled];
        if (second == 0) {
            [timer fire];
            self.verifyCodeBtn.enabled = YES;
            [self.verifyCodeBtn setTitle:originBtnTitle forState:UIControlStateNormal];
        }
    } repeats:YES];
    
    return;
    
    //发送验证码
    [AVOSCloud requestSmsCodeWithPhoneNumber:phoneNum callback:^(BOOL succeeded, NSError *error) {
        
        NSString *text ;
        if ([error.localizedDescription rangeOfString:@"短信发送过于频繁"].length) {
            text = @"短信发送过于频繁";
        }else if(succeeded){
            text = @"短信验证码已发送";
        }
        
        [MBProgressHUD showText:text atView:self.view animated:YES];
        _didSendSmsCode = YES;
        
        
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
    
    BOOL isVerifyCodeNum = [RegularExpressionUtils validateMobile:_verifyCodeTF.text];
    if (!isVerifyCodeNum ) {
        [MBProgressHUD showText:@"验证码必须是数字" atView:self.view animated:YES];
        return;
    }
    
    
    //  2.1使用验证码注册用户。
    [AVUser signUpOrLoginWithMobilePhoneNumberInBackground:phoneNum smsCode:smsCode block:^(AVUser *user, NSError *error) {

        NSLog(@"当前、缓存中的用户名：%@\n密码  %@ \n手机号 %@ \n用户本身:%@",user.username ,user.password,user.mobilePhoneNumber,user);
        
        //跳转到下个页面修改用户名和密码
        BSRegisterUserNameController *userNameVC = [[BSRegisterUserNameController alloc] init];
        userNameVC.tempPassword = user.password;
        [self.navigationController pushViewController:userNameVC animated:YES];
        return;

    }];
}






-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    [self.view endEditing:YES];
}


@end
