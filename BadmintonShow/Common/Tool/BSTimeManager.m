
//
//  BSTimeManager.m
//  BadmintonShow
//
//  Created by lizhihua on 12/21/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSTimeManager.h"
#import "BSUserDefaultStorage.h"

@implementation BSTimeManager

/// 单例
+ (instancetype)manager {
    static BSTimeManager *_timeManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _timeManager = [[BSTimeManager alloc] init];
        _timeManager.lastSuccessRankRequestDate = [BSUserDefaultStorage objectForKey:UserDefaultKeyWithUsertId(kLastSuccessRankRequestDateKey)] ;
    });
    return _timeManager;
}



@end
