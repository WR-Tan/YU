
//
//  BSSingleGameRecordController.m
//  BadmintonShow
//
//  Created by lizhihua on 12/22/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSSingleGameRecordController.h"
#import "BSGameRecordCell.h"
#import "BSGameRecordDetailController.h"
#import "BSAddGameRecordController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "BSGameModel.h"
#import "BSGameRecordHeaderView.h"
#import "BSDBManager.h"
#import "BSGameBusiness.h"
#import "SVProgressHUD.h"
#import "MJRefresh.h"

@interface BSSingleGameRecordController () <UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *_gameRecordData;
    NSInteger _querySkip;
    NSInteger _querySuccessCount;
}
@property (nonatomic, strong) BSGameRecordHeaderView *header;
@property (nonatomic, strong) AVUser *oppUser;
@property (nonatomic, strong) AVUser *myUser;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation BSSingleGameRecordController

- (instancetype)init{
    self = [super init ];
    if (self) {
        _gameRecordData = [NSMutableArray array];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self constructTableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"BSGameRecordCell" bundle:nil] forCellReuseIdentifier:@"BSGameRecordCell"];
    [self initData];
}


- (void)constructTableView{ 
    //  TableView
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    if ([self respondsToSelector:@selector( setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
//    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, -64, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.backgroundColor = kTableViewBackgroudColor;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self initData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
}

- (void)initData{
    _querySuccessCount = 0;
    _querySkip = 0;
    [SVProgressHUD show];
    [BSGameBusiness queryGameFromNetWithLimit:kQueryLimit skip:_querySkip Block:^(NSArray *objects, NSError *error) {
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"获取比赛记录失败，请检查网络"];
            return ;
        }
        
        _querySuccessCount = 1;
        _querySkip = kQueryLimit;
        
        _gameRecordData = objects.mutableCopy;
        [self.tableView reloadData];
    }];
}



- (void)loadMoreData {
    // 第一次加载。下拉刷新
    [BSGameBusiness queryGameFromNetWithLimit:kQueryLimit skip:_querySkip Block:^(NSArray *objects, NSError *error) {
        [SVProgressHUD dismiss];
        [self.tableView.mj_footer endRefreshing];
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"获取比赛记录失败，请检查网络"];
            return ;
        }
        
        _querySuccessCount ++ ;
        _querySkip = kQueryLimit * _querySuccessCount;
        
        [_gameRecordData addObjectsFromArray:objects];
        [self.tableView reloadData];
        
    }];
    
    
    
}



#pragma mark - 初始化导航按钮
- (void)initNavigationItem{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加新比赛" style:UIBarButtonItemStyleDone target:self  action:@selector(addGameRecord)];
}

- (void)addGameRecord{
    BSAddGameRecordController *add = [[BSAddGameRecordController alloc] init ];
    [self.navigationController pushViewController:add animated:YES];
}

#pragma mark - TableView数据源

#pragma mark TableViewHeader
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (!_gameRecordData.count)  return nil;
    
    if (!_header)  _header = [[BSGameRecordHeaderView alloc] init];
    _header.frame = CGRectMake(0, 0, kScreenWidth, 30);
    return section ? nil : _header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section ? 0 : 30;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _gameRecordData.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"BSGameRecordCell";
    BSGameRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[BSGameRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    BSGameModel *model = [_gameRecordData objectAtIndex:indexPath.row];
    [cell setObject:model indexPath:indexPath];
    return cell;
}

#pragma mark - TableView代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    BSGameRecordDetailController *detail = [[BSGameRecordDetailController alloc] init ];
//    [self.navigationController pushViewController:detail animated:YES];
}



#pragma mark - lazy



@end
