//
//  BSDBManager.m
//  BadmintonShow
//
//  Created by lizhihua on 12/20/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSDBManager.h"
#import "FMResultSet.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"


#pragma mark - BSProfileUserModel
///========================================================================
/// @name BSProfileUserModel
///========================================================================

#define kDBTableOfUser      @"USER" // 用户表
#define kDBTableOfRankUser  @"RANKUSER" // 当天排名的用户表

#define kSqlDelete @"DELETE FROM '%@'"
#define kSqlSelect @"SELECT * FROM '%@'"

/// User 除了NSString和NSNumber，不放其他东西
#define kDBSqlUserCreate @"CREATE TABLE IF NOT EXISTS '%@'('objectId' VARCHAR PRIMARY KEY NOT NULL UNIQUE,'avatarUrl' VARCHAR, 'nickName' VARCHAR,'userName' VARCHAR, 'yuxiuId' VARCHAR,'QRCode' VARCHAR,'genderStr' VARCHAR,'mbLevel' VARCHAR,'rankLevel' VARCHAR,'gender' VARCHAR,'height' VARCHAR,'weight' VARCHAR,'birthdayStr' VARCHAR,'nation' VARCHAR,'province' VARCHAR,'city' VARCHAR,'disctrit' VARCHAR,'school' VARCHAR,'accessSchoolTime' VARCHAR,'company' VARCHAR,'job' VARCHAR,'desc' VARCHAR,'score' NUMBER,'isFollower' NUMBER,'isFollowee' NUMBER,'isFriend' NUMBER)"

#define kDBSqlUserInsertOrUpdate @"INSERT OR REPLACE INTO '%@' ('objectId','avatarUrl','nickName','userName','yuxiuId', 'QRCode', 'genderStr', 'mbLevel', 'rankLevel', 'gender', 'height', 'weight', 'birthdayStr', 'nation', 'province', 'city', 'disctrit', 'school', 'accessSchoolTime', 'company', 'job', 'desc','score') VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"

#define kDBSqlSelectObject @"SELECT * FROM '%@' WHERE objectId = '%@'"
#define kDBSqlSelectRankUser @"SELECT * FROM '%@'"  // ORDER BY score DESC -- 操作未完善



#pragma mark - BSGameModel
///========================================================================
/// @name BSGameModel
///========================================================================
#define KDBTableBSGameModel        @"BSGameModel" // 用户表

#define kDBSqlBSGameModelCreate @"CREATE TABLE IF NOT EXISTS '%@'('objectId' VARCHAR PRIMARY KEY NOT NULL UNIQUE,'aObjectId' VARCHAR, 'bObjectId' VARCHAR,'startTime' VARCHAR, 'endTime' VARCHAR,'aScore' VARCHAR,'bScore' VARCHAR,'aRankScore' VARCHAR, 'bRankScore' VARCHAR ,'isConfirmed' NUMBER,'gameType' NUMBER, 'gameId' VARCHAR)"

#define kDBSqlBSGameModelUpdate @"INSERT OR REPLACE INTO '%@' ('objectId','aObjectId','bObjectId','startTime','endTime', 'aScore', 'bScore', 'aRankScore', 'bRankScore', 'isConfirmed', 'gameType', 'gameId') VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"





static NSString *dbPath = nil;          // db路径
static FMDatabaseQueue *queue = nil;    // db管理器

@implementation BSDBManager

/// 单例
+ (instancetype)manager {
    static BSDBManager *_DBManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _DBManager = [[BSDBManager alloc] init];
    });
    return _DBManager;
}

+ (void)initDBWithID:(NSString *)myID {
    if (myID.length) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *dbName = [NSString stringWithFormat:@"/%@.sqlite",myID];
        dbName = [paths[0] stringByAppendingString:dbName];
        NSLog(@"dbName: \n%@", dbName);
        [self createDBByPath:dbName];
    }
}


// 创建数据库
+ (BOOL)createDBByPath:(NSString *)path{
    __block BOOL success = FALSE;
    if (queue) { // 避免重复创建DB
        [queue close];
        queue = nil;
    }
    dbPath = path;
    queue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    NSDictionary *attributes = @{NSFileProtectionKey: NSFileProtectionCompleteUnlessOpen};
    NSError *error;
    [[NSFileManager defaultManager] setAttributes:attributes ofItemAtPath:path
                                            error:&error];
    [queue inDatabase:^(FMDatabase *db) {
        // 创建用户表
        success = [db executeUpdate:[NSString stringWithFormat:kDBSqlUserCreate,kDBTableOfUser]];
        // 创建排名用户表
        success = [db executeUpdate:[NSString stringWithFormat:kDBSqlUserCreate,kDBTableOfRankUser]];
        // 创建BSGameModel表
        success = [db executeUpdate:[NSString stringWithFormat:kDBSqlBSGameModelCreate,KDBTableBSGameModel]];
    }];
    return success;
}





#pragma mark  - 保存BSProfileUserModel信息
+ (BOOL)saveUsers:(NSArray *)users {
    __block BOOL success = FALSE;
    [queue inDatabase:^(FMDatabase *db) {
        success = [db executeUpdate:[NSString stringWithFormat:kDBSqlUserCreate, kDBTableOfUser]];
        for (BSProfileUserModel *aUser in users) {
            if (aUser) {
                NSString *sql =[NSString stringWithFormat:kDBSqlUserInsertOrUpdate, kDBTableOfUser];
                success = [db executeUpdate:sql,
                           aUser.objectId,
                           aUser.avatarUrl,
                           aUser.nickName,
                           aUser.userName,
                           aUser.yuxiuId,
                           aUser.QRCode,
                           aUser.genderStr,
                           aUser.mbLevel,
                           aUser.rankLevel,
                           aUser.gender,
                           aUser.height,
                           aUser.weight,
                           aUser.birthdayStr,
                           aUser.nation,
                           aUser.province,
                           aUser.city,
                           aUser.disctrit,
                           aUser.school,
                           aUser.accessSchoolTime,
                           aUser.company,
                           aUser.job,
                           aUser.desc,
                           @(aUser.score),
                           @(aUser.isFollower),
                           @(aUser.isFollowee),
                           @(aUser.isFriend)
                           ];
            }
        }
    }];
    return success;
}

+ (BSProfileUserModel *)profileUserModelWithResult:(FMResultSet *)s {
    BSProfileUserModel  *model  =  [[BSProfileUserModel alloc] init];
    model.objectId = [s stringForColumn:@"objectId"];
    model.avatarUrl = [s stringForColumn:@"avatarUrl"];
    model.nickName = [s stringForColumn:@"nickName"];
    model.userName = [s stringForColumn:@"userName"];
    model.birthdayStr = [s stringForColumn:@"birthdayStr"];
    model.yuxiuId = [s stringForColumn:@"yuxiuId"];
    model.QRCode = [s stringForColumn:@"QRCode"];
    model.genderStr = [s stringForColumn:@"genderStr"];
    model.mbLevel = [s intForColumn:@"mbLevel"];
    model.rankLevel = [s intForColumn:@"rankLevel"];
    model.gender = [s intForColumn:@"gender"];
    model.height = [s intForColumn:@"height"];
    model.weight = [s intForColumn:@"weight"];
    model.birthday = [s dateForColumn:@"birthday"];
    model.birthdayStr = [s stringForColumn:@"birthdayStr"];
    model.nation = [s stringForColumn:@"nation"];
    model.province = [s stringForColumn:@"province"];
    model.city = [s stringForColumn:@"city"];
    model.disctrit = [s stringForColumn:@"disctrit"];
    model.school = [s stringForColumn:@"school"];
    model.accessSchoolTime = [s stringForColumn:@"accessSchoolTime"];
    model.company = [s stringForColumn:@"company"];
    model.job = [s stringForColumn:@"job"];
    model.desc = [s stringForColumn:@"desc"];
    model.score = [s doubleForColumn:@"score"];
    model.isFollower = [s boolForColumn:@"isFollower"];
    model.isFollowee = [s boolForColumn:@"isFollowee"];
    model.isFriend =  [s boolForColumn:@"isFriend"];
    
    return model;
}

+ (BSProfileUserModel *)userWithObjectId:(NSString *)objectId {
    if (!objectId.length) return nil;
    
    __block BSProfileUserModel  *model  = nil;
    [queue inDatabase:^(FMDatabase *db) {
        if (objectId.length) {
            NSString *querySql = [NSString stringWithFormat:kDBSqlSelectObject, kDBTableOfUser, objectId] ;
            FMResultSet *s = [db executeQuery:querySql];
            while(s.next) {
                model = [self profileUserModelWithResult:s];
            }
            [s close];
        }
    }];
    return model;
}



+ (NSArray *)allFriends {
    NSMutableArray *allFriends = [NSMutableArray array];
    [queue inDatabase:^(FMDatabase *db) {
            NSString *querySql = [NSString stringWithFormat:kSqlSelect,kDBTableOfUser] ;
            FMResultSet *s = [db executeQuery:querySql];
            while(s.next) {
                BSProfileUserModel *model = [self profileUserModelWithResult:s];
                [allFriends addObject:model];
            }
            [s close];
    }];
    return allFriends;
}

+ (BOOL)saveRankUsers:(NSArray *)users {
    __block BOOL success = FALSE;
    [queue inDatabase:^(FMDatabase *db) {
        success = [db executeUpdate:[NSString stringWithFormat:kDBSqlUserCreate, kDBTableOfRankUser]];
        for (BSProfileUserModel *aUser in users) {
            if (aUser) {
                NSString *sql =[NSString stringWithFormat:kDBSqlUserInsertOrUpdate, kDBTableOfRankUser];
                success = [db executeUpdate:sql,
                           aUser.objectId,
                           aUser.avatarUrl,
                           aUser.nickName,
                           aUser.userName,
                           aUser.yuxiuId,
                           aUser.QRCode,
                           aUser.genderStr,
                           aUser.mbLevel,
                           aUser.rankLevel,
                           aUser.gender,
                           aUser.height,
                           aUser.weight,
                           aUser.birthdayStr,
                           aUser.nation,
                           aUser.province,
                           aUser.city,
                           aUser.disctrit,
                           aUser.school,
                           aUser.accessSchoolTime,
                           aUser.company,
                           aUser.job,
                           aUser.desc,
                           @(aUser.score),
                           @(aUser.isFollower),
                           @(aUser.isFollowee),
                           @(aUser.isFriend)
                           ];
            }
        }
    }];
    return success;
}

+ (NSArray *)allRankUsers {
    NSMutableArray *allRankUsers = [NSMutableArray array];
    [queue inDatabase:^(FMDatabase *db) {
        NSString *querySql = [NSString stringWithFormat:kSqlSelect,kDBTableOfRankUser] ;
        FMResultSet *s = [db executeQuery:querySql];
        while (s.next) {
            BSProfileUserModel *model = [self profileUserModelWithResult:s];
            [allRankUsers addObject:model];
        }
        [s close];
    }];
    return allRankUsers;
}

+ (void)allRankUserBlock:(BSArrayResultBlock)block {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableArray *allRankUsers = [NSMutableArray array];
        [queue inDatabase:^(FMDatabase *db) {
            NSString *querySql = [NSString stringWithFormat:kSqlSelect,kDBTableOfRankUser] ;
            FMResultSet *s = [db executeQuery:querySql];
            while (s.next) {
                BSProfileUserModel *model = [self profileUserModelWithResult:s];
                [allRankUsers addObject:model];
            }
            [s close];
        }];
        block(allRankUsers,nil);
    });
}


#pragma mark - BSGameModel
///========================================================================
/// @name BSGameModel
///========================================================================
+ (BOOL)saveGames:(NSArray *)games {
    __block BOOL success = FALSE;
    [queue inDatabase:^(FMDatabase *db) {
        success = [db executeUpdate:[NSString stringWithFormat:kDBSqlBSGameModelCreate, KDBTableBSGameModel]];
        for (BSGameModel *game in games) {
            if (game) {
                NSString *sql =[NSString stringWithFormat:kDBSqlBSGameModelUpdate, KDBTableBSGameModel];
                success = [db executeUpdate:sql,
                           game.objectId, //
                           game.aObjectId,
                           game.bObjectId,
                           game.startTime,
                           game.endTime,
                           game.aScore,
                           game.bScore,
                           game.aRankScore,  //
                           game.bRankScore,  //
                           @(game.isConfirmed),
                           @(game.gameType),
                           game.gameId];
            }
        }
    }];
    return success;
}


+ (BSGameModel *)gameWithObjectId:(NSString *)objectId {
    if (!objectId.length) return nil;
    
    __block BSGameModel  *model  = nil;
    [queue inDatabase:^(FMDatabase *db) {
        if (objectId.length) {
            NSString *querySql = [NSString stringWithFormat:kDBSqlSelectObject, KDBTableBSGameModel, objectId] ;
            FMResultSet *s = [db executeQuery:querySql];
            while(s.next) {
                model = [self gameModelWihtResult:s];
            }
            [s close];
        }
    }];
    return model;
}


+ (BSGameModel *)gameModelWihtResult:(FMResultSet *)s {
    BSGameModel  *model  =  [[BSGameModel alloc] init];
    model.objectId = [s stringForColumn:@"objectId"];
    model.aObjectId = [s stringForColumn:@"aObjectId"];
    model.bObjectId = [s stringForColumn:@"bObjectId"];
    model.startTime = [s stringForColumn:@"startTime"];
    model.endTime = [s stringForColumn:@"endTime"];
    model.aScore = [s stringForColumn:@"aScore"];
    model.bScore = [s stringForColumn:@"bScore"];
    model.aRankScore = [s stringForColumn:@"aRankScore"];
    model.bRankScore = [s stringForColumn:@"bRankScore"];
    model.isConfirmed = [s boolForColumn:@"rankLevel"];
    model.gameType = [s intForColumn:@"gameType"];
    model.gameId = [s stringForColumn:@"gameId"];
    return model;
}



+ (void)fetchMyGamesBlock:(BSArrayResultBlock)block {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableArray *gameModels = [NSMutableArray array];
        [queue inDatabase:^(FMDatabase *db) {
            NSString *querySql = [NSString stringWithFormat:kSqlSelect,KDBTableBSGameModel] ;
            FMResultSet *s = [db executeQuery:querySql];
            while (s.next) {
                BSGameModel *model = [self gameModelWihtResult:s];
                [gameModels addObject:model];
            }
            [s close];
        }];
        block(gameModels,nil);
    });
}



@end
