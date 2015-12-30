//
//  BSCircelModel.h
//  BadmintonShow
//
//  Created by lizhihua on 12/25/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSProfileUserModel.h"

@interface BSCircelModel : NSObject

@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) BSProfileUserModel *creator;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, strong) NSURL *avatarUrl; //
@property (nonatomic, strong) NSString *type; //
@property (nonatomic, strong) NSString *category; //
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *street;
@property (nonatomic, strong) NSString *circleId;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *district;
@property (nonatomic, strong) NSString *address; // 暂时为空
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, assign) NSUInteger peopleCount; // 人数

+ (instancetype)modelWithAVObject:(AVObject *)object;

@end
