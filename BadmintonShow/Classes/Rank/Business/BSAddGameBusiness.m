
//
//  BSAddGameBusiness.m
//  BadmintonShow
//
//  Created by LZH on 15/11/18.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import "BSAddGameBusiness.h"
#import "BSGameModel.h"
#import <AVOSCloud/AVObject.h>
#import "AVUser.h"
#import "BSUserDefaultStorage.h"

#define kUserDefaultKeySelectedBMTGameType  @"SelectedBMTGameType"

@implementation BSAddGameBusiness


+ (AVObject *)AVObjectWithGameModel:(BSGameModel *)game
{
    AVObject *gameObj = [AVObject objectWithClassName:@"Game"];
    
    gameObj[@"playerA_score"]     =  game.playerA_score;//  玩家A的每场比赛得分
    gameObj[@"playerB_score"]     =  game.playerB_score;//  玩家B的每场比赛得分
    gameObj[@"gameType"]          =  @(game.gameType);  // 比赛的类型
    gameObj[@"playerA_objectId"]  =  game.playerA_objectId;
    gameObj[@"playerB_objectId"]  =  game.playerB_objectId;
    gameObj[@"winner_objectId"]   =  game.winner_objectId;
    gameObj[@"playerA_name"]      =  game.playerA_name;
    gameObj[@"playerB_name"]      =  game.playerB_name;
    gameObj[@"startTime"]         =  game.startTime = self.currentDateString;
    gameObj[@"endTime"]           =  game.endTime = self.currentDateString ;
    gameObj[@"winner_objectId"]   =  game.winner_objectId = game.playerA_objectId;
    
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


@end

