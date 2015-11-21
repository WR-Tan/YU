//
//  BSRankController.m
//  BadmintonShow
//
//  Created by lzh on 15/6/14.
//  Copyright (c) 2015年 LZH. All rights reserved.
//

#import "BSRankController.h"
#import "BSRankHeader.h"
#import "BSGameRecordController.h"
#import "BSGameRankController.h"
#import "BSSkyLadderViewController.h"
#import "BSAddGameRecordController.h"

#import <AVOSCloud/AVOSCloud.h>


@interface BSRankController ()
{
    NSMutableArray *_data;
    BSRankHeader *_header;
}
@end

@implementation BSRankController


-(instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"排名";
        self.hidesBottomBarWhenPushed = NO;
        
        _data = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self loadData];
    
    
    [self initNavigationItem];
}

#pragma mark - 初始化导航按钮
- (void)initNavigationItem
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加新比赛" style:UIBarButtonItemStyleDone target:self  action:@selector(addGameRecord)];
}

- (void)addGameRecord{
    BSAddGameRecordController *add = [[BSAddGameRecordController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:add animated:YES];

}


- (void)loadData
{
    _data = [@[@"比赛记录"/*,@"圈子排名"*/,@"羽秀天梯"] mutableCopy];

}

#pragma mark TableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

#pragma mark - Header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    _header = [[BSRankHeader alloc] init];
    _header.frame = CGRectMake(0, 0, kScreenWidth, 200);
    
    return section ? nil : _header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return section ? 0 : 220;
}

#pragma mark
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RankCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    // 1.取出这行对应的字典数据
    NSString *title = _data[indexPath.section];
    
    // 2.设置文字
    cell.textLabel.text = title;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        BSGameRecordController *gameRecord = [[BSGameRecordController  alloc] initWithStyle:UITableViewStylePlain];
        [self.navigationController pushViewController:gameRecord animated:YES];
    }else if(indexPath.section == 1) {
        BSSkyLadderViewController *tech = [[BSSkyLadderViewController alloc ]initWithStyle:UITableViewStylePlain];
        [self.navigationController pushViewController:tech animated:YES];
        
//        BSGameRankController *rank = [[BSGameRankController alloc ]init ];
//        [self.navigationController pushViewController:rank animated:YES];
    }else{
        BSSkyLadderViewController *tech = [[BSSkyLadderViewController alloc ]initWithStyle:UITableViewStylePlain];
        [self.navigationController pushViewController:tech animated:YES];
    
    }
}








































@end
