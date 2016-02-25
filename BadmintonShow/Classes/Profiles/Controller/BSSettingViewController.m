
//
//  BSSettingViewController.m
//  BadmintonShow
//
//  Created by lizhihua on 12/20/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSSettingViewController.h"
#import "BSProfileCell.h"
#import "BSProfileModel.h"
#import "BSProfileBusiness.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"
#import "BSFeedBackViewController.h"
#import "CDChatManager.h"

@interface BSSettingViewController () <UIAlertViewDelegate, BSSetTextViewControllerDelegate> {
    NSMutableArray *_dataArr;
}
@property (nonatomic, strong) UISwitch *mySwitch;
@end

@implementation BSSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    _dataArr = [NSMutableArray array];
    self.title = @"设置";
    
//    BSProfileModel *howToUse = BSProfileModel(nil,@"如何使用",nil,nil);
    BSProfileModel *about = BSProfileModel(nil,@"关于羽秀",nil,@"BSAboutUsViewController");
    BSProfileModel *allowance = BSProfileModel(nil,@"允许羽秀使用我的数据进行排名",nil,nil);
    BSProfileModel *feedBack = BSProfileModel(nil,@"意见反馈",nil,@"BSFeedBackViewController");
//    BSProfileModel *praise = BSProfileModel(nil,@"给个好评",nil,nil);
    [_dataArr addObject:@[about,feedBack,allowance]];
    
    [self.tableView reloadData];
}


#pragma mark - TableView DataSource

#pragma mark Section Footer

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return (section == _dataArr.count - 1 ) ? 60 : 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, kScreenWidth, 44);
    
    UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutBtn.frame = CGRectMake(10, 20, kScreenWidth - 20, 60 - 20);
    [logoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [logoutBtn setBackgroundColor:[UIColor redColor]];
    logoutBtn.layer.cornerRadius = 2.0f;
    [logoutBtn addTarget:self  forControlEvents:UIControlEventTouchUpInside action:^(id sender) {
        
       UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认退出?" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [aler show];
    }];

    [view addSubview:logoutBtn];
    
    return (section == _dataArr.count - 1 ) ? view : nil ;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) [self logout];
}

- (void)logout{
     [BSProfileBusiness logOutWithBlock:^(id object, NSError *err) {
         if (!err) {
             AppDelegate *delegate = [UIApplication sharedApplication].delegate;
             [delegate toLogin];
             [self.navigationController popToRootViewControllerAnimated:YES];
             [[CDChatManager manager]  closeWithCallback:^(BOOL succeeded, NSError *error) {
                 
             }];
         } else {
             [SVProgressHUD showErrorWithStatus:@"退出失败，请重试。(若重试仍无法退出，请关闭程序的后台运行，重新打开并退出)"];
         }
         
     }];
}

#pragma mark Cell

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *sectionData = _dataArr[section];
    return sectionData.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSArray  *sectionData = _dataArr[indexPath.section];
    
    BSProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BSProfileCell"];
    if (!cell) {
        cell = [[BSProfileCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"BSProfileCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.object = sectionData[indexPath.row];
    
    if (indexPath.row <= 1) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.accessoryView = nil;
    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.accessoryView = self.mySwitch;
    }
    
    
    return cell;
}

- (UISwitch *)mySwitch {
    if (!_mySwitch) {
        _mySwitch = [[UISwitch alloc] init];
        [_mySwitch setOn: AppContext.user.isAllowAppUseData];
        [_mySwitch addTarget:self action:@selector(allowUseCustomData:) forControlEvents:UIControlEventValueChanged];
    }
    return _mySwitch;
}

- (void)allowUseCustomData:(UISwitch *)sender{
    
    [BSProfileBusiness saveUserObject:@(sender.isOn) key:AVPropertyAllowAppUseData block:^(id result, NSError *err) {
        if (result) {
            AppContext.user.allowAppUseData = sender.isOn;
            [SVProgressHUD showSuccessWithStatus:@"已经允许羽秀使用我的数据"];
        } else {
            [SVProgressHUD showErrorWithStatus:@"请求失败，请检查网络"];
        }
    }];
}

#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray  *sectionData = _dataArr[indexPath.section];
    BSProfileModel *profile = sectionData[indexPath.row];
    
    // 点击跳转时事件
    Class class = NSClassFromString(profile.className);
    if (class) {
        
        if ([class.className isEqualToString:@"BSFeedBackViewController"] ) {
            BSFeedBackViewController *feedbackVC = class.new;
            feedbackVC.tipText = @"感谢您给我们提供的宝贵意见。交流反馈QQ群：299265891，期待您加入 👫🏸👫🏸👫";
            feedbackVC.title = profile.title;
            feedbackVC.limitCount = 200 ;
            feedbackVC.delegate = self;
            [self.navigationController pushViewController:feedbackVC animated:YES];
            return;
        }
        
        UIViewController *ctrl = class.new ;
        ctrl.view.backgroundColor = [UIColor whiteColor];
        ctrl.title = profile.title;
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    
    
    
}

- (void)resetMessage:(NSString *)message Tag:(int)tag {
    if (message.length < 5) {
        [SVProgressHUD showInfoWithStatus:@"输入的意见不能少于5个字"];
        return;
    }
    
    [BSProfileBusiness uploadFeedback:message block:^(BOOL succeeded, NSError *error) {
        
        if (succeeded) {
            [SVProgressHUD showSuccessWithStatus:@"上传成功"];
        }
    }];
}



@end
