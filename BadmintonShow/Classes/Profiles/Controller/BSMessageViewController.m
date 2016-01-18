//
//  BSMessageViewController.m
//  BadmintonShow
//
//  Created by lizhihua on 16/1/11.
//  Copyright © 2016年 LZH. All rights reserved.
//

#import "BSMessageViewController.h"
#import "BSMessageCell.h"

@interface BSMessageViewController () {
    NSInteger _selectedIndex;
    NSMutableArray *_messageArr;
}
@end

@implementation BSMessageViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        _selectedIndex = -1;
        _messageArr = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
    [self.tableView registerNib:[UINib nibWithNibName:@"BSMessageCell" bundle:nil] forCellReuseIdentifier:@"BSMessageCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _messageArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _selectedIndex) {
        return 100;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BSMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BSMessageCell"];
    
    return cell;
}



@end

