//
//  BSDBManager.h
//  BadmintonShow
//
//  Created by lizhihua on 12/20/15.
//  Copyright © 2015 LZH. All rights reserved.
//  数据库管理类

#import <Foundation/Foundation.h>
#import "BSProfileUserModel.h"
#import "BSGameModel.h"

/**
 *  @author lizhihua, 15-12-21 09:12:01
 *  @brief 多用户DB管理
 */
@interface BSDBManager : NSObject

// 数据库单例
+ (instancetype)manager;
// 初始化数据库
+ (void)initDBWithID:(NSString *)myID ;



#pragma mark - BSProfileUserModel
///========================================================================
/// @name BSProfileUserModel
///========================================================================
+ (BOOL)saveUsers:(NSArray *)users;
+ (BSProfileUserModel *)userWithObjectId:(NSString *)objectId;
+ (NSArray *)allFriends;

//  羽秀天梯排名的用户数据
+ (BOOL)saveRankUsers:(NSArray *)users;
+ (NSArray *)allRankUsers;
+ (void)allRankUserBlock:(BSArrayResultBlock)block ;




#pragma mark - BSGameModel
///========================================================================
/// @name BSGameModel
///========================================================================
+ (BOOL)saveGames:(NSArray *)games;
+ (BSGameModel *)gameWithObjectId:(NSString *)objectId;
+ (void)fetchMyGamesBlock:(BSArrayResultBlock)block; // 需要添加fetch比赛的条件








@end
