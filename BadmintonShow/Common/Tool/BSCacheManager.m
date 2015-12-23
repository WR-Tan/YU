
//
//  BSCacheManager.m
//  BadmintonShow
//
//  Created by lizhihua on 12/21/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSCacheManager.h"
#import "BSDBManager.h"

@interface BSCacheManager ()
@property (nonatomic, strong) NSCache *userCache;
@end


@implementation BSCacheManager

/// 单例
+ (instancetype)manager {
    static BSCacheManager *_cacheManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _cacheManager = [[BSCacheManager alloc] init];
    });
    return _cacheManager;
}


+ (BSProfileUserModel *)userCacheWithID:(NSString *)objectId {
    //  先从缓存获取
    BSProfileUserModel *user = [AppCacheManager.userCache objectForKey:objectId];
    if (!user) { // 没有再从数据库获取
        user = [BSDBManager userWithObjectId:objectId];
        [self cacheUser:user];
    }
    return user;
}

+ (void)cacheUser:(BSProfileUserModel *)user {
    [AppCacheManager.userCache setObject:user forKey:user.objectId];
}


//  取出缓存的用户
+ (BSGameModel *)gameCacheWithID:(NSString *)objectId {
    return nil;
}
//  缓存用户
+ (void)cacheGame:(BSGameModel *)game {
    
}



#pragma mark 懒加载
- (NSCache *)userCache {
    if (!_userCache) {
        _userCache = [[NSCache alloc] init];
    }
    return _userCache;
}




@end
