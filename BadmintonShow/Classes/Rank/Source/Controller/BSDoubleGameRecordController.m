//
//  BSDoubleGameRecordController.m
//  BadmintonShow
//
//  Created by lizhihua on 12/22/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSDoubleGameRecordController.h"
#import "BSGameRecordCell.h"
#import "BSGameRecordDetailController.h"
#import "BSAddGameRecordController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "BSGameModel.h"
#import "BSGameRecordHeaderView.h"
#import "BSDBManager.h"
#import "BSGameBusiness.h"

@interface BSDoubleGameRecordController () <UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *_gameRecordData;
}
@property (nonatomic, strong) BSGameRecordHeaderView *header;
@property (nonatomic, strong) AVUser *oppUser;
@property (nonatomic, strong) AVUser *myUser;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation BSDoubleGameRecordController

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
    //    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.backgroundColor = kTableViewBackgroudColor;
    [self.view addSubview:self.tableView];
    
    if ( kSystemVersion < 7) {
        self.tableView.top -= 64;
        self.tableView.height += 20;
    }
}

- (void)initData{
    
#if 0
    [BSGameBusiness queryGameFromDBWithBlock:^(NSArray *objects, NSError *error) {
        _gameRecordData = objects.mutableCopy;
        [self.tableView reloadData];
    }];
#endif
    
    //    用户上下拉刷新的时候，再去获取数据
    [BSGameBusiness queryGameFromNetWithBlock:^(NSArray *objects, NSError *error) {
        _gameRecordData = objects.mutableCopy;
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
    return 70;
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
    
    BSGameRecordDetailController *detail = [[BSGameRecordDetailController alloc] init ];
    [self.navigationController pushViewController:detail animated:YES];
}

@end


