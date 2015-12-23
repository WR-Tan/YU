//
//  BSBasePlayerRankingController.m
//  BadmintonShow
//
//  Created by lizhihua on 12/22/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSBasePlayerRankingController.h"

#import "BSSkyLadderViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "BSGameModel.h"
#import "CDUser.h"
#import "BSSkyLadderTableViewCell.h"
#import "BSSkyLadderHeaderView.h"
#import "BSRankDataBusiness.h"
#import "SVProgressHUD.h"


@interface BSBasePlayerRankingController ()<UITableViewDelegate,UITableViewDataSource>

@end

static NSString *CellIdentifier = @"BSSkyLadderTableViewCell";

@implementation BSBasePlayerRankingController

- (instancetype)init {
    self = [super  init];
    if (self) {
        _rankArray = [NSMutableArray array];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"天梯";
    [self constructTableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"BSSkyLadderTableViewCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
    
    [self loadRankData];
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


- (void)loadRankData{
    [BSRankDataBusiness queryAllRankUserWithBlock:^(NSArray *objects, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _rankArray = objects.mutableCopy;
            [self.tableView reloadData];
        });
    }];
    
    
    [BSRankDataBusiness queryRankUserDataWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            [self.view addSubview:self.showErrorLabel];
            return ;
        }
        [self.showErrorLabel removeFromSuperview];
        
        _rankArray = objects.mutableCopy;
        [self.tableView reloadData];
    }];
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
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BSSkyLadderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    BSProfileUserModel *user = [_rankArray objectAtIndex:indexPath.row];
    [cell setObject:user indexPath:indexPath];
    return cell;
    
}


#pragma mark - lazy

- (UILabel *)showErrorLabel {
    if (!_showErrorLabel) {
        _showErrorLabel = [[UILabel alloc] init];;
        _showErrorLabel.text = @"网络状况较差，查询失败";
        _showErrorLabel.textAlignment = NSTextAlignmentCenter;
        CGFloat labelWidth = 300 ;
        CGFloat labelHeight = 100;
        _showErrorLabel.bounds = CGRectMake(0, 0, labelWidth, labelHeight);
        _showErrorLabel.center = CGPointMake(self.view.center.x, self.view.center.y - 50);
    }
    return _showErrorLabel;
}


@end

