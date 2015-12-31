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
#import "SVProgressHUD.h"
#import "Masonry.h"
#import "BSSetGameTypeController.h"
#import "BSChooseSinglePlayerController.h"
#import "BSChooseTeamPlayerController.h"
#import "BSCommonTool.h"

@interface BSAddGameRecordController ()<BSAddGameRecordCellDelegate,UITableViewDataSource,UITableViewDelegate,BSChooseSinglePlayerControllerDelegate>{
    NSInteger _numberOfRows ;
}

@property (nonatomic, strong) UITableView *tableView ;
@property (nonatomic, strong) BSGameModel *gameModel ;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) AVUser *oppUser;
@property (nonatomic, weak )  UIButton *btn ;
@property (nonatomic, strong)  UIButton *sendBtn ;
@property (nonatomic, assign ) BMTGameType gameType;
@property (nonatomic, strong) NSDictionary *titleDict;

@property (nonatomic, strong) BSProfileUserModel *singlePlayerOpponent;
@end

@implementation BSAddGameRecordController

 
- (instancetype)init{
    self = [super init];
    if (self) {
        _numberOfRows = 1 ;
        _titleDict = @{@0:@"男单",@1:@"男双",@2:@"女单",@3:@"女双",@4:@"混双",};
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.gameModel.aPlayer = AppContext.user;
    [self setupBaseViews];
    
    // 下个版本
#if 0
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"类型" style:UIBarButtonItemStylePlain target:self action:@selector(gameSettings)];
#endif
}




- (void)setupBaseViews{
    self.title = @"单打";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"BSAddGameRecordCell" bundle:nil] forCellReuseIdentifier:@"BSAddGameRecordCell"];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(5);
    }];
    
    UIButton *button = [BSCommonTool bottomButtomWithVC:self];
    [button setTitle:@"发送给对手" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(sendGame) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    NSDictionary *titleDict = @{@0 : @"男单", @1 : @"男双", @2 : @"女单",
//                                @3 : @"女双", @4 : @"混双"};
//    self.title = titleDict[@(self.gameType)];
//}


#pragma mark - ChooseSinglePlayer

- (void)sendGame{
    [self.view endEditing:YES];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    BSAddGameRecordCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    NSString *aScore = cell.firstGameA_scoreTF.text;
    NSString *bScore = cell.firstGameB_scoreTF.text;
    
    if (!aScore || !bScore) {
        [SVProgressHUD showErrorWithStatus:@"请输入比分"];
        return;
    }
    
    if (!self.gameModel.bPlayer) {
        [SVProgressHUD showErrorWithStatus:@"请选择对手"];
        return;
    }
    
    //  构造gameModel
    self.gameModel.gameType   =  self.gameType;
    self.gameModel.aScore =  aScore;
    self.gameModel.bScore =  bScore;
    
    if (![self valiateGame:self.gameModel]) {
        return;
    };
    
    [SVProgressHUD showWithStatus:@"正在上传比赛数据"];
    
    AVObject *gameObj = [self AVObjectWithGameModel:self.gameModel];
    
    [self saveGameToTemp:gameObj ];
}


//  选择了对手
- (void)selectedSinglePlayer:(BSProfileUserModel *)player{
    self.gameModel.bPlayer = player;
    [self.tableView reloadData];
}


#pragma mark - Cell Delegate
-(void)presentFriendListVC{
    
    if (self.gameType == BMTGameTypeManSingle ||      //   如果是单打，则选择对手
        self.gameType == BMTGameTypeWomanSingle ) {
      
        BSChooseSinglePlayerController *singleVC = [[BSChooseSinglePlayerController alloc] init];
        singleVC.title = [NSString stringWithFormat:@"请选择%@对手",_titleDict[@(self.gameType)]];
        singleVC.delegate = self;
        [self.navigationController pushViewController:singleVC animated:YES];
        
    } else {  // 选择双打对手
        BSChooseTeamPlayerController *teamVC = [[BSChooseTeamPlayerController alloc] init];
        teamVC.title = [NSString stringWithFormat:@"请选择%@对手",_titleDict[@(self.gameType)]];
        [self.navigationController pushViewController:teamVC animated:YES];
    }
    
    
}


- (void)gameSettings{
    BSSetGameTypeController *setGameVC = [[BSSetGameTypeController alloc] init];
    setGameVC.title = @"比赛类型";
    [self.navigationController pushViewController:setGameVC animated:YES];
}



- (AVObject *)AVObjectWithGameModel:(BSGameModel *)game{
    AVUser *opponentPlayer = [AVUser user];
    opponentPlayer.objectId = game.bPlayer.objectId;
    
    AVObject *gameObj = [AVObject objectWithClassName:@"Game"];
    gameObj[@"startTime"]  = game.startTime = self.currentDateString;
    gameObj[@"endTime"]    = game.endTime = self.currentDateString ;
    gameObj[@"gameType"]   = @(game.gameType);
    gameObj[@"aScore"]     = @([game.aScore integerValue]) ;//  玩家A的每场比赛得分
    gameObj[@"bScore"]     = @([game.bScore integerValue]);//  玩家B的每场比赛得分
    [gameObj setObject:[AVUser currentUser] forKey:@"aPlayer"];
    [gameObj setObject:opponentPlayer forKey:@"bPlayer"];
    return gameObj;
}

- (BOOL)valiateGame:(BSGameModel *)game{
    if (!game.aScore || !game.bScore) {
        [SVProgressHUD showErrorWithStatus:@"请填写比分"];
        return  NO ;
    }
    return YES;
}


// 保存比赛数据到TempGame表中
- (void)saveGameToTemp:(AVObject *)gameObj{
    
    [gameObj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [SVProgressHUD showSuccessWithStatus:@"上传成功"];
            if (self.delegate && [self.delegate respondsToSelector:@selector(saveGameObject:)]) {
                [self.delegate  saveGameObject:gameObj ];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:@"上传失败，请检查网络"];
        }
    }];
}





- (void)segmentCtlAction:(UISegmentedControl *)segmentControl{
    //  改变选择条件·查询条件
    
}


#pragma mark - IBAction

- (void)sendGameToOpp
{
    
}


#pragma mark - ScrollView Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark - TableView数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _numberOfRows;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  250 ; //  暂时先只上传一场比赛的比分，3场比赛的暂时不做。
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
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

- (BMTGameType)gameType {
     _gameType = [BSGameBusiness BMTGameTypeFromUserDefault];
    return _gameType;
}

- (BSProfileUserModel *)singlePlayerOpponent {
    if (!_singlePlayerOpponent) {
        _singlePlayerOpponent = [[BSProfileUserModel alloc] init];
    }
    return _singlePlayerOpponent;
}

- (BSGameModel *)gameModel {
    if (!_gameModel) {
        _gameModel = [[BSGameModel alloc] init];
    }
    return _gameModel;
}

@end
