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
#import <AVOSCloud/AVOSCloud.h>
#import "BSGameModel.h"

@interface BSGameRecordController ()
{
    NSMutableArray *_gameRecordData;
}
@property (nonatomic ,strong )AVUser *oppUser;
@property (nonatomic ,strong )AVUser *myUser;

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
    
    [self setupBaseView];
    [self initData];
}

- (void)setupBaseView
{
    [self.tableView registerNib:[UINib nibWithNibName:@"BSGameRecordCell" bundle:nil] forCellReuseIdentifier:@"BSGameRecordCell"];
    
//    [self initNavigationItem];
}


- (void)initData
{
    AVRelation *relation  = [[AVUser currentUser] relationforKey:AVRelationUserGamesRelation];
    
    [[relation query] findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            // 呃，报错了
        } else {
            
            
            
            for (AVObject *gameObj in objects) {
                //  avobject to gameModel
                BSGameModel *gameModel = [[BSGameModel alloc] init];
                gameModel.endTime = gameObj[@"endTime"];
                gameModel.gameType = [gameObj[@"gameType"] integerValue];
                gameModel.isConfirmed = [gameObj[@"isConfirmed"] boolValue];
                gameModel.startTime = gameObj[@"startTime"];
                
                
                self.myUser = [AVUser currentUser];
                if ([gameObj[@"aPlayer"][@"objectId"] isEqualToString:[AVUser currentUser].objectId]) {
                    self.oppUser = gameObj[@"bPlayer"];
                    gameModel.playerA_score =  [gameObj[@"aScore"] stringValue];
                    gameModel.playerB_score =  [gameObj[@"bScore"] stringValue];
                }else {
                    self.oppUser = gameObj[@"aPlayer"];
                    gameModel.playerA_score =  [gameObj[@"bScore"] stringValue];
                    gameModel.playerB_score =  [gameObj[@"aScore"] stringValue];
                }
                
                gameModel.playerA_name = self.myUser.username;
                gameModel.playerB_name =  gameObj[@"oppUsername"] ;  //self.oppUser.username;
                gameModel.playerA_objectId = self.myUser.objectId;
                gameModel.playerB_objectId = self.oppUser.objectId;
                
                [_gameRecordData addObject:gameModel];
            }
            
            
            [self.tableView reloadData];
        }
    }];
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
    
    return _gameRecordData.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
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
    
    
    BSGameModel *model = [_gameRecordData objectAtIndex:indexPath.row];
    
    cell.playerAName.text = model.playerA_name;
    cell.playerBName.text = model.playerB_name;
    cell.score.text = [NSString stringWithFormat:@"%@ : %@",model.playerA_score,model.playerB_score];
    cell.creatAt.text = model.startTime;

    
    return cell;
    
}

#pragma mark - TableView代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BSGameRecordDetailController *detail = [[BSGameRecordDetailController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:detail animated:YES];
}

//
//- (void)fakeData
//{     //假数据
//    AVRelation *relation = [[AVUser currentUser] relationforKey:AVRelationUserGamesRelation];
//
//    NSArray *gameIdArray =   @[@"565dcbf700b0bf371649a3ae",
//                               @"565dcb5d00b08a6c00dba7b7",
//                               @"565c6a7a60b2febec4fc5f87",
//                               @"565bfcd360b294bc67758d83",
//                               @"565bf74800b01b78dfa10007",
//                               @"565bf5ab00b0acaad47a7aba",
//                               @"565bf2c860b202594d4b0a98",
//                               @"565ad7a460b2d0be2de35a58",
//                               @"565ad78060b2d0be2de35961",
//                               @"565ad73900b0acaad4738632",
//                               @"565ad70500b0bf379f11ca75"];
//
//    for (NSInteger i = 0 ; i < gameIdArray.count;  i ++ ) {
//
//        AVObject *game1 = [AVObject objectWithoutDataWithClassName:AVClassGame objectId:gameIdArray[i]];
//        [relation addObject:game1];
//    }
//
//
//    [[AVUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//
//
//    }];
//;
//}

@end
