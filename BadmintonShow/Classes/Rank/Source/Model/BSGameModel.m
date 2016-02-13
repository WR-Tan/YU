//
//  BSGameModel.m
//  BadmintonShow
//
//  Created by mac on 15/10/17.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import "BSGameModel.h"

@implementation BSGameModel

+ (instancetype)modelWithAVObject:(AVObject *)object {
    
    BSGameModel  *gameModel = [[BSGameModel alloc] init];
    gameModel.objectId = object[AVPropertyObjectId];
    gameModel.endTime = object[@"endTime"];
    gameModel.gameType = [object[@"gameType"] integerValue];
    gameModel.isConfirmed = [object[@"isConfirmed"] boolValue];
    gameModel.startTime = object[@"startTime"];
    gameModel.gameId = object[AVPropertyGameId];
    gameModel.isConfirmed = [object[AVPropertyIsConfirmed] boolValue]?:NO;

    if ([object[@"aPlayer"][@"objectId"] isEqualToString:AppContext.user.objectId]) {
        
        gameModel.aPlayer = [BSProfileUserModel modelFromAVUser:object[@"aPlayer"]];
        gameModel.bPlayer = [BSProfileUserModel modelFromAVUser:object[@"bPlayer"]];

        gameModel.aScore =  [object[@"aScore"] stringValue];
        gameModel.bScore =  [object[@"bScore"] stringValue];
        
        gameModel.aRankScore = [object[@"aRankScore"] stringValue] ? : @"";
        gameModel.bRankScore = [object[@"bRankScore"] stringValue] ? : @"";
    }else {
        
        gameModel.aPlayer = [BSProfileUserModel modelFromAVUser:object[@"bPlayer"]];
        gameModel.bPlayer = [BSProfileUserModel modelFromAVUser:object[@"aPlayer"]];
        
        gameModel.aScore =  [object[@"bScore"] stringValue];
        gameModel.bScore =  [object[@"aScore"] stringValue];
        
        gameModel.aRankScore = [object[@"bRankScore"] stringValue] ? : @""; //  玩家A的排名分数
        gameModel.bRankScore = [object[@"aRankScore"] stringValue] ? : @"";  //  玩家B的排名分数
    }
    
    gameModel.creator = [BSProfileUserModel modelFromAVUser:object[AVPropertyCreator]];
    
  
    
    return gameModel;
}




@end
