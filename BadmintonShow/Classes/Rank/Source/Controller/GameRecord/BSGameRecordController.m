//
//  BSGameRecoreController.m
//  BadmintonShow
//
//  Created by lzh on 15/6/14.
//  Copyright (c) 2015年 LZH. All rights reserved.
//

#import "BSGameRecordController.h"
#import "BSGameRecordCell.h"
//#import "BSGameRecordDetailController.h"
#import "BSAddGameRecordController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "BSGameModel.h"
#import "BSGameRecordHeaderView.h"
#import "BSDBManager.h"
#import "BSGameBusiness.h"
#import "BSSingleGameRecordController.h"
#import "BSDoubleGameRecordController.h"

@interface BSGameRecordController () <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>{
    NSMutableArray *_gameRecordData;
}
@property (nonatomic, strong) BSGameRecordHeaderView *header;
@property (nonatomic, strong) AVUser *oppUser;
@property (nonatomic, strong) AVUser *myUser;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISegmentedControl *seg;
@end

@implementation BSGameRecordController

- (instancetype)init{
    self = [super init ];
    if (self) {
        _gameRecordData = [NSMutableArray array];
       
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"比赛统计";
#if 0
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"单打",@"双打"]];
    seg.selectedSegmentIndex = 0 ;
    seg.bounds = CGRectMake(0, 0, 160, 30);
    seg.center = CGPointMake(50, 15);
    self.navigationItem.titleView = seg;
    self.seg = seg;

 
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scroll.contentSize = CGSizeMake(self.view.bounds.size.width * 2, self.view.bounds.size.height);
    scroll.backgroundColor = kTableViewBackgroudColor;
    scroll.delegate = self;
    scroll.pagingEnabled = YES;
    [self.view addSubview:scroll];
#endif
    
//    scroll.top -= 64;
    
    BSSingleGameRecordController *singleVC = [[BSSingleGameRecordController alloc] init];
    [self addChildViewController:singleVC];
    [self.view addSubview:singleVC.view];
    
#if 0
    singleVC.view.frame = scroll.bounds;
    [scroll addSubview:singleVC.view];
    

    BSDoubleGameRecordController *doubleVC = [[BSDoubleGameRecordController alloc] init];
    [self addChildViewController:doubleVC];
    doubleVC.view.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, scroll.height);
    [scroll addSubview:doubleVC.view];
#endif
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    BSGameRecordDetailController *detail = [[BSGameRecordDetailController alloc] init ];
//    [self.navigationController pushViewController:detail animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
#if 0
    if (scrollView.contentOffset.x == kScreenWidth) {
        self.seg.selectedSegmentIndex = 1;
    } else if(scrollView.contentOffset.x == 0) {
        self.seg.selectedSegmentIndex = 0;
    }
#endif
    
}

@end
