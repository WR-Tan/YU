//
//  BSProfileUser.m
//  BadmintonShow
//
//  Created by lizhihua on 12/14/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSProfileUserModel.h"

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

@end
