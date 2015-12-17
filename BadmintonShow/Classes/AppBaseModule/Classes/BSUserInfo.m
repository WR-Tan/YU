//
//  BSUserInfo.m
//  BadmintonShow
//
//  Created by lizhihua on 12/17/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSUserInfo.h"
#import <objc/runtime.h>
#import "BSUser.h"

@interface BSUserInfo () {
    __weak BSUser *_user;
}
@end

@implementation BSUserInfo
-(instancetype) initWithUser:(__weak BSUser *) user {
    self = [super init];
    if (self) {
        _user = user;
    }
    return self;
}
@end

#define kBSUserInfoKey @"kBSUserInfoKey"
@implementation BSUser (UserInfo)

-(BSUserInfo *)info {
    BSUserInfo *info = objc_getAssociatedObject(self, kBSUserInfoKey);
    if (!info) {
        info = [[BSUserInfo alloc] initWithUser:self];
        objc_setAssociatedObject(self, kBSUserInfoKey, info, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return info;
}
@end

