//
//  BSGameRecoreController.m
//  BadmintonShow
//
//  Created by lzh on 15/6/14.
//  Copyright (c) 2015年 LZH. All rights reserved.
//

#import "BSGameRecordController.h"
#import "BSGameRecordCell.h"
#import "BSGameRecordDetailController.h"
#import "BSAddGameRecordController.h"

@interface BSGameRecordController ()
{
    NSMutableArray *_gameRecordData;
}
@end

@implementation BSGameRecordController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        _gameRecordData = [NSMutableArray array];
        self.title = @"比赛记录";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerNib:[UINib nibWithNibName:@"BSGameRecordCell" bundle:nil] forCellReuseIdentifier:@"BSGameRecordCell"];
    
    [self initNavigationItem];
}

#pragma mark - 初始化导航按钮
- (void)initNavigationItem
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加新比赛" style:UIBarButtonItemStyleDone target:self  action:@selector(addGameRecord)];

}

- (void)addGameRecord
{
    BSAddGameRecordController *add = [[BSAddGameRecordController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:add animated:YES];
}

#pragma mark - TableView数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BSGameRecordCell";
    BSGameRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[BSGameRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.playerAIcon.image = [UIImage imageNamed:@"林丹.jpg"];
    cell.playerBIcon.image = [UIImage imageNamed:@"李宗伟.jpg"];
    
    return cell;
    
}

#pragma mark - TableView代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    BSGameRecordDetailController *detail = [[BSGameRecordDetailController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:detail animated:YES];
}



@end
