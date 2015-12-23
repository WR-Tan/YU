//
//  BSCacheManager.h
//  BadmintonShow
//
//  Created by lizhihua on 12/21/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSProfileUserModel.h"
#import "BSGameModel.h"

#define AppCacheManager  [BSCacheManager manager]

@interface BSCacheManager : NSObject

// 时间管理类单例
+ (instancetype)manager;
//  取出缓存的用户
+ (BSProfileUserModel *)userCacheWithID:(NSString *)objectId;
//  缓存用户
+ (void)cacheUser:(BSProfileUserModel *)user;

//============================================================
//  取出缓存的用户
+ (BSGameModel *)gameCacheWithID:(NSString *)objectId;
//  缓存用户
+ (void)cacheGame:(BSGameModel *)game;



@end
