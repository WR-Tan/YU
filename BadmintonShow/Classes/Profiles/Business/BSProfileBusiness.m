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
#import "AFNetworking.h"

@implementation BSProfileBusiness

+ (void)saveUserObjectArr:(NSArray *)objArr keys:(NSArray *)keyArr block:(void (^)(id result, NSError *err))block {
    for (NSInteger i = 0; i < objArr.count; i++) {
        id object = objArr[i];
        NSString *key = keyArr[i];
        [[AVUser currentUser] setObject:object forKey:key];
    }
    [self saveUserInBackgroundWithBlock:block];
}


+ (void)saveUserObject:(id)object key:(NSString *)key block:(void (^)(id result, NSError *err))block {
    [[AVUser currentUser] setObject:object forKey:key];
    [self saveUserInBackgroundWithBlock:block];
}

+ (void)saveUserInBackgroundWithBlock:(void (^)(id result, NSError *err))block {
    [[AVUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {   // 保存成功
            block(nil,nil);
        } else {    //  保存失败
            block(nil,error);
        }
    }];
}

+ (void)getProflieMessageFromNet:(void (^)(BSProfileUserModel *profileUserMoel, NSError *err))block{
    [[AVUser currentUser] fetchInBackgroundWithKeys:@[@"genderStr",@"desc",@"username",@"nickname",@"avatar",@"school",@"company"] block:^(AVObject *object, NSError *error) {
        
        if (error) {
            block(nil,error);
            return ;
        }
        
        AVFile *avatar = object[AVPropertyAvatar] ;
        AVObject *school = object[AVPropertySchool] ;
        AVObject *company =object[AVPropertyCompany];
        
        NSString *schoolName = school[AVPropertyName] ? : @"";
        NSString *companyName = company[AVPropertyName] ? : @"";

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
                                   AVPropertySchool: schoolName,
                                   AVPropertyBirthDayStr : birthDayStr,
                                   AVPropertyCompany: companyName,
                                   AVPropertyDesc: object[AVPropertyDesc]?:@"",
                                   };
        [BSUserDefaultStorage setObject:userDict forKey:UserObjectIdKey(object.objectId)];
        BSProfileUserModel *profileUser = [BSProfileUserModel modelWithDictionary:userDict];
        if (profileUser) AppContext.user = profileUser;
        block(profileUser,nil);
    }];
}


+ (BSProfileUserModel *)getUserProflieFromUserDefault{
    NSString *objectId = [AVUser currentUser].objectId;
    NSDictionary *userDict = [BSUserDefaultStorage objectForKey:UserObjectIdKey(objectId)];
    return [BSProfileUserModel modelWithDictionary:userDict] ? : [BSProfileUserModel new];
}

+ (void)uploadAvatar:(UIImage *)image result:(void (^)(id object, NSError *err))result {
    AVFile *avatarFile = [AVFile fileWithData:UIImageJPEGRepresentation(image, 0.4)];
    [[AVUser currentUser] setObject:avatarFile forKey:AVPropertyAvatar];
    [[AVUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            result(image,nil);
        } else {
            result(nil,error);
        }
    }];
}

+ (void)queryCompanyInfoWithKey:(NSString *)key block:(void (^)(id, NSError *))block {
//    http://www.qixin007.com/search/?key=深圳平安科技&type=enterprise&source=&isGlobal=Y
//    只能查询几次，有毛用
    
//    NSString *host = @"http://www.qixin007.com/search/";
//    NSDictionary *paramters = @{@"key" : key?:@"",  @"type" : @"enterprise",
//                                @"source" : @"",      @"isGlobal" : @"Y"};
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager GET:host  parameters:paramters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *resString =  [[NSString alloc]initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
//        if (block) block(responseObject, nil);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        if (block) block(nil, error);
//    }];
}



@end
