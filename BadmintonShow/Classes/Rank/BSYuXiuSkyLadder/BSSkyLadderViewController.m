//
//  BSSkyLadderViewController.m
//  BadmintonShow
//
//  Created by lzh on 15/9/1.
//  Copyright (c) 2015年 LZH. All rights reserved.
//

#import "BSSkyLadderViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "BSGameModel.h"
#import "CDUser.h"

@interface BSSkyLadderViewController ()
{
    NSMutableArray *_rankArray ;
}
@end

@implementation BSSkyLadderViewController

- (instancetype)init {
    self = [super  init];
    if (self) {
        _rankArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    AVQuery *rankQuery = [AVQuery queryWithClassName:AVClassUser];
    rankQuery.limit = 20 ;
    [rankQuery addDescendingOrder:AVPropertyScore];
    [rankQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        
        for (AVUser *user in objects) {
            CDUser *cdUser = [[CDUser alloc] init];
            cdUser.username = user.username;
            cdUser.score = [user[@"score"] stringValue];
            
            [_rankArray addObject:cdUser];
        }
        
        [self.tableView reloadData];
    }];
}




#pragma mark - TableView数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _rankArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BSGameRecordCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }

    CDUser *user = [_rankArray objectAtIndex:indexPath.row];

    cell.textLabel.text = user.username;
    cell.detailTextLabel.text = user.score;
    
    
    return cell;
    
}




@end

