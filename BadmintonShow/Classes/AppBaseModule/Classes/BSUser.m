//
//  BSUser.m
//  BadmintonShow
//
//  Created by lizhihua on 12/17/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSUser.h"

@implementation BSUser

-(instancetype) initWithUserId:(NSString *) userId {
    NSAssert(userId, @"user id can't be nil");
    self = [super init];
    if (self) {
        _userId = userId;
        
    }
    return self;
}

@end
