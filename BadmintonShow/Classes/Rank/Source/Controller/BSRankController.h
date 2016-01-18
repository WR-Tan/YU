//
//  BSRankController.h
//  BadmintonShow
//
//  Created by lzh on 15/6/14.
//  Copyright (c) 2015年 LZH. All rights reserved.
//

#import "BSBaseViewController.h"

@interface BSRankController : BSBaseViewController
@property (nonatomic, strong) UITableView *tableView ;

- (void)updateUser;

@end
