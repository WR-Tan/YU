//
//  BSLoginWithPhoneNumberController.m
//  BadmintonShow
//
//  Created by lizhihua on 16/1/14.
//  Copyright © 2016年 LZH. All rights reserved.
//

#import "BSLoginWithPhoneNumberController.h"
#import "RegularExpressionUtils.h"
#import "AVQuery.h"
#import "AVOSCloud.h"

@interface BSLoginWithPhoneNumberController ()

@end

@implementation BSLoginWithPhoneNumberController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    [self.nextStepButton setTitle:@"登录" forState:UIControlStateNormal];
    
    [self.nextStepButton addTarget:self  forControlEvents:UIControlEventTouchUpInside action:^(id sender) {
        
        if (![self verifyInputWith:self.phoneNumTF.text]) {
            return ;
        }
        
        if (![self verifySMSCode]) {
            return;
        }
        
        [AVUser logInWithMobilePhoneNumberInBackground:self.phoneNumTF.text smsCode:self.verifyCodeTF.text block:^(AVUser *user, NSError *error) {
            
            if (user) {
                
            }
        }];
    }];
}



#pragma mark - 发送验证码
- (IBAction)sendVerifyCode:(id)sender {
    [self.view endEditing:YES];
    
    NSString *phoneNum =  self.phoneNumTF.text ;
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
        [self.timer fire];
        self.verifyCodeBtn.enabled = YES;
        [self.verifyCodeBtn setTitle:originBtnTitle forState:UIControlStateNormal];
        
        if (!succeeded) return ;
        
        [self loginWithPhoneNumber:self.phoneNumTF.text];
    }];
}

- (BOOL)verifySMSCode {
    //  1.如果任意条件不符合，则返回
    if (  !self.verifyCodeTF.text.length ) {
        [MBProgressHUD showText:@"请输入验证码" atView:self.view animated:YES];
        return NO;
    }
    
    if (self.verifyCodeTF.text.length != 6) {
        [MBProgressHUD showText:@"验证码位数错误" atView:self.view animated:YES];
        return NO;
    }
    return YES;
}

- (void)loginWithPhoneNumber:(NSString *)phoneNumber{
    [AVUser requestLoginSmsCode:phoneNumber withBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"发送验证码错误，请稍后重试"];
            return ;
        }
        
        NSString *smsCode = self.verifyCodeTF.text ? : @" ";
        if (succeeded) {
            [SVProgressHUD showErrorWithStatus:@"验证码已发送，请输入验证码"];
           
        }
    }];
}


- (void)checkIfVerifiedPhone:(NSString *)phoneNum block:(BSBooleanResultBlock)block{
    AVQuery *query = [AVQuery queryWithClassName:AVClassUser];
    [query whereKey:AVPropertyMobilePhoneNumer equalTo:phoneNum];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (error) {  // 网络出错，手机号码注册状态未知
            [SVProgressHUD showErrorWithStatus:@"网络请求失败，请检查网络"];
            block(NO, error);
            return ;
        }
        
        if (objects.count) { // 注册过了，可以登陆
            block(YES, nil);
            return;
        }
        
        block(NO, nil); // 未注册，不可以登陆
        [SVProgressHUD showErrorWithStatus:@"手机号尚未注册，请先注册"];
    }];
}

@end
