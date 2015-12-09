//
//  BaseTableViewController.h
//  BadmintonShow
//
//  Created by LZH on 15/12/7.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import "BSBaseViewController.h"

@interface BaseTableViewController : BSBaseViewController<

    UITableViewDelegate,UITableViewDataSource

>

@property (nonatomic ,strong) UITableView *tableView;

@end
