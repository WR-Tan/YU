//
//  BSBaseBusiness.m
//  BadmintonShow
//
//  Created by lizhihua on 12/21/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSCommonBusiness.h"
#import "BSUserDefaultStorage.h"
#import "AVFile.h"

@implementation BSCommonBusiness

+ (void)fetchUserInBackground:(void (^)(BSProfileUserModel *profileUserMoel, NSError *err))block{
    [[AVUser currentUser] fetchInBackgroundWithKeys:@[@"genderStr",@"desc",@"username",@"nickname",@"avatar",@"school",@"company"] block:^(AVObject *object, NSError *error) {
        
        if (error) {
            block(nil,error);
            return ;
        }
        
        AVFile *avatar = object[AVPropertyAvatar] ;
        NSString *school = object[AVPropertySchool] ? : @"";;
        NSString *company =object[AVPropertyCompany] ? : @"";;
        
        
        NSString *birthDayStr = object[AVPropertyBirthDayStr] ? : @"";
        
        NSDictionary *userDict = @{
               @"objectId" : object.objectId ? : @"",
               @"userName" : [AVUser currentUser].username ? : @"",
               @"nickName" : object[AVPropertyNickName] ? : @"",
               @"avatarUrl": avatar.url ? : @"",
               AVPropertyNation: object[AVPropertyNation]?:@"",
               AVPropertyProvince: object[AVPropertyProvince]?:@"",
               AVPropertyCity: object[AVPropertyCity]?:@"",
               AVPropertyDisctrict: object[AVPropertyDisctrict]?:@"",
               AVPropertyGenderStr: object[AVPropertyGenderStr]?:@"",
               AVPropertySchool: school,
               AVPropertyBirthDayStr : birthDayStr,
               AVPropertyCompany: company,
               AVPropertyDesc: object[AVPropertyDesc]?:@"",
               AVPropertyYuXiuId: [object[AVPropertyYuXiuId] stringValue]?:@"",
               AVPropertyAccessSchoolTime:object[AVPropertyAccessSchoolTime]?:@"",
               AVPropertyScore:object[AVPropertyScore]};
        [BSUserDefaultStorage setObject:userDict forKey:UserObjectIdKey(object.objectId)];
        BSProfileUserModel *profileUser = [BSProfileUserModel modelWithDictionary:userDict];
        if (profileUser) AppContext.user = profileUser;
        block(profileUser,nil);
    }];
}


@end
