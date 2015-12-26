//
//  BSCircelModel.m
//  BadmintonShow
//
//  Created by lizhihua on 12/25/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSCircelModel.h"
#import "BSProfileUserModel.h"

@implementation BSCircelModel

+ (instancetype)modelWithAVObject:(AVObject *)object {
    BSCircelModel *model = [[BSCircelModel alloc] init];
    model.objectId = object.objectId;
    model.createdAt = object.createdAt;
    
    NSDictionary *dict = object[@"localData"];
    model.type = dict[AVPropertyType]?:@"";
    model.name = dict[AVPropertyName]?:@"";
    model.desc = object[AVPropertyDesc]?:@"";
    
    AVUser *user = object[AVPropertyCreator];
    model.creator = [BSProfileUserModel modelFromAVUser:user];
    model.city = object[AVPropertyCity];
    return model;
}

@end
