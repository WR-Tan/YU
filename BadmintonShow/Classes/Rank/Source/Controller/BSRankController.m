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


@interface BSRankController () <UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *_data;
    NSMutableArray *_classArr;
    BSRankHeader *_header;
}
@end

@implementation BSRankController


- (instancetype)init {
    self = [super init ];
    if (self) {
        self.title = @"羽秀";
        self.hidesBottomBarWhenPushed = NO;
        self.tabBarItem.image = [UIImage imageNamed:@"tabbar_chat_active"];
        _data = [@[@[@"比赛记录"],@[@"好友排名",@"圈子排名",@"羽秀天梯"],@[@"广场"]] mutableCopy];
        _classArr = @[@[@"BSGameRecordController"],@[@"BSFriendsRankingController",@"BSCircleRankingController",@"BSSkyLadderViewController"],@[@"BSTimeLineViewController"]].mutableCopy;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self constructTableView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addGameRecord)];
}
- (void)constructTableView{
    //  TableView
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    if ([self respondsToSelector:@selector( setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.backgroundColor = kTableViewBackgroudColor;
    [self.view addSubview:self.tableView];
    
    if ( kSystemVersion < 7) {
        self.tableView.top -= 64;
        self.tableView.height += 20;
    }
}

- (void)addGameRecord{
    BSAddGameRecordController *add = [[BSAddGameRecordController alloc] init];
    [self.navigationController pushViewController:add animated:YES];
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
    _header.frame = CGRectMake(0, 0, kScreenWidth, 205);
    [_header.icon setImageWithURL:[NSURL URLWithString:AppContext.user.avatarUrl] placeholder:UIImageNamed(kBSAvatarPlaceHolder)];
    _header.name.text = AppContext.user.nickName ? :@"未设置";
    _header.ranking.text = @"未知";
    _header.backgroundColor = [UIColor whiteColor];
    _header.introduce.text = AppContext.user.desc;
    
    return section ? nil : _header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return section ? 20 : 225;
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
    
    // 1.取出这行对应的字典数据
    NSArray *sectionData = _data[indexPath.section];
    NSString *title = sectionData[indexPath.row];
    
    // 2.设置文字
    cell.textLabel.text = title;
    
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





 @end
