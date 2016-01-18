
//
//  BSGameBusiness.m
//  BadmintonShow
//
//  Created by LZH on 15/11/18.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import "BSGameBusiness.h"
#import "BSGameModel.h"
#import <AVOSCloud/AVObject.h>
#import "AVUser.h"
#import "BSUserDefaultStorage.h"
#import "AVRelation.h"
#import "BSDBManager.h"
#import "BSCacheManager.h"

#define kUserDefaultKeySelectedBMTGameType  @"SelectedBMTGameType"

@implementation BSGameBusiness


+ (AVObject *)AVObjectWithGameModel:(BSGameModel *)game
{
    AVObject *gameObj = [AVObject objectWithClassName:@"Game"];
    
    gameObj[@"playerA_score"]     =  game.aScore;//  玩家A的每场比赛得分
    gameObj[@"playerB_score"]     =  game.bScore;//  玩家B的每场比赛得分
    gameObj[@"gameType"]          =  @(game.gameType);  // 比赛的类型
    gameObj[@"playerA_objectId"]  =  game.aObjectId;
    gameObj[@"playerB_objectId"]  =  game.bObjectId;
    gameObj[@"winner_objectId"]   =  game.winner_objectId;
    gameObj[@"playerA_name"]      =  game.aPlayer.nickName;
    gameObj[@"playerB_name"]      =  game.bPlayer.nickName;
    gameObj[@"startTime"]         =  game.startTime = self.currentDateString;
    gameObj[@"endTime"]           =  game.endTime = self.currentDateString ;
    gameObj[@"winner_objectId"]   =  game.winner_objectId = game.aObjectId;
    
    return gameObj;
}

+ (NSInteger)BMTGameTypeFromUserDefault {
    NSNumber *gameType = [BSUserDefaultStorage objectForKey:UserDefaultKeyWithUsertId(kUserDefaultKeySelectedBMTGameType)];
    return [gameType integerValue];
}

+ (void)setBMTGameTypeToUserDefault:(NSInteger)gameType {
    [BSUserDefaultStorage setObject:@(gameType) forKey:UserDefaultKeyWithUsertId(kUserDefaultKeySelectedBMTGameType)];
}

+ (NSString *)currentDateString{
    NSString *currentDateStr = [self.dateFormatter stringFromDate:[NSDate date]];
    return currentDateStr;
}

+ (NSDateFormatter *)dateFormatter{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return dateFormatter;
}


+ (void)queryGameFromNetWithLimit:(NSInteger)limit skip:(NSInteger)skip Block:(BSArrayResultBlock)block {
    AVRelation *relation  = [[AVUser currentUser] relationforKey:AVRelationUserGamesRelation];
    AVQuery *query = [relation query] ;
    [query includeKey:@"aRankScore"];
    [query includeKey:@"bRankScore"];
    [query includeKey:@"aPlayer"];
    [query includeKey:@"bPlayer"];
    query.limit = limit;
    query.skip = skip;
    [query addDescendingOrder:AVPropertyCreatedAt];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            block(nil,error);
            return ;
        } else {
            NSMutableArray *gameArray = [NSMutableArray array];
            for (AVObject *gameObj in objects) {
                BSGameModel *gameModel = [BSGameModel modelWithAVObject:gameObj];
                [gameArray addObject:gameModel];
            }
            [BSDBManager saveGames:gameArray];
            block(gameArray,nil);
        }
    }];
}

+ (void)queryGameFromDBWithBlock:(BSArrayResultBlock)block {
    [BSDBManager fetchMyGamesBlock:block];
}

+ (BOOL)validateScoreInGame:(BSGameModel *)game {
    
    
    
    return YES;
}

@end

