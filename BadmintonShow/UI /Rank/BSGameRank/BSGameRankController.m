//
//  BSGameRankController.m
//  BadmintonShow
//
//  Created by lzh on 15/6/21.
//  Copyright (c) 2015年 LZH. All rights reserved.
//

#import "BSGameRankController.h"

@interface BSGameRankController ()
{
    NSMutableArray *_gameRankData;
    
}
@end

@implementation BSGameRankController

- (void)viewDidLoad {
    [super viewDidLoad];

     self.title = @"好友排名";
    [self initData];
}


- (void)initData{
    _gameRankData = [NSMutableArray array];
    _gameRankData = [ @[@"林丹",@"李宗伟",@"陶菲克",@"陈依聪",@"李伟洲",
                        @"李智华",@"陈晓燕",@"谌龙",@"田厚威",@"陈少勄"] mutableCopy];
}

#pragma mark TableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
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
    cell.imageView.image = [UIImage imageNamed:@"f_static_083"];
    // 1.取出这行对应的字典数据
    NSString *title = _gameRankData[indexPath.row];
    // 2.设置文字
    cell.textLabel.text = title;
    
    return cell;
}

@end
