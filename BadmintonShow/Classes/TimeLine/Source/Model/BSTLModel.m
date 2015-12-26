

//
//  BSTLModel.m
//  BadmintonShow
//
//  Created by lizhihua on 12/25/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSTLModel.h"

@implementation BSTLModel

+ (BSTLModel *)modelWithAVObject:(AVObject *)object{
    BSTLModel *model = [[BSTLModel alloc] init];
    model.objectId = object.objectId;
    model.createdAt = object.createdAt;
    model.updatedAt = object.updatedAt;
    
    NSDictionary *dict = object[@"localData"];
    model.user = [BSProfileUserModel modelFromAVUser: dict[@"user"]];
    
    model.text = dict[@"text"];
    model.attitudesCount = [(NSNumber *)dict[@"attitudes_count"] unsignedIntegerValue];
    model.commentsCount = [(NSNumber *)dict[@"comments_count"] unsignedIntegerValue];
    model.pics = dict[@"pics"];
    
    return model;
}

@end
