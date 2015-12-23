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
    
    
    if ([object[@"aPlayer"][@"objectId"] isEqualToString:AppContext.user.objectId]) {
        gameModel.aScore =  [object[@"aScore"] stringValue];
        gameModel.bScore =  [object[@"bScore"] stringValue];
    }else {
        gameModel.aScore =  [object[@"bScore"] stringValue];
        gameModel.bScore =  [object[@"aScore"] stringValue];
    }
    
    gameModel.aObjectId = object[@"aPlayer"][AVPropertyObjectId];
    gameModel.bObjectId = object[@"bPlayer"][AVPropertyObjectId];
    
    gameModel.aRankScore = [object[@"aRankScore"] stringValue] ? : @""; //  玩家A的排名分数
    gameModel.bRankScore = [object[@"bRankScore"] stringValue] ? : @"";  //  玩家B的排名分数
    gameModel.gameId = object[AVPropertyGameId];
    
    AVUser *aPlayer = object[@"aPlayer"];
    AVUser *bPlayer = object[@"bPlayer"];
    gameModel.aPlayer = [BSProfileUserModel modelFromAVUser:aPlayer];
    gameModel.bPlayer = [BSProfileUserModel modelFromAVUser:bPlayer];
    
    return gameModel;
}




@end
