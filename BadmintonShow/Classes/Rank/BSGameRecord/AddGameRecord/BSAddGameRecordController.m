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
@property (nonatomic, strong) AVUser *oppUser;
@property (nonatomic, weak )  UIButton *btn ;
@end

@implementation BSAddGameRecordController

 
- (instancetype)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
        _gameModel = [[BSGameModel alloc] init];
        _gameModel.playerA_objectId = [AVUser currentUser].objectId;
        
        //  A的头像
        AVFile *aAvatar = [[AVUser currentUser] objectForKey:AVPropertyAvatar];
        _gameModel.aAVatar = [UIImage imageWithData:[aAvatar getData]];
        //  B的头像
        AVFile *bAvatar = [self.oppUser objectForKey:AVPropertyAvatar];
        _gameModel.bAVatar = [UIImage imageWithData:[bAvatar getData]];
    
        
        _gameModel.playerA_name = [AVUser currentUser].username;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送比赛" style:UIBarButtonItemStylePlain target:self action:@selector(sendGame)];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BSAddGameRecordCell" bundle:nil] forCellReuseIdentifier:@"BSAddGameRecordCell"];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [SVProgressHUD dismiss];
}



#pragma mark - BSChoosePlayerViewControllerDelegate
- (void)didSelectPlayer:(AVUser *)user{
    self.oppUser = user ;
    
    [self.oppUser fetchInBackgroundWithKeys:@[@"username",@"nickname"] block:^(AVObject *object, NSError *error) {
       
        AVFile *bAvatar = [self.oppUser objectForKey:AVPropertyAvatar];
        _gameModel.bAVatar = [UIImage imageWithData:[bAvatar getData]];
        _gameModel.playerB_name = self.oppUser.username;
        
        [self.tableView reloadData];
    }];
   
}


#pragma mark - Cell Delegate
-(void)presentFriendListVC{
    BSChoosePlayerViewController *choosePlayVC = [[BSChoosePlayerViewController alloc] init];
    choosePlayVC.title = @"选择对友/对手";
    choosePlayVC.delegate = self;
    [self.navigationController pushViewController:choosePlayVC animated:YES];
}


- (void)sendGame
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    BSAddGameRecordCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    NSString *aScore = cell.firstGameA_scoreTF.text;
    NSString *bScore = cell.firstGameB_scoreTF.text;
    
    [self uploadGameWithAScore:aScore bScore:bScore button:nil];
}

- (void)uploadGameWithAScore:(NSString *)aScoreStr bScore:(NSString *)bScoreStr button:(UIButton *)btn{
    
    if (!self.oppUser) {
        [SVProgressHUD showErrorWithStatus:@"请选择对手"];
        return;
    }
    
    [self.view endEditing:YES];
    [SVProgressHUD showWithStatus:@"正在上传比赛数据"];
    
    NSError *myError;
    NSError *oppError ;
    [[AVUser currentUser] fetchIfNeeded:&myError];
    [self.oppUser fetchIfNeeded:&oppError];
    
    if (myError || oppError) {
        [SVProgressHUD showErrorWithStatus:@"网络错误，请检查网络"];
        return ;
    }

    //  构造gameModel
    self.gameModel.gameType   = eBSGameTypeManSingle;
    self.gameModel.playerA_score =  aScoreStr;
    self.gameModel.playerB_score =  bScoreStr;
    
    if (![self valiateGame:self.gameModel]) {
        return;
    };
    
    AVObject *gameObj = [self AVObjectWithGameModel:self.gameModel];
    
    [self saveGameToTemp:gameObj ];
}


- (AVObject *)AVObjectWithGameModel:(BSGameModel *)game
{
    //   A 代表发送者  。 不代表赢者
    
    
    AVObject *gameObj = [AVObject objectWithClassName:@"Game"];
    
    gameObj[@"startTime"]  = game.startTime = self.currentDateString;
    gameObj[@"endTime"]    = game.endTime = self.currentDateString ;
    gameObj[@"gameType"]   = @(game.gameType);

    gameObj[@"aScore"]     =   @([game.playerA_score integerValue]) ;//  玩家A的每场比赛得分
    gameObj[@"bScore"]     =   @([game.playerB_score integerValue]);//  玩家B的每场比赛得分

    //
    [gameObj setObject:[AVUser currentUser] forKey:@"aPlayer"];
    [gameObj setObject:self.oppUser forKey:@"bPlayer"];
    
    return gameObj;
}

- (BOOL)valiateGame:(BSGameModel *)game
{
    if (!game.playerA_score || !game.playerB_score) {
        [SVProgressHUD showErrorWithStatus:@"请填写比分"];
        return  NO ;
    }
    
    return YES;
}


// 保存比赛数据到TempGame表中
- (void)saveGameToTemp:(AVObject *)gameObj
{
    [gameObj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [SVProgressHUD showSuccessWithStatus:@"上传成功"];
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(saveGameObject:)]) {
                [self.delegate  saveGameObject:gameObj ];
            }
            
            [self turnBack];
        }else{
            [SVProgressHUD showErrorWithStatus:@"上传失败，请检查网络"];
        }
    }];
}



- (void)turnBack
{
    [self.navigationController popViewControllerAnimated:YES];
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
    cell.game = self.gameModel;
    
    cell.delegate = self;
    
    return cell;
}


#pragma mark - Properties
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




@end
