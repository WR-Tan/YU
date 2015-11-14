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
#import "SVProgressHUD.h"

@interface BSAddGameRecordController ()<BSAddGameRecordCellDelegate>

@property (nonatomic , strong) NSDateFormatter * dateFormatter;
@property (nonatomic , weak ) UIButton *btn ;
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

-(void)uploadGame:(BSGameModel *)game button:(UIButton *)btn{
    
    if (!game.playerA_score || !game.playerB_score) {
        [SVProgressHUD showWithStatus:@"请填写比分"];
        return ;
    }
    
    if (!game.playerA_objectId || !game.playerB_objectId) {
        [SVProgressHUD showWithStatus:@"请选择对手"];
        return ;
    }
    
    self.btn = btn ;
    
    [SVProgressHUD showWithStatus:@"正在上传比赛数据"];
    btn.enabled = !btn.enabled ;
    
    AVObject *gameObj = [AVObject objectWithClassName:@"TempGame"];
    
    //  1. 本地基本信息
    gameObj[@"playerA_score"] = game.playerA_score;//  玩家A的每场比赛得分
    gameObj[@"playerB_score"] = game.playerB_score;//  玩家B的每场比赛得分
    gameObj[@"gameType"] = @(game.gameType);  // 比赛的类型
    gameObj[@"playerA_objectId"] = game.playerA_objectId;
    gameObj[@"playerB_objectId"] = game.playerB_objectId;
    gameObj[@"winner_objectId"] = game.winner_objectId;
    gameObj[@"playerA_name"] = game.playerA_name;
    gameObj[@"playerB_name"] = game.playerB_name;
    gameObj[@"startTime"] = game.startTime = self.currentDateString;
    gameObj[@"endTime"]   = game.endTime = self.currentDateString ;
    gameObj[@"winner_objectId"] = game.winner_objectId = game.playerA_objectId;
    
    //  getRankScore backGround
    
    //  2. 获取现在的比分
    NSString *CQLString = @"";
    [AVQuery doCloudQueryInBackgroundWithCQL:CQLString callback:^(AVCloudQueryResult *result, NSError *error) {
        
        //  1. aRankScore
        
        //  2. bRankScore
        
        //  3. 上传比分
        [self saveGame:gameObj ];
    }];
    
}






- (void)saveGame:(AVObject *)gameObj
{
    __weak typeof(self) weakself = self ;
    
    [gameObj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [SVProgressHUD showSuccessWithStatus:@"上传成功"];
            self.btn.enabled = !self.btn.enabled ;
            [weakself turnBack];
        }else{
            [SVProgressHUD showErrorWithStatus:@"上传失败，请检查网络"];
        }
    }];
}



- (void)handleBeforeSave
{
    
    
    // 这个分数应该由后台获取，不应该在这里上传
    /**
     *  1.上传保存之前，在后台Class的PlayerInfo，取出2个人的currentPlatformScore
        2. 发送消息给对手！同时保存gameModel 到 TempGame中去
            2.1 确认分数：
                根据ELO排名算法，得到2个人的重排名后的分数，重新赋值。
                gameModel存储到Game（最终的Class）
            2.2 对手不确认：
                就不做操作。
     *  3.更新排名
     */

    ;
}



- (void)turnBack
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSString *)currentDateString{
    NSString *currentDateStr = [self.dateFormatter stringFromDate:[NSDate date]];
    return currentDateStr;
}

-(NSDateFormatter *)dateFormatter{
    if (!_dateFormatter ) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    return _dateFormatter;
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
