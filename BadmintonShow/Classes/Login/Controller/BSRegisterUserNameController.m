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
#import "SVProgressHUD.h"

@interface BSRegisterUserNameController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *nickNameTF;

@end

@implementation BSRegisterUserNameController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"完善信息";
}

#pragma mark - UITextField代理方法
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
#if 0
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
#endif
    
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
    if (!self.nickNameTF.text.length) {
        [MBProgressHUD showText:@"请输入昵称" atView:self.view animated:YES];
        return;
    }
    if (!self.passwordTF.text.length) {
        [MBProgressHUD showText:@"请输入密码" atView:self.view animated:YES];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在加载中"];
    //  查询username有没有被占用
    [self checkUsername:self.userNameTF.text block:^(BOOL isUsernameUsed, NSError *error) {
       
        
        //  网络请求错误
        if (error) {
             [SVProgressHUD  dismiss];
            [MBProgressHUD showText:@"网络错误" atView:self.view animated:YES];
            return;
        }
        
        //  用户名被占用
        if (isUsernameUsed) {
             [SVProgressHUD  dismiss];
            [MBProgressHUD showText:@"用户名已经被占用，请选择其他用户名" atView:self.view animated:YES];
            return;
        }
        
        //  用户名可用
        [self saveUserInBackgroundWithName:self.userNameTF.text nickname:self.nickNameTF.text];
    }];
}


- (void)checkUsername:(NSString *)username block:(void(^)(BOOL isUsernameUsed, NSError *error))block{
    AVQuery *query = [AVQuery queryWithClassName:AVClassUser];
    [query whereKey:@"username" equalTo:username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (error) {
            block(NO, error);
        } else if (objects.count == 1) {
            block(YES,nil);
        } else if (objects.count == 0) {
            block(NO,nil);
        }
    }];
}


- (void)saveUserInBackgroundWithName:(NSString *)username nickname:(NSString *)nickname {
    //  2.2重置密码
    //  获取缓存中的用户
    AVUser *cuser = [AVUser currentUser];
    
    //  2.3修改用户名（电话号码——>自定义用户名）
    [cuser setUsername:username];
    [cuser setObject:nickname forKey:AVPropertyNickName];
    [cuser saveInBackgroundWithBlock:^(BOOL succeed, NSError *error) {
        
         [SVProgressHUD  dismiss];
        if (!succeed || error) {
            [SVProgressHUD showErrorWithStatus:@"注册失败.."];
            return ;
        }
        [cuser updatePassword:self.tempPassword newPassword:_passwordTF.text block:^(id object, NSError *error) {
            if ([self filterError:error]) {
                NSLog(@"重置密码成功，新的密码为 %@", _passwordTF.text);
                //  2.3切换到主界面
                AppContext.user = [BSProfileUserModel modelFromAVUser:cuser];
                
                AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate] ;
                [appDelegate toMain];
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
