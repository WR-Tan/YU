
//
//  BSChatBuiness.m
//  BadmintonShow
//
//  Created by lizhihua on 12/20/15.
//  Copyright © 2015 LZH. All rights reserved.
//  聊天模块-包含通讯录

#import "BSChatBuiness.h"
#import "AVUser.h"
#import "AVOSCloud.h"
#import "CDCacheManager.h"
#import "BSProfileUserModel.h"
#import "BSDBManager.h"


@implementation BSChatBuiness

+ (void)queryFollowersWithBlock:(BSArrayResultBlock)block {
    AVUser *user = [AVUser currentUser];
    AVQuery *q = [user followerQuery];
    q.cachePolicy = kAVCachePolicyNetworkElseCache;
    [q findObjectsInBackgroundWithBlock: ^(NSArray *objects, NSError *error) {
        if (error == nil) {
            [[CDCacheManager manager] registerUsers:objects];
        }
        block(objects, error);
    }];
}

+ (void)queryFolloweesWithBlock:(BSArrayResultBlock)block {
    AVUser *user = [AVUser currentUser];
    AVQuery *q = [user followeeQuery];
    q.cachePolicy = kAVCachePolicyNetworkElseCache;
    [q findObjectsInBackgroundWithBlock: ^(NSArray *objects, NSError *error) {
        if (error == nil) {
            [[CDCacheManager manager] registerUsers:objects];
        }
        block(objects, error);
    }];
}


+ (void)queryFriendsWithBlock:(BSArrayResultBlock)block {
    // 1. 获取粉丝AVUser
    [self queryFolloweesWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            block(nil, error);
            return ;
        }
        [[CDCacheManager manager] registerUsers:objects];
        //  2. 查询自己关注的人AVUser
        [self queryFollowersWithBlock:^(NSArray *obj, NSError *err) {
            if (error) {
                block(nil, err);
                return ;
            }
            [[CDCacheManager manager] registerUsers:objects];
            //  查询成功。
            NSArray *friends = [self selectFriendsFromFollowees:objects followers:obj];
            
            [BSDBManager saveUsers:friends];
            
            block(friends,nil);
        }];
    }];
}

//  AVUser
+ (NSMutableArray *)selectFriendsFromFollowees:(NSArray *)followeesArr followers:(NSArray *)followersArr {
    
    NSMutableArray *friends = [NSMutableArray array];
    for (NSInteger i = 0; i < followeesArr.count; i++) {
        AVUser *followee = followeesArr[i];
        [followee setObject:@(YES) forKey:AVPropertyIsFollowee];
        
        for (NSInteger j = 0; j < followersArr.count; j++) {
            AVUser *follower = followersArr[j];
            [follower setObject:@(YES) forKey:AVPropertyIsFollower];
            
            if ([followee.objectId isEqualToString:follower.objectId]) {
                [follower setObject:@(YES) forKey:AVPropertyIsFriend];
                [friends addObject:follower];
            }
        }
    }
    return friends;
}

//  查询结果是AVUser
+ (void)queryFollowersAndFolloweeWithBlock:(BSArrayResultBlock)block {
    
    [self queryFolloweesWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            block(nil, error);
            return ;
        }
        [[CDCacheManager manager] registerUsers:objects];
        [self queryFollowersWithBlock:^(NSArray *obj, NSError *err) {  //  2. 查询自己关注的人AVUser
            if (error) {
                block(nil, err);
                return ;
            }
            [[CDCacheManager manager] registerUsers:objects];
            
            // AVUser *friends
            NSArray *friends = [self selectUnionFromFollowees:objects followers:obj];
            NSMutableArray *arrM = [NSMutableArray array];
            for (AVUser *user in friends) {
                BSProfileUserModel *model = [BSProfileUserModel modelFromAVUser:user];
                [arrM addObject:model];
            }
            [BSDBManager saveUsers:arrM];
            block(friends,nil);
        }];
    }];
}

//  查询数据是BSProfileUserModel
+ (void)queryUserModelForFollowersAndFolloweeWithBlock:(BSArrayResultBlock)block {
    
    [self queryFolloweesWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            block(nil, error);
            return ;
        }
        [self queryFollowersWithBlock:^(NSArray *obj, NSError *err) {  //  2. 查询自己关注的人AVUser
            if (error) {
                block(nil, err);
                return ;
            }
            NSArray *friends = [self selectUnionFromFollowees:objects followers:obj];
            NSMutableArray *arrM = [NSMutableArray array];
            for (AVUser *user in friends) {
                BSProfileUserModel *model = [BSProfileUserModel modelFromAVUser:user];
                [arrM addObject:model];
            }
            [BSDBManager saveUsers:arrM];
            block(arrM,nil);
        }];
    }];
}


+ (NSArray *)selectUnionFromFollowees:(NSArray *)followeesArr followers:(NSArray *)followersArr {
 
    NSMutableArray *friends = [self selectFriendsFromFollowees:followeesArr followers:followersArr];
    
    NSMutableArray *unionArr = [NSMutableArray array];
    [unionArr addObjectsFromArray:followersArr];
    [unionArr addObjectsFromArray:followeesArr];
    
    for (NSInteger i = 0; i < friends.count; i++) {
        AVUser *userInFriends = friends[i];
        for (NSInteger j = 0; j < unionArr.count; j++) {
            AVUser *userInUnion = unionArr[j];
            if ([userInFriends.objectId isEqualToString:userInUnion.objectId]) {
                [unionArr removeObject:userInUnion];
                //  删掉一次：（一共有2个不同，删掉一个）
                break;
            }
        }
    }
    return unionArr;
}


+ (void)querySpecifyUsersWithUserName:(NSString *)username block:(BSResultBlock)block {
    if (username.length == 0)  return;
    
    AVQuery *q = [AVQuery queryWithClassName:AVClassUser];
    [q whereKey:@"username" equalTo:username];
    [q findObjectsInBackgroundWithBlock: ^(NSArray *objects, NSError *error) {
        if (error == nil) {
            [[CDCacheManager manager] registerUsers:objects];
        }
        AVUser *user = [objects firstObject];
        BSProfileUserModel *userModel = [BSProfileUserModel modelFromAVUser:user];
        block(userModel, error);
    }];
}


#pragma mark - 从数据库获取BSProfileUserModel数据
///========================================================================
/// @name 从数据库获取BSProfileUserModel数据
///========================================================================

+ (BSProfileUserModel *)userFromDBWithObjectId:(NSString *)objectId {
    BSProfileUserModel *userModel = [BSDBManager  userWithObjectId:objectId];
    return userModel;
}

+ (NSArray *)allFriendsFromDB {
    return [BSDBManager  allFriends];
}


@end
