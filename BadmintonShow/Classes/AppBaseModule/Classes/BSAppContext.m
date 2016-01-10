//
//  BSAppContext.m
//  BadmintonShow
//
//  Created by lizhihua on 12/18/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSAppContext.h"
#import "BSProfileBusiness.h"

@implementation BSAppContext



+ (BSAppContext *)instance {
    static BSAppContext *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}


- (BSProfileUserModel *)user {
    if (!_user) {
        _user = [BSProfileUserModel  modelFromAVUser:[AVUser currentUser]];
//        _user = [BSProfileBusiness getUserProflieFromUserDefault];
    }
    return _user;
}

@end
