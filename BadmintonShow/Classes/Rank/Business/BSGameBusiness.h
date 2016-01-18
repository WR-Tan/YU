//
//  BSGameBusiness.h
//  BadmintonShow
//
//  Created by LZH on 15/11/18.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AVObject ;
@class BSGameModel ;

@interface BSGameBusiness : NSObject

+ (AVObject *)AVObjectWithGameModel:(BSGameModel *)game;

+ (NSInteger)BMTGameTypeFromUserDefault;

+ (void)setBMTGameTypeToUserDefault:(NSInteger)gameType;

+ (void)queryGameFromNetWithLimit:(NSInteger)limit skip:(NSInteger)skip Block:(BSArrayResultBlock)block;

+ (void)queryGameFromDBWithBlock:(BSArrayResultBlock)block;

/**
 *  @author lizhihua, 16-01-11 14:01:00
 *
 *  @brief 最高分：11，15，21~30
 *
 *  @param game 比赛模型BSGameModel
 *  @return 返回 game的分数是否符合规则
 *
 */
+ (BOOL)validateScoreInGame:(BSGameModel *)game;

@end
