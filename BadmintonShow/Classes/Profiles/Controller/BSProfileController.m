//
//  BSMoreController.m
//  BadmintonShow
//
//  Created by lzh on 15/6/14.
//  Copyright (c) 2015年 LZH. All rights reserved.
//

#import "BSProfileController.h"
#import "BSProfileViewController.h"
#import "BSProfileEditViewController.h"
#import "BSProfileUserCell.h"
#import "BSProfileCell.h"
#import "BSProfileUserModel.h"
#import "BSProfileModel.h"

#import "CDUserManager.h"
#import <LCUserFeedbackAgent.h>
#import "UserDefaultManager.h"

#import "AVUser.h"
#import "YYKit.h"

#define  kTableViewBackgroudViewColor RGBCOLOR(240,240,240)

@interface BSProfileController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@end

@implementation BSProfileController{
    NSMutableArray *_dataArr;
    CGRect    _iconOldFrame ;
}

- (instancetype)init {
    self = [super init ];
    if (self) {
        self.title = @"我的";
        self.hidesBottomBarWhenPushed = NO;
        self.tabBarItem.image = [UIImage imageNamed:@"tabbar_chat_active"];
        _dataArr = [NSMutableArray array];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createData];
    [self constructBaseView];
//    [self addCell:@"Model" class:@"YYModelExample"]
}

- (void)constructBaseView{
    //  TableView
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    if ([self respondsToSelector:@selector( setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.backgroundColor = kTableViewBackgroudViewColor;
    [self.view addSubview:self.tableView];
    
    if ( kSystemVersion < 7) {
        self.tableView.top -= 64;
        self.tableView.height += 20;
    }
    
    // NavBar
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(setting)];
}

- (void)setting {
    
}

- (void)createData{
    BSProfileUserModel *user = [BSProfileUserModel new];
    user.avatarUrl = @"http://b.hiphotos.baidu.com/baike/c0%3Dbaike80%2C5%2C5%2C80%2C26/sign=9b369b741e178a82da3177f2976a18e8/902397dda144ad344092e63fd0a20cf431ad855c.jpg";
    user.nickName = @"盖德";
    user.userName = @"Mr.Gade";
    user.level = @"20" ;
    [_dataArr addObject:@[user]];
    
    //
    BSProfileModel *ablum = [BSProfileModel new];
    ablum.imageName = @"AliPay";
    ablum.name = @"相册";
    
    BSProfileModel *collection = [BSProfileModel new];
    collection.imageName = @"AliPay";
    collection.name = @"收藏";
    
    [_dataArr addObject:@[ablum,collection]];
    
    //  附近
    BSProfileModel *peopleNearby = [BSProfileModel new];
    peopleNearby.imageName = @"AliPay";
    peopleNearby.name = @"附近人";
    peopleNearby.detail = @"一起切磋吧";
    
    BSProfileModel *teamNearby = [BSProfileModel new];
    teamNearby.imageName = @"AliPay";
    teamNearby.name = @"附近球队";
    teamNearby.detail = @"享受团队对战的乐趣";
    
    BSProfileModel *groupNearby = [BSProfileModel new];
    groupNearby.imageName = @"AliPay";
    groupNearby.name = @"附近圈子";
    groupNearby.detail = @"到组织里面找朋友";
    
    [_dataArr addObject:@[peopleNearby,teamNearby,groupNearby]];
    
    
    BSProfileModel *about = [BSProfileModel modelWithImageName:@"AliPay" title:@"关于羽秀" detail:nil];
    BSProfileModel *feedBack = [BSProfileModel modelWithImageName:@"AliPay" title:@"意见反馈" detail:nil];
    BSProfileModel *praise = [BSProfileModel modelWithImageName:@"AliPay" title:@"给个好评" detail:nil];
    [_dataArr addObject:@[about,feedBack,praise]];
    
    [self.tableView reloadData];
}

#pragma mark - TableView DataSource

#pragma mark Section Header

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20 ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
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
    if (indexPath.section == 0) return 90;
    return 44;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        BSProfileUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BSProfileUserCell"];
        if (!cell) {
            cell = [[BSProfileUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BSProfileUserCell"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        NSArray  *sectionData = _dataArr[indexPath.section];
        cell.object = sectionData[indexPath.row];
        return cell;
        
    } else {
        
        BSProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BSProfileCell"];
        if (!cell) {
            cell = [[BSProfileCell  alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"BSProfileCell"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        NSArray  *sectionData = _dataArr[indexPath.section];
        cell.object = sectionData[indexPath.row];
        return cell;
    }
    
}


#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 0) {
        BSProfileEditViewController *profileEditVC = [[ BSProfileEditViewController alloc] init];
        [self.navigationController  pushViewController:profileEditVC animated:YES];
    }
}








@end
