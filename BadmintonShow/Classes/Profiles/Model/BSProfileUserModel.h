//
//  BSProfileUser.h
//  BadmintonShow
//
//  Created by lizhihua on 12/14/15.
//  Copyright © 2015 LZH. All rights reserved.
//


/**
 *  @author lizhihua, 15-12-20 16:12:01
 *  目前这个类比BSUserModel更多，BSUserModel将会被废弃
 */
#import <Foundation/Foundation.h>
#import "AVUser.h"

/// 认证方式
typedef NS_ENUM(NSUInteger, BSUserVerifyType){
    BSUserVerifyTypeNone = 0,     ///< 没有认证
    BSUserVerifyTypeStandard,     ///< 个人认证，黄V
    BSUserVerifyTypeOrganization, ///< 官方认证，蓝V
    BSUserVerifyTypeClub,         ///< 达人认证，红星
};


@interface BSProfileUserModel : NSObject

#define ShareInstance  [BSProfileUserModel instance]

+ (instancetype)instance;

@property (nonatomic, copy) NSString *objectId ;

//  Profile
@property (nonatomic, copy) NSString *avatarUrl;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *yuxiuId;
@property (nonatomic, copy) NSString *QRCode;
@property (nonatomic, copy) NSString *genderStr;

@property (nonatomic, assign) NSInteger mbLevel ;
@property (nonatomic, assign) NSInteger rankLevel ;
@property (nonatomic, assign) double score;
@property (nonatomic, assign) double winRate;
@property (nonatomic, assign) int gameCount;

//  Profile Edit
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) NSInteger weight;
@property (nonatomic, strong) NSDate *birthday;
@property (nonatomic, copy) NSString *birthdayStr;
@property (nonatomic, copy) NSString *nation; // 广东 深圳
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *disctrit;
//  Education
@property (nonatomic, copy) NSString *school;
@property (nonatomic, copy) NSString *accessSchoolTime; // e.g.  2015-10
//  Job
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *job;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, assign) BSUserVerifyType userVerifyType;




#pragma mark - RelationShip
///=====================================================
/// @name RelationShip
///=====================================================
@property (nonatomic, assign) BOOL isFollower;
@property (nonatomic, assign) BOOL isFollowee;
@property (nonatomic, assign) BOOL isFriend; // 这个定义目前代表（isFollower||isFollowee）

+ (instancetype)modelFromAVUser:(AVUser *)user;

@end
