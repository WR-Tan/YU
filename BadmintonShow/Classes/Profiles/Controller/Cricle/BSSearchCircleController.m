//
//  BSSearchCircleController.m
//  BadmintonShow
//
//  Created by lizhihua on 16/1/6.
//  Copyright © 2016年 LZH. All rights reserved.
//

#import "BSSearchCircleController.h"
#import "BSCircleBusiness.h"
#import "BSCircleResultCell.h"
#import "BSCircleDetailController.h"

@interface BSSearchCircleController () <UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UINavigationBar *naviBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightBarItem;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

static NSString *cellId = @"BSCircleResultCell";

@implementation BSSearchCircleController

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = YES;
//}
//
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//}
//

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    self.searchBar.delegate =self;
    [self.tableView registerNib:[UINib nibWithNibName:@"BSCircleResultCell" bundle:nil] forCellReuseIdentifier:cellId];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(back)];
}

- (void)back{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {

    [SVProgressHUD show];
    [BSCircleBusiness queryCircleWIthNameOrId:searchBar.text block:^(NSArray *objects, NSError *error) {
        [SVProgressHUD dismiss];
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"搜索出错，请检查网络"];
            return ;
        }
        
        if (!objects.count) {
            [SVProgressHUD showInfoWithStatus:@"找不到对应的圈子"];
            return ;
        }
        
        [self.view endEditing:YES];
        self.dataArr = objects.mutableCopy;
        [self.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 84;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BSCircleResultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    BSCircleModel *circle = self.dataArr[indexPath.row];
    [cell setObject:circle];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    BSCircleModel *circle = self.dataArr[indexPath.row];
    
    BSCircleDetailController *detailVC = [[BSCircleDetailController alloc] init];
    detailVC.circle = circle;
    detailVC.navigationController.navigationBar.hidden = NO;
    [self.navigationController pushViewController:detailVC animated:YES];
    // 进入圈子主页
}


#pragma mark - Actions

- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


#pragma mark - Lazy

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
