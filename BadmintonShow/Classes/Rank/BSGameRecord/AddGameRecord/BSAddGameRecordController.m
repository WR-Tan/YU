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

@interface BSAddGameRecordController ()<BSAddGameRecordCellDelegate,BSChoosePlayerViewControllerDelegate>

@property (nonatomic, strong) BSGameModel *gameModel ;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, weak ) UIButton *btn ;
@end

@implementation BSAddGameRecordController

- (void)viewDidLoad {
    [super viewDidLoad];

       [self.tableView registerNib:[UINib nibWithNibName:@"BSAddGameRecordCell" bundle:nil] forCellReuseIdentifier:@"BSAddGameRecordCell"];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [SVProgressHUD dismiss];
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
    choosePlayVC.delegate = self;
    [self.navigationController pushViewController:choosePlayVC animated:YES];
}

-(void)uploadGame:(BSGameModel *)game button:(UIButton *)btn{
    
    
    self.gameModel.playerA_objectId = [AVUser currentUser].objectId;
    self.gameModel.playerB_objectId = @"561496cb00b0866436724e9f";
    self.gameModel.playerA_name = [AVUser currentUser].username;
    self.gameModel.playerB_name = @"user001";
    
    if (![self valiateGame:game]) {
        return;
    };
    
    [SVProgressHUD showWithStatus:@"正在上传比赛数据"];
    
    self.btn = btn ;
    btn.enabled = !btn.enabled ;
    
    self.gameModel = game ;
    
    AVObject *gameObj = [self AVObjectWithGameModel:game];
    
    [self saveGameToTemp:gameObj ];
}

- (AVObject *)AVObjectWithGameModel:(BSGameModel *)game
{
    AVObject *gameObj = [AVObject objectWithClassName:@"TempGame"];
    
    gameObj[@"playerA_score"]       = game.playerA_score;//  玩家A的每场比赛得分
    gameObj[@"playerB_score"]       = game.playerB_score;//  玩家B的每场比赛得分
    gameObj[@"gameType"]            = @(game.gameType);  // 比赛的类型
    gameObj[@"playerA_objectId"]    = game.playerA_objectId;
    gameObj[@"playerB_objectId"]    = game.playerB_objectId;
    gameObj[@"winner_objectId"]     = game.winner_objectId;
    gameObj[@"playerA_name"]        = game.playerA_name;
    gameObj[@"playerB_name"]        = game.playerB_name;
    gameObj[@"startTime"]           = game.startTime = self.currentDateString;
    gameObj[@"endTime"]             = game.endTime = self.currentDateString ;
    gameObj[@"winner_objectId"]     = game.winner_objectId = game.playerA_objectId;
    
    return gameObj;
}

- (BOOL)valiateGame:(BSGameModel *)game
{
    if (!game.playerA_score || !game.playerB_score) {
        [SVProgressHUD showWithStatus:@"请填写比分"];
        return  NO ;
    }
    
    if (!game.playerA_objectId || !game.playerB_objectId) {
        [SVProgressHUD showWithStatus:@"请选择对手"];
        return NO;
    }
    
    return YES;
}



- (void)saveGameToTemp:(AVObject *)gameObj
{
    [gameObj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            //
            [self saveTempGameToPlayerInfo:gameObj];
        }else{
            [SVProgressHUD showErrorWithStatus:@"上传失败，请检查网络"];
        }
    }];
}

//  成功后添加到用户 PlayerInfo的TeamGames数组中
- (void)saveTempGameToPlayerInfo:(AVObject *)gameObj
{
    //  1.通过查询获取playerInfo对象
    AVQuery *query = [AVQuery queryWithClassName:@"PlayerInfo"];
    [query whereKey:@"userObjectId" equalTo:[AVUser currentUser].objectId];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            //  1.取出数组
            AVObject *playerInfo = [objects firstObject];
            
            //  2.数组添加game
            [playerInfo addObject:gameObj forKey:@"tempGames"];
            
            //  3.更新数组
            [playerInfo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    [SVProgressHUD showSuccessWithStatus:@"上传成功"];
                
                    if (self.delegate && [self.delegate respondsToSelector:@selector(saveGameObject:)]) {
                        [self.delegate  saveGameObject:gameObj ];
                    }

                    self.btn.enabled = !self.btn.enabled ;
                    [self turnBack];
                }
            }];

        } else {
            // 输出错误信息
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
     
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


#pragma mark BSChoosePlayerViewControllerDelegate
- (void)didSelectPlayer:(AVUser *)user{

    
}

@end
