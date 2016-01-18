//
//  BSJionCircleViewController.m
//  BadmintonShow
//
//  Created by lizhihua on 12/24/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSJionCircleViewController.h"
#import "BSCircleBusiness.h"
#import "BSJionCircleCategoryCell.h"
#import "BSCircleResultCell.h"
#import "BSCircleDetailController.h"
#import "SVProgressHUD.h"
#import "MJRefresh.h"

@interface BSJionCircleViewController () <UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *_circleTypes;
    NSMutableDictionary *_circleDict;
    NSUInteger _selectType;
    
    NSInteger _querySkip ;
    NSInteger _querySuccessCount;
    NSMutableDictionary *_circleRequestSuccessDict;
}
@property (weak, nonatomic) IBOutlet UITableView *circleTypeTableView;
@property (weak, nonatomic) IBOutlet UITableView *circleResultTableView;

@end

static NSString *circleCategoryCellId = @"BSJionCircleCategoryCell";
static NSString *circleResultCellId = @"BSCircleResultCell";

@implementation BSJionCircleViewController

- (instancetype)init{
    self = [super init];
    if (self) {
       self = [self initWithNibName:@"BSJionCircleViewController" bundle:nil];
        _circleTypes  = @[@"所有",@"公司",@"学校",@"城市",@"区域",@"小区",@"球会",@"其他"].mutableCopy;
        _circleRequestSuccessDict = [NSMutableDictionary dictionary];
        for (NSString *key in _circleTypes) {
            [_circleRequestSuccessDict setObject:@0 forKey:key];
        }
        
        _selectType = 0;
        _circleDict = [NSMutableDictionary dictionary];
        for (NSString *key in _circleTypes) {
            NSMutableArray *resultArray = [NSMutableArray array];
            [_circleDict setObject:resultArray forKey:key];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self constructBaseView];
    [self loadDataFromNet];
}

- (void)constructBaseView{
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.circleTypeTableView.tableFooterView = [UIView new];
    self.circleResultTableView.tableFooterView = [UIView new];
    [self.circleTypeTableView registerNib:[UINib nibWithNibName:@"BSJionCircleCategoryCell" bundle:nil] forCellReuseIdentifier:circleCategoryCellId];
    [self.circleResultTableView registerNib:[UINib nibWithNibName:@"BSCircleResultCell" bundle:nil] forCellReuseIdentifier:circleResultCellId];
    self.circleResultTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadDataFromNet];
    }];
    self.circleResultTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];

}



- (void)loadDataFromNet{
    NSString *category = _circleTypes[_selectType];  // @"小区";
    self.title = category;
    
    // 第一次加载。下拉刷新
    _querySuccessCount = 0;
    _querySkip = 0;
    
    [BSCircleBusiness queryCircleWithCategory:category isOpen:YES limit:kQueryLimit skip:_querySkip  block:^(NSArray *objects, NSError *error) {
        [self.circleResultTableView.mj_header endRefreshing];
        if (error) {
            [SVProgressHUD  showErrorWithStatus:@"请求数据错误.."];
            return ;
        }
        
        _querySuccessCount = 1;
        _querySkip = kQueryLimit;
         
        [_circleRequestSuccessDict setObject:@(_querySuccessCount) forKey:_circleTypes[_selectType]];
        
        self.circleResultTableView.mj_footer.hidden = !objects.count;
        
        if (objects) {
            [_circleDict setObject:objects.mutableCopy forKey:category];
            [self.circleResultTableView reloadData];
        }
    }];
}

- (void)loadMoreData{
    NSString *category = _circleTypes[_selectType];  // @"小区";

    [BSCircleBusiness queryCircleWithCategory:category isOpen:YES limit:kQueryLimit skip:_querySkip  block:^(NSArray *objects, NSError *error) {
        [self.circleResultTableView.mj_footer endRefreshing];
        if (error) {
            [SVProgressHUD  showErrorWithStatus:@"请求数据错误.."];
            return ;
        }
        
        if (!objects) return;

        _querySuccessCount ++ ;
        _querySkip = kQueryLimit * _querySuccessCount;
        
        NSMutableArray *circleArr = _circleDict[category];
        if (circleArr) {
            [circleArr addObjectsFromArray:objects];
        }
        
        [self.circleResultTableView reloadData];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.circleTypeTableView) {
        return _circleTypes.count;
    }

    NSMutableArray *resultArr = _circleDict[_circleTypes[_selectType]];
    return resultArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableView == self.circleTypeTableView ? 44 : 84;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
       return tableView == self.circleTypeTableView ? @"分类" : nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return tableView == self.circleTypeTableView ? 35 : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.circleTypeTableView) {
        BSJionCircleCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:circleCategoryCellId];
        cell.titleLabel.text = _circleTypes[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        return cell;
    } else {

        BSCircleResultCell *cell = [tableView dequeueReusableCellWithIdentifier:circleResultCellId];
        
        NSMutableArray *resultArr = _circleDict[_circleTypes[_selectType]];
        if (indexPath.row < resultArr.count) {
            BSCircleModel *circle = resultArr[indexPath.row];
            [cell setObject:circle];
        }

        return cell;
    }
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.circleResultTableView) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        NSMutableArray *resultArr = _circleDict[_circleTypes[_selectType]];
        
        if (indexPath.row >= resultArr.count) return;
        
        BSCircleModel *circle = resultArr[indexPath.row];
        
        BSCircleDetailController *detailVC = [[BSCircleDetailController alloc] init];
        detailVC.circle = circle;
        [self.navigationController pushViewController:detailVC animated:YES];
        // 进入圈子主页
        return;
    }
 
    //  点击了圈子类型，查询圈子
    _selectType = indexPath.row;
    
    NSInteger circleSuccessCount = [_circleRequestSuccessDict[_circleTypes[_selectType]] integerValue];
    
    [self.circleResultTableView reloadData];
    if (circleSuccessCount == 0) {
        [self loadDataFromNet];
    }
}





@end
