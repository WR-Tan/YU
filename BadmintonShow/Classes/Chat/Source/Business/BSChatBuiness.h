//
//  BSChatBuiness.h
//  BadmintonShow
//
//  Created by lizhihua on 12/20/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSProfileUserModel.h"


typedef void (^BSResultBlock)(id object, NSError *error);


@interface BSChatBuiness : NSObject

/**
  获取，关注了“当前用户”的人——粉丝
 */
+ (void)queryFollowersWithBlock:(BSArrayResultBlock)block;

/**
 获取“当前用户”关注的人
 */
+ (void)queryFolloweesWithBlock:(BSArrayResultBlock)block;

/**
 Follower && Followee 并集 —— 获取当前用户互相关注的人
 */
+ (void)queryFriendsWithBlock:(BSArrayResultBlock)block;

/**
 Follower || Followee 合集  （ Class : AVUser ）
 */
+ (void)queryFollowersAndFolloweeWithBlock:(BSArrayResultBlock)block;


/**
 *  @brief Follower || Followee 合集（ Class : BSProfileUserModel ）
 */
+ (void)queryUserModelForFollowersAndFolloweeWithBlock:(BSArrayResultBlock)block ;

/*!
 * 查找朋友（粉丝+关注） && 同意App使用用户数据
 */
+ (void)queryUserModelForFollowersAndFolloweesAllowAppuserDataWithBlock:(BSArrayResultBlock)block ;

/**
 *  @author lizhihua, 15-12-20 21:12:34
 *  @brief 查询指定用户，只会返回一个用户。
 *  @param block (<AVUser *> NSArray, NSError *error)
 */
+ (void)querySpecifyUsersWithUserName:(NSString *)username block:(BSResultBlock)block;


+ (BSProfileUserModel *)userFromDBWithObjectId:(NSString *)objectId;


+ (NSArray *)allFriendsFromDB ;

@end








