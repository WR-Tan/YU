//
//  BSProfileBusiness.m
//  BadmintonShow
//
//  Created by lizhihua on 12/16/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSProfileBusiness.h"
#import "BSUserModel.h"
#import "BSProfileUserModel.h"
#import "AVFile.h"
#import <AVUser.h>
#import "BSUserDefaultStorage.h"

@implementation BSProfileBusiness

+ (void)getProflieMessageFromNet:(void (^)(BSProfileUserModel *profileUserMoel, NSError *err))block{
    [[AVUser currentUser] fetchInBackgroundWithKeys:@[@"username",@"nickname",@"avatar"] block:^(AVObject *object, NSError *error) {
        
        AVFile *avatar = object[AVPropertyAvatar] ;
        
        NSDictionary *userDict = @{
                                   @"objectId" : object.objectId ? : @"",
                                   @"userName" : [AVUser currentUser].username ? : @"",
                                   @"nickName" : object[AVPropertyNickName] ? : @"",
                                   @"avatarUrl": avatar.url ? : @"",
                                   AVPropertyNation: object[AVPropertyNation]?:@"",
                                   AVPropertyProvince: object[AVPropertyProvince]?:@"",
                                   AVPropertyCity: object[AVPropertyCity]?:@"",
                                   AVPropertyGenderStr: object[AVPropertyGenderStr]?:@"",
                                   AVPropertySchool: object[AVPropertySchool]?:@"",
                                   AVPropertyCompany: object[AVPropertyCompany]?:@""
                                   
                                   };
        [BSUserDefaultStorage setObject:userDict forKey:UserObjectIdKey(object.objectId)];
        BSProfileUserModel *profileUser = [BSProfileUserModel modelWithDictionary:userDict];
        block(profileUser,nil);
    }];
}


+ (BSProfileUserModel *)getUserProflieFromUserDefault{
    NSString *objectId = [AVUser currentUser].objectId;
    NSDictionary *userDict = [BSUserDefaultStorage objectForKey:UserObjectIdKey(objectId)];
    return [BSProfileUserModel modelWithDictionary:userDict];
}

@end
