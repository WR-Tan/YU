//
//  BSPlayerDetailViewController.m
//  BadmintonShow
//
//  Created by lizhihua on 12/28/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSPlayerDetailViewController.h"
#import "BSPlayerDetailHeader.h"
#import "CDUserManager.h"
#import "CDIMService.h"
#import "LZPushManager.h"

@interface BSPlayerDetailViewController ()
@property (nonatomic, strong) BSPlayerDetailHeader *header;
@property (nonatomic, strong) UIButton *addOrChatButton;
@end

NSString *hasRequestedStr = @"已经请求过了";

@implementation BSPlayerDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self constructBaseView];
    [self queryFriendShip];
}

- (void)constructBaseView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    
    CGFloat buttonHeight = 50;
    CGFloat buttonWidth = kScreenWidth - 30;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15, self.view.height - buttonHeight - 64, buttonWidth, 40 - 5);
    [button setBackgroundColor:[UIColor blueColor] ];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"添加好友" forState:UIControlStateNormal];
    [button addTarget:self  action:@selector(makeFriend) forControlEvents:UIControlEventTouchUpInside];
    button.hidden = YES;
    [self.view addSubview:button];
    self.addOrChatButton = button;
}

//  加为好友 --  发送添加好友申请
- (void)makeFriend{
    
    
    
}


- (void)queryFriendShip {
//    [SVProgressHUD show];
    AVUser *user = [AVUser user];
    user.objectId = self.player.objectId;
    
    [[CDUserManager manager] isMyFriend : user block : ^(BOOL isFriend, NSError *error) {
        [SVProgressHUD dismiss];
        
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"获取关系失败"];
            return ;
        }
        
        NSString *title;
        NSString *selector;
        if (isFriend) {
            title = @"开始聊天";
            selector = NSStringFromSelector(@selector(goChat));

        } else {
            title = @"添加好友";
            selector = NSStringFromSelector(@selector(tryCreateAddRequest));
        }
        [self modifyButtonWithTitle:title selector:selector];
    }];
}

- (void)modifyButtonWithTitle:(NSString *)title selector:(NSString *)selector{
    self.addOrChatButton.hidden =  [title isEqualToString:@"开始聊天"] ? YES : NO;
    
    [self.addOrChatButton setTitle:title forState:UIControlStateNormal];
    [self.addOrChatButton removeAllTargets];
    [self.addOrChatButton addTarget:self action:NSSelectorFromString(selector) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - actions

- (void)goChat {
    [[CDIMService service] goWithUserId:self.player.objectId fromVC:self];
}


- (BOOL)filterError:(NSError *)error {
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"跳转聊天界面错误，请检查网络"];
        return YES;
    }
    return NO;
}

/**
 *  @author lizhihua, 15-12-23 20:12:37
 *  @brief 添加好友
 */
- (void)tryCreateAddRequest {
    [SVProgressHUD show];
    AVUser *user = [AVUser user];
    user.objectId = self.player.objectId;
    //  创建"AddRequest添加好友"请求
    [[CDUserManager manager] tryCreateAddRequestWithToUser:user callback: ^(BOOL succeeded, NSError *error) {


       dispatch_async(dispatch_get_main_queue(), ^{
//           [SVProgressHUD dismiss];
           
           if (error) {
               NSString *errorMsg = [error.userInfo[@"NSLocalizedDescription"]  isEqualToString:hasRequestedStr] ?
               hasRequestedStr : @"发送请求失败，请检查网络" ;
               
               [SVProgressHUD showErrorWithStatus:errorMsg];
               return ;
           }
           
           NSString *text = [NSString stringWithFormat:@"%@ 申请加你为好友", self.player.userName];
           // 推送一个"申请加你为好友"的推送给User
           [[LZPushManager manager] pushMessage:text userIds:@[self.player.objectId] block:^(BOOL succeeded, NSError *error) {
               
               if (error) {
                   [SVProgressHUD showErrorWithStatus:@"发送请求错误，请检查网络"];
                   return ;
               }
               [SVProgressHUD showInfoWithStatus:@"申请成功"];
           }];

       });
        
        
    }];
}




- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 500;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (!_header) {
        _header  = [BSPlayerDetailHeader new];
    }
    [_header setObject:self.player];
    
    return _header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0.1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellId ];
    if (!cell) {
        cell = [[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
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
