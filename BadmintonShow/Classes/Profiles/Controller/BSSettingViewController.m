
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

@interface BSSettingViewController () {
    NSMutableArray *_dataArr;
}
@end

@implementation BSSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArr = [NSMutableArray array];
    BSProfileModel *model = BSProfileModel(nil, @"占坑", nil, nil);
    [_dataArr addObject:@[model]];
    [self.tableView reloadData];
}


#pragma mark - TableView DataSource

#pragma mark Section Footer

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return (section == _dataArr.count - 1 ) ? 44 : 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [logoutBtn addTarget:self  forControlEvents:UIControlEventTouchUpInside action:^(id sender) {
        [self logout];
    }];
    [logoutBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    logoutBtn.frame = CGRectMake(0, 0, kScreenWidth, 44);
    
    return (section == _dataArr.count - 1 ) ? logoutBtn : nil ;
}

- (void)logout{
     [BSProfileBusiness logOutWithBlock:^(id object, NSError *err) {
         if (!err) {
             AppDelegate *delegate = [UIApplication sharedApplication].delegate;
             [delegate toLogin];
         } else {
             [SVProgressHUD showErrorWithStatus:@"退出失败，请重试"];
         }
         
     }];
}

#pragma mark Cell

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return _dataArr.count;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *sectionData = _dataArr[section];
    return sectionData.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    BSProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BSProfileCell"];
    if (!cell) {
        cell = [[BSProfileCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"BSProfileCell"];
    }
    NSArray  *sectionData = _dataArr[indexPath.section];
    cell.object = sectionData[indexPath.row];
    return cell;
}


#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    
}



@end
