//
//  BSMyCirclesController.m
//  BadmintonShow
//
//  Created by lizhihua on 16/1/6.
//  Copyright © 2016年 LZH. All rights reserved.
//

#import "BSMyCirclesController.h"
#import "BSCommonTool.h"
#import "BSMyCircleHeader.h"
#import "BSMyCircleCell.h"
#import "BSCircleBusiness.h"
#import "BSCircleMenuView.h"
#import "BSJionCircleViewController.h"
#import "BSCreateCircleController.h"
#import "BSCircleDetailController.h"
#import "BSSearchCircleController.h"
#import "BSMyCircleHeaderView.h"
#import "MJRefresh.h"

@interface BSMyCirclesController () < BSMyCircleHeaderDelegate, UIAlertViewDelegate>
@property (nonatomic, strong) UIView *sectionHeader;
@property (nonatomic, strong) NSMutableArray *circlesArr;
@property (nonatomic, strong) BSCircleMenuView *menuView;
@property (nonatomic, strong) BSCircleModel *toDeleteCircle;
@end

static NSString * cellId = @"BSMyCircleCell";

@implementation BSMyCirclesController


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self constructBaseView];
    [self queryJionedCircles];
    [self addObserver];
}

- (void)constructBaseView{
    self.title = @"圈子";
    
    BSMyCircleHeader *header = [BSMyCircleHeader new];
    header.delegate = self;
    self.tableView.tableHeaderView = header;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BSMyCircleCell" bundle:nil] forCellReuseIdentifier:cellId];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchCircle)];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self queryJionedCircles];
    }];
}

- (void)searchCircle{
    BSSearchCircleController *searchVC = [[BSSearchCircleController alloc] init];
    searchVC.title = @"搜索圈子";
    [self.navigationController pushViewController:searchVC animated:YES];
}

/// 获取用户加入了什么圈子.
- (void)queryJionedCircles{
    [BSCircleBusiness queryMyCirclesWithBlock:^(NSArray *objects, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"获取分类出错"];
            return ;
        }
        if (!objects.count)  return;
        
        [self handleCircles:objects];
    }];
}

- (void)handleCircles:(NSArray *)circles{

    [self.circlesArr removeAllObjects];
    
    NSMutableArray *myCircles = [NSMutableArray array];
    NSMutableArray *jionedCircles = [NSMutableArray array];
    
    for (BSCircleModel *circle in circles) {
        if ([circle.creator.objectId isEqualToString:AppContext.user.objectId]) {
            [myCircles addObject:circle];
        }else {
            [jionedCircles addObject:circle];
        }
    }
    
    if (myCircles.count) {
        [self.circlesArr addObject:myCircles];
    }
    if (jionedCircles.count) {
        [self.circlesArr addObject:jionedCircles];
    }
    
    [self.tableView reloadData];
}


- (void)addObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshCircles) name:@"jionedNewCircle" object:nil];
}

- (void)refreshCircles{
    [self queryJionedCircles];
}

#pragma mark - Table View DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.circlesArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *sectionArray = self.circlesArr[section];
    return sectionArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    BSMyCircleHeaderView *header = [BSMyCircleHeaderView sectionHeader];
    header.title = section == 0 ? @"我创建的" : @"我加入的";
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [BSMyCircleHeaderView height];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BSMyCircleCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    NSMutableArray *sectionArray = self.circlesArr[indexPath.section];
    NSObject *circle = [sectionArray objectAtIndex:indexPath.row];
    [cell setObject:circle];
    return cell;
}


#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSMutableArray *sectionArray = self.circlesArr[indexPath.section];
    BSCircleModel *circle = [sectionArray objectAtIndex:indexPath.row];
    
    BSCircleDetailController *detailVC = [[BSCircleDetailController alloc] init];
    detailVC.circle = circle;
    [detailVC setBlock:^(void){
        [self queryJionedCircles];
    }];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section ;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"退出";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle != UITableViewCellEditingStyleDelete) return;
    if (indexPath.section == 0) return;
    
    NSMutableArray *sectionArray = self.circlesArr[indexPath.section];
    BSCircleModel *circle = sectionArray[indexPath.row];
    self.toDeleteCircle = circle;
    
    NSString *message = [NSString stringWithFormat:@"你确定要退出\"%@\"吗？",circle.name];
    
    [UIAlertView showWithTitle:@"退出圈子" message:message cancelButtonTitle:@"取消"
             otherButtonTitles:@[@"确定"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                  if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"确定"]) {
                     [self quitCircle:self.toDeleteCircle];
                     [sectionArray removeObjectAtIndex:indexPath.row];
                     [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                 }
             }];
}


#pragma mark - 加入圈子

- (void)circleHeader:(BSMyCircleHeader *)header didClickJionCircleAction:(UIButton *)jionButton {
    
    BSJionCircleViewController *jiosnVC = [[BSJionCircleViewController alloc] init];
    [self.navigationController pushViewController:jiosnVC animated:YES];
}

- (void)circleHeader:(BSMyCircleHeader *)header didClickCreateCricleAction:(UIButton *)createButton {
    BSCreateCircleController *createCircelVC = [[BSCreateCircleController alloc] init];
    [self.navigationController pushViewController:createCircelVC animated:YES];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.menuView.superview == self.view) {
        [self.menuView removeFromSuperview];
    }
}



- (void)quitCircle:(BSCircleModel *)circle{
    
    [BSCircleBusiness quitCircle:circle block:^(BOOL succeeded, NSError *error) {
        if (!error) return ;
        [SVProgressHUD showErrorWithStatus:@"退出失败，请检查网络"];
    }];
}


#pragma mark - lazy
- (UIView *)sectionHeader {
    if(!_sectionHeader) {
        _sectionHeader = [UIView new];
        _sectionHeader.frame = CGRectMake(0, 0, kScreenWidth, 30);
        _sectionHeader.backgroundColor = kTableViewBackgroudColor;
        
        
        UILabel *myCircle = [UILabel new];
        myCircle.frame = CGRectMake(15, 8, 65, 20);
        myCircle.font = kBSFontSize(13);
        myCircle.text = @"我的圈子";
        [_sectionHeader addSubview:myCircle];
        
        CGFloat labelWidth = 85;
        UILabel *myRankingInCircle = [UILabel new];
        myRankingInCircle.frame = CGRectMake(kScreenWidth - labelWidth - 15, 8, labelWidth, 20);
        myRankingInCircle.text = @"我的圈内排名";
        myRankingInCircle.textAlignment = NSTextAlignmentRight;
        myRankingInCircle.font = kBSFontSize(13);
        [_sectionHeader addSubview:myRankingInCircle];
        
        UIView *bottomLine = [UIView new];
        bottomLine.backgroundColor = [UIColor lightGrayColor];
        bottomLine.frame = CGRectMake(0, 30-0.5, kScreenWidth, 0.5);
        [_sectionHeader addSubview:bottomLine];
    }
    return _sectionHeader;
}

- (NSMutableArray *)circlesArr {
    if (!_circlesArr) {
        _circlesArr = [NSMutableArray array];
    }
    return _circlesArr;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end



