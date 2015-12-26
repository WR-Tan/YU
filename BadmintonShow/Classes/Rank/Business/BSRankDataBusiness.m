//
//  BSRankDataBusiness.m
//  BadmintonShow
//
//  Created by lizhihua on 12/21/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSRankDataBusiness.h"
#import "AVQuery.h"
#import "BSDBManager.h"
#import "BSTimeManager.h"
#import "BSChatBuiness.h"
#import "AVRelation.h"

@implementation BSRankDataBusiness

#pragma mark - 好友排名
///========================================================================
/// @name 好友排名
///========================================================================


+ (void)queryFriendRankDataWithBlock:(BSArrayResultBlock)block {
     [BSChatBuiness queryUserModelForFollowersAndFolloweeWithBlock:^(NSArray *objects, NSError *error) {
         if (error) {
             block(nil, error);
             return ;
         }
         
         NSMutableArray *friends = [NSMutableArray arrayWithArray:objects];
         [friends addObject:AppContext.user];
         block(friends,nil);
     }];
}



#pragma mark - 圈子排名
///========================================================================
/// @name 圈子排名
///========================================================================

+ (void)queryCircleRankDataCircleClass:(NSString *)cls property:(NSString *)property block:(BSArrayResultBlock)block {
    
    // query _User realtions to School
    AVObject *SZU = [AVObject objectWithoutDataWithClassName:cls objectId:@"5672d77a60b2298f12177a17"];

    AVQuery *rankQuery = [AVQuery queryWithClassName:AVClassUser];
    [rankQuery whereKey:property equalTo:SZU];
//    rankQuery.limit = 200 ;
//    
    [rankQuery addDescendingOrder:AVPropertyScore];
    [rankQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            block(nil, error);
            return ;
        }
        
        AppTimeManager.lastSuccessRankRequestDate = [NSDate date];
        
        NSMutableArray *rankUsers = [ NSMutableArray array];
        for (AVUser *user in objects) {
            BSProfileUserModel *useModel = [BSProfileUserModel modelFromAVUser:user];
            [rankUsers addObject:useModel];
        }
        [self saveRankUsers:rankUsers];
        block(rankUsers,nil);
    }];
}


#pragma mark - 天梯排名
///========================================================================
/// @name 天梯排名
///========================================================================
+ (void)queryRankUserDataWithBlock:(BSArrayResultBlock)block{
    
    //  以下代码正在考虑中……
#if 0
    //  如果今天已经请求过数据，不会再请求。
    NSDate *lastSuccess = AppTimeManager.lastSuccessRankRequestDate;
    if (lastSuccess && [lastSuccess isToday]) {
        NSArray *rankData = [self queryRankUsersDataFromDB];
        block(rankData,nil);
        return;
    }
#endif
    
    AVQuery *rankQuery = [AVQuery queryWithClassName:AVClassUser];
    rankQuery.limit = 200 ;
    
    [rankQuery addDescendingOrder:AVPropertyScore];
    [rankQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            block(nil, error);
            return ;
        }
        
        AppTimeManager.lastSuccessRankRequestDate = [NSDate date];
        
        NSMutableArray *rankUsers = [ NSMutableArray array];
        for (AVUser *user in objects) {
            BSProfileUserModel *useModel = [BSProfileUserModel modelFromAVUser:user];
            [rankUsers addObject:useModel];
        }
        [self saveRankUsers:rankUsers];
        block(rankUsers,nil);
    }];
}


+ (void)queryAllRankUserWithBlock:(BSArrayResultBlock)block {
    [BSDBManager allRankUserBlock:block];
}

+ (BOOL)saveRankUsers:(NSArray *)users {
   return [BSDBManager saveRankUsers:users];
}




@end
