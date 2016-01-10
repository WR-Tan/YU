//
//  BSCircleModel.m
//  BadmintonShow
//
//  Created by lizhihua on 12/25/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSCircleModel.h"
#import "BSProfileUserModel.h"
#import "AVFile.h"

@implementation BSCircleModel

+ (instancetype)modelWithAVObject:(AVObject *)object {
    BSCircleModel *model = [[BSCircleModel alloc] init];
    NSDictionary *dict = object[@"localData"];
    AVUser *user = object[AVPropertyCreator];
    AVFile *avatar = object[AVPropertyAvatar];

    
    model.objectId = object.objectId;
    model.createdAt = object.createdAt;
    model.isOpen = [dict[AVPropertyOpen] boolValue] ?:NO;
    model.avatarUrl = [NSURL URLWithString:avatar.url];
    model.type = dict[AVPropertyType]?:@"";
    model.name = dict[AVPropertyName]?:@"";
    model.desc = object[AVPropertyDesc]?:@"";
    model.creator = [BSProfileUserModel modelFromAVUser:user];
    model.city = object[AVPropertyCity]?:@"";
    model.circleId = [object[AVPropertyCircleId] stringValue];
    model.street = object[AVPropertyStreet]?:@"";
    model.province = object[AVPropertyProvince]?:@"";
    model.district = object[AVPropertyDisctrict]?:@"";;
    model.peopleCount  = [object[AVPropertyPeopleCount] unsignedLongValue] ?:0; // 人数

    
    return model;
}

@end
