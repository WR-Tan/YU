//
//  BSAddGameRecordController.m
//  BadmintonShow
//
//  Created by lzh on 15/6/14.
//  Copyright (c) 2015年 LZH. All rights reserved.
//

#import "BSAddGameRecordController.h"
#import "BSAddGameRecordCell.h"
#import <AVOSCloud/AVOSCloud.h>
#import "CDFriendListVC.h"
#import "BSChoosePlayerViewController.h"

@interface BSAddGameRecordController ()<BSAddGameRecordCellDelegate>

@end

@implementation BSAddGameRecordController

- (void)viewDidLoad {
    [super viewDidLoad];

       [self.tableView registerNib:[UINib nibWithNibName:@"BSAddGameRecordCell" bundle:nil] forCellReuseIdentifier:@"BSAddGameRecordCell"];
}

#pragma mark - ScrollView Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark - TableView数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

 
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return 360;
    return 250 ; //  暂时先只上传一场比赛的比分，3场比赛的暂时不做。
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BSAddGameRecordCell";
    BSAddGameRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[BSAddGameRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.delegate = self;
    
    return cell;
}



#pragma mark - Delegate

-(void)presentFriendListVC{
    BSChoosePlayerViewController *choosePlayVC = [[BSChoosePlayerViewController alloc] init];
    choosePlayVC.title = @"选择对友/对手";
    [self presentViewController:choosePlayVC animated:YES  completion:nil];
}

-(void)uploadGame:(BSGameModel *)game{
    
    AVObject *gameObject = [AVObject objectWithClassName:@"Game"];
    
    gameObject[@"playerA_score"] = game.playerA_score;//  玩家A的得分
    gameObject[@"playerB_score"] = game.playerB_score;//  玩家B的得分
    gameObject[@"gameType"] = @(game.gameType);  // 比赛的类型
    gameObject[@"playerA_objectId"] = game.playerA_objectId;
    gameObject[@"playerB_objectId"] = game.playerB_objectId;
    
    gameObject[@"winner_objectId"] = game.winner_objectId;
    
    gameObject[@"playerA_name"] = game.playerA_name;
    gameObject[@"playerB_name"] = game.playerB_name;
    
    gameObject[@"startTime"] = game.startTime = @"2015.10.26";
    gameObject[@"endTime"] = game.endTime = @"2015.10.26";
    
    gameObject[@"playerA_platformScore"] = game.playerA_platformScore = @"2400";
    gameObject[@"playerB_platformScore"] = game.playerB_platformScore = @"2343";
    
    gameObject[@"winner_objectId"] = game.winner_objectId = game.playerA_objectId;
    
    
    [gameObject save];
}


- (void)saveScore
{
     ;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
