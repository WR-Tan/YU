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
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *street;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *district;
@property (nonatomic, strong) NSDate *createdAt;

+ (instancetype)modelWithAVObject:(AVObject *)object;

@end
