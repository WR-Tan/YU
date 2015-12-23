//
//  BSProfileUser.m
//  BadmintonShow
//
//  Created by lizhihua on 12/14/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSProfileUserModel.h"
#import "AVObject.h"
#import "AVFile.h"
#import "BSUserDefaultStorage.h"

@implementation BSProfileUserModel

+ (instancetype)instance {
    static BSProfileUserModel *_user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _user = [[BSProfileUserModel alloc] init];
    });
    return _user;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
         
    }
    return self;
}


+ (instancetype)modelFromAVUser:(AVUser *)user {

    AVFile *avatar = user[AVPropertyAvatar] ;
    AVObject *school = user[AVPropertySchool] ;
    AVObject *company = user[AVPropertyCompany];
    
    NSString *schoolName = school[AVPropertyName] ? : @"";
    NSString *companyName = company[AVPropertyName] ? : @"";
    
    NSString *birthDayStr = user[AVPropertyBirthDayStr] ? : @"";
    
    NSDictionary *userDict = @{
                               @"objectId" : user.objectId ? : @"",
                               @"userName" : user.username ? : @"",
                               @"nickName" : user[AVPropertyNickName] ? : @"",
                               @"avatarUrl": avatar.url ? : @"",
                               AVPropertyNation: user[AVPropertyNation]?:@"",
                               AVPropertyProvince: user[AVPropertyProvince]?:@"",
                               AVPropertyCity: user[AVPropertyCity]?:@"",
                               AVPropertyDisctrict: user[AVPropertyDisctrict]?:@"",
                               AVPropertyGenderStr: user[AVPropertyGenderStr]?:@"",
                               AVPropertySchool: schoolName,
                               AVPropertyBirthDayStr : birthDayStr,
                               AVPropertyCompany: companyName,
                               AVPropertyDesc: user[AVPropertyDesc]?:@"",
                               AVPropertyScore: user[AVPropertyScore]?:@"",
                               AVPropertyIsFollowee: user[AVPropertyIsFollowee]?:@(NO),
                               AVPropertyIsFollower: user[AVPropertyIsFollower]?:@(NO),
                               AVPropertyIsFriend: user[AVPropertyIsFriend]?:@(NO)
                               };
    BSProfileUserModel *profileUser = [BSProfileUserModel modelWithDictionary:userDict];
    
    return  profileUser;
}

@end
