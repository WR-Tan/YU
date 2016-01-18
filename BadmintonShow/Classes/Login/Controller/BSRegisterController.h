//
//  BSRegisterController.h
//  BadmintonShow
//
//  Created by lzh on 15/6/23.
//  Copyright (c) 2015年 LZH. All rights reserved.
//  手机注册界面

#import "BSBaseViewController.h"

@interface BSRegisterController : BSBaseViewController

@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@property (weak, nonatomic) IBOutlet UIButton *nextStepButton;
@property (weak, nonatomic) IBOutlet UIButton *verifyCodeBtn;

@property (strong, nonatomic) NSTimer *timer;

- (BOOL)verifyInputWith:(NSString *)phoneNum;

- (void)checkIfVerifiedPhone:(NSString *)phoneNum block:(BSBooleanResultBlock)block;

- (IBAction)nextStepAction:(id)sender ;

@end
