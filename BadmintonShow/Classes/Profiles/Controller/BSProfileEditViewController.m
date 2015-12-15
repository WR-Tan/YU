//
//  BSProfileEditViewController.m
//  BadmintonShow
//
//  Created by lizhihua on 12/15/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSProfileEditViewController.h"

@interface BSProfileEditViewController ()
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation BSProfileEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
}


#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *sectionData = self.dataArr[section];
    return sectionData.count;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


@end
