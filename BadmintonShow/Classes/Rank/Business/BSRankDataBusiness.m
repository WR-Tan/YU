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
#import "BSCircleModel.h"

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


//  查询某个圈子内的排名
+ (void)queryRankingInCircle:(BSCircleModel *)circle limit:(NSInteger)limit skip:(NSInteger)skip block:(BSArrayResultBlock)block {
    AVObject *circleObject = [AVObject objectWithoutDataWithClassName:AVClassCircle objectId:circle.objectId];
    AVQuery *query = [AVRelation reverseQuery:AVClassUser relationKey:AVRelationCircles childObject:circleObject];
    query.limit = limit;
    query.skip = skip;
    [query addDescendingOrder:AVPropertyScore];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [self handleReceivedUsersArray:objects block:block];
    }];
}



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
+ (void)queryRankUserDataWithLimit:(NSInteger)limit skip:(NSInteger)skip block:(BSArrayResultBlock)block{

    AVQuery *rankQuery = [AVQuery queryWithClassName:AVClassUser];
    rankQuery.limit = limit ;
    rankQuery.skip = skip;
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

+ (void)queryRankingDataInCircle:(BSCircleModel *)circle {
    
}


#pragma mark - inner public method
///========================================================================
/// @name invoked insided method
///========================================================================
+ (void)handleReceivedUsersArray:(NSArray *)objects block:(BSArrayResultBlock)block{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableArray *rankUsers = [ NSMutableArray array];
        for (AVUser *user in objects) {
            BSProfileUserModel *useModel = [BSProfileUserModel modelFromAVUser:user];
            [rankUsers addObject:useModel];
        }
        [self saveRankUsers:rankUsers];
        block(rankUsers,nil);
    });
}


@end
