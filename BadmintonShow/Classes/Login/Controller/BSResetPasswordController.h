//
//  BSResetPasswordController.h
//  BadmintonShow
//
//  Created by lizhihua on 16/1/15.
//  Copyright © 2016年 LZH. All rights reserved.
//

#import "BSBaseViewController.h"

@interface BSResetPasswordController : BSBaseViewController

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