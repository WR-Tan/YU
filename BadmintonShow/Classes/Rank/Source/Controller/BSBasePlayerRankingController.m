//
//  BSBasePlayerRankingController.m
//  BadmintonShow
//
//  Created by lizhihua on 12/22/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSBasePlayerRankingController.h"

#import "BSSkyLadderViewController.h"
#import "BSPlayerDetailViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "BSGameModel.h"
#import "CDUser.h"
#import "BSSkyLadderTableViewCell.h"
#import "BSSkyLadderHeaderView.h"
#import "BSRankDataBusiness.h"
#import "SVProgressHUD.h"


@interface BSBasePlayerRankingController ()

@end

static NSString *CellIdentifier = @"BSSkyLadderTableViewCell";

@implementation BSBasePlayerRankingController

- (instancetype)init {
    self = [super  init];
    if (self) {
        _rankArray = [NSMutableArray array];
        _querySkip = 0;
        _querySuccessCount = 0;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"天梯";
    [self constructTableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"BSSkyLadderTableViewCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
    // 增加下拉刷新
    [self loadRankData];
}

- (void)loadRankData{
    
}

- (void)constructTableView{
    //  IOS7以上适配
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

    //  TableView
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    if ([self respondsToSelector:@selector( setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.backgroundColor = kTableViewBackgroudColor;
    [self.view addSubview:self.tableView];
    
    
    __weak UITableView *tableView = self.tableView;
    // 下拉刷新
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadRankData];

    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    tableView.mj_header.automaticallyChangeAlpha = YES;
    
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];

}

- (void)loadMoreData{
    
}


#pragma mark - TableView数据源

#pragma mark TableViewHeader
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (!_rankArray.count)  return nil;
    
    if (!_header)  {
        _header = [[BSSkyLadderHeaderView alloc] init];
    }
    _header.frame = CGRectMake(0, 0, kScreenWidth, 75);
    return section ? nil : _header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return section ? 0 : 75;
}
#pragma mark TableViewCell
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _rankArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BSSkyLadderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    BSProfileUserModel *user = [_rankArray objectAtIndex:indexPath.row];
    [cell setObject:user indexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BSProfileUserModel *user = [_rankArray objectAtIndex:indexPath.row];
    
    BSPlayerDetailViewController *vc = [[BSPlayerDetailViewController alloc] init];
    vc.player = user;
    vc.title = user.userName;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - lazy

- (UILabel *)showErrorLabel {
    if (!_showErrorLabel) {
        _showErrorLabel = [[UILabel alloc] init];;
        _showErrorLabel.text = @"获取排名失败，请检查网络";
        _showErrorLabel.textAlignment = NSTextAlignmentCenter;
        CGFloat labelWidth = 300 ;
        CGFloat labelHeight = 100;
        _showErrorLabel.bounds = CGRectMake(0, 0, labelWidth, labelHeight);
        _showErrorLabel.center = CGPointMake(self.view.center.x, self.view.center.y - 50);
    }
    return _showErrorLabel;
}


@end

