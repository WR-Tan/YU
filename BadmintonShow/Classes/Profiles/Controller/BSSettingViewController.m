
//
//  BSSettingViewController.m
//  BadmintonShow
//
//  Created by lizhihua on 12/20/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSSettingViewController.h"
#import "BSProfileCell.h"
#import "BSProfileModel.h"

@interface BSSettingViewController () {
    NSMutableArray *_dataArr;
}
@end

@implementation BSSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    BSProfileModel *model;
}


#pragma mark - TableView DataSource

#pragma mark Section Header

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0 ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return (section == _dataArr.count - 1 ) ? 44 : 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return !(section == _dataArr.count - 1 ) ? nil :
    (
        [UIView new]
    )
    ;
}

#pragma mark Cell

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *sectionData = _dataArr[section];
    return sectionData.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) return 90;
    return 44;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    BSProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BSProfileCell"];
    if (!cell) {
        cell = [[BSProfileCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"BSProfileCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSArray  *sectionData = _dataArr[indexPath.section];
    cell.object = sectionData[indexPath.row];
    return cell;
}


#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    
}



@end
