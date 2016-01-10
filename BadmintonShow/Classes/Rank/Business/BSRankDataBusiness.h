//
//  BSRankDataBusiness.h
//  BadmintonShow
//
//  Created by lizhihua on 12/21/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSCircleModel.h"

@interface BSRankDataBusiness : NSObject


#pragma mark - 好友排名

/// 一次性请求，需要改善。
//  Limit:(NSInteger)limit skip:(NSInteger)skip 
+ (void)queryFriendRankDataWithBlock:(BSArrayResultBlock)block;


#pragma mark - 圈子内排名

+ (void)queryCircleRankDataCircleClass:(NSString *)cls property:(NSString *)property block:(BSArrayResultBlock)block ;


//  查询某个圈子内所有用户的排名。
+ (void)queryRankingInCircle:(BSCircleModel *)circle limit:(NSInteger)limit skip:(NSInteger)skip block:(BSArrayResultBlock)block ;


#pragma mark - 羽秀天梯排名

+ (void)queryRankUserDataWithLimit:(NSInteger)limit skip:(NSInteger)skip block:(BSArrayResultBlock)block;

+ (BOOL)saveRankUsers:(NSArray *)users;

+ (void)queryAllRankUserWithBlock:(BSArrayResultBlock)block ;




@end
