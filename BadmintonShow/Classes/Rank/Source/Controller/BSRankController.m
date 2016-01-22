//
//  BSRankController.m
//  BadmintonShow
//
//  Created by lzh on 15/6/14.
//  Copyright (c) 2015年 LZH. All rights reserved.
//

#import "BSRankController.h"
#import "BSRankHeader.h"
#import "BSGameRecordController.h"
#import "BSSkyLadderViewController.h"
#import "BSAddGameRecordController.h"
#import "BSConfirmGameTableViewController.h"

#import <AVOSCloud/AVOSCloud.h>
#import "BSSingleGameRecordController.h"
#import "BSFriendsRankingController.h"
#import "BSCircleRankingController.h"
#import "BSTimeLineViewController.h"
#import "BSProfileUserModel.h"
#import "BSCommonBusiness.h"


@interface BSRankController () <UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *_data;
    NSMutableArray *_classArr;
    BSRankHeader *_header;
    NSArray *_images;
}
@end

@implementation BSRankController


- (instancetype)init {
    self = [super init ];
    if (self) {
        self.title = @"羽秀";
        self.hidesBottomBarWhenPushed = NO;
        self.tabBarItem.image = [UIImage imageNamed:@"tabbar_yuxiu"];
        _data = [@[@[@"比赛记录"],@[@"好友排名",@"圈子排名",@"羽秀天梯"]] mutableCopy];
        _images = @[@[@"iconfont-dayumaoqiu"],@[@"iconfont-pengyou-1",@"iconfont-quanzi",@"iconfont-bisai"]];
        _classArr = @[@[@"BSGameRecordController"],@[@"BSFriendsRankingController",@"BSCircleRankingController",@"BSSkyLadderViewController"]].mutableCopy;
//        @[@"广场"]
//        ,@[@"BSTimeLineViewController"]
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self constructTableView];
    [self updateUser];
    [self addObserver];
#if 0
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addGameRecord)];
#endif
}



- (void)constructTableView{
    //  TableView
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    if ([self respondsToSelector:@selector( setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.backgroundColor = kTableViewBackgroudColor;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self updateUser];
    }];
    [self.view addSubview:self.tableView];
    
    if (kScreenHeight <= 568) {
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 140, 0);
    }
}


- (void)updateUser {
    [BSCommonBusiness fetchUserInBackground:^(BSProfileUserModel *profileUserMoel, NSError *err) {
        [self.tableView.mj_header endRefreshing];
        if (err) {
            [SVProgressHUD showErrorWithStatus:@"请求数据错误，请检测网络"];
            return ;
        }
        [self.tableView reloadData];
    }];
}

- (void)addObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUser) name:kNotificationKeyUserUpdated object:nil];
}


#pragma mark TableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *sectionData = _data[section];
    return sectionData.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _data.count;
}

#pragma mark - Header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (!_header)  {
        _header = [[BSRankHeader alloc] init];
    }
    _header.frame = CGRectMake(0, 0, kScreenWidth, 215);
    [_header.icon setImageWithURL:[NSURL URLWithString:AppContext.user.avatarUrl] placeholder:UIImageNamed(kBSAvatarPlaceHolder)];
    _header.name.text = AppContext.user.userName ? :@"未登录";
    _header.ranking.text =  [NSString stringWithFormat:@"%ld",(long)AppContext.user.score];
    _header.backgroundColor = [UIColor whiteColor];
    _header.introduce.text = AppContext.user.desc.length ? AppContext.user.desc : @"还没有签名？ 快去添加吧";
    
    UIView *bottomLineView = [UIView new];
    bottomLineView.frame = CGRectMake(0, 215 - 0.5, kScreenWidth, 0.5);
    bottomLineView.backgroundColor = [UIColor colorWithHexString:@"#CCCCCC"];
    [_header addSubview:bottomLineView];
    
    return section ? nil : _header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return section ? 20 : 235;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}


#pragma mark
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RankCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSArray *sectionData = _data[indexPath.section];
    NSString *title = sectionData[indexPath.row];

    NSArray *imageArr = _images[indexPath.section];
    cell.imageView.image = [UIImage imageNamed:imageArr[indexPath.row]];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.imageView.clipsToBounds = YES;
    
    cell.textLabel.text = title;
    cell.textLabel.font = kBSFontSize(15);
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSArray *sectionData = _classArr[indexPath.section];
    NSString  *className = sectionData[indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *ctrl = class.new ;
        ctrl.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



 @end
