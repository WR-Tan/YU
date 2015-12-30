//
//  BSPlayerDetailViewController.h
//  BadmintonShow
//
//  Created by lizhihua on 12/28/15.
//  Copyright © 2015 LZH. All rights reserved.
//  用户展示墙---用户名称，用户ID，比赛场数，胜率，性别，简介，公司/学校（公司优先级高）

#import "BSBaseTableViewController.h"
#import "BSProfileUserModel.h"

@interface BSPlayerDetailViewController : BSBaseTableViewController
@property (nonatomic, strong) BSProfileUserModel *player;
@end
