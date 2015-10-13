//
//  BSRegisterUserNameController.m
//  BadmintonShow
//
//  Created by lzh on 15/6/29.
//  Copyright (c) 2015年 LZH. All rights reserved.
//  修改用户名，完善信息——暂时略过这步

#import "BSRegisterUserNameController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "AppDelegate.h"

@interface BSRegisterUserNameController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@end

@implementation BSRegisterUserNameController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

#pragma mark - UITextField代理方法
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    //  判断用户名重复问题
    NSString  *userName = self.userNameTF.text;
    if(textField == self.userNameTF && userName.length){
        AVQuery *query = [AVUser query];
        [query whereKey:@"username" equalTo:userName];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            
            if (error == nil) {
                // 如果找到该用户，提示用户名已经存在
                 [MBProgressHUD showText:@"用户名已经存在" atView:self.view  animated:YES];
            } else {
               
            }
        }];
    
    
    }
}

#pragma mark -  密码是否可见
- (IBAction)visiableAction:(id)sender {
    _passwordTF.secureTextEntry = !_passwordTF.secureTextEntry;
}


#pragma mark - 完成注册
- (IBAction)completeAction:(id)sender {
    
    //  1.判断用户名密码是否为空
    if (!self.userNameTF.text.length) {
        [MBProgressHUD showText:@"请输入用户名" atView:self.view animated:YES];
        return;
    }
    
    if (!self.passwordTF.text.length) {
        [MBProgressHUD showText:@"请输入密码" atView:self.view animated:YES];
        return;
    }
    
    
    
    //  2.2重置密码
    //  获取缓存中的用户
    AVUser *cuser = [AVUser currentUser];
    
    //  2.3修改用户名（电话号码——>自定义用户名）
    [cuser setUsername:self.userNameTF.text];
    [cuser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        
        [cuser updatePassword:self.tempPassword newPassword:_passwordTF.text block:^(id object, NSError *error) {
            if ([self filterError:error]) {
                NSLog(@"重置密码成功，新的密码为 %@", _passwordTF.text);
                
                //  2.3切换到主界面
                AppDelegate *app = [[UIApplication sharedApplication] delegate] ;
                [app toMain];
            }
        }];
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
