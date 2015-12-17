//
//  BSUserDefaultStorage.m
//  BadmintonShow
//
//  Created by lizhihua on 12/17/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSUserDefaultStorage.h"



@implementation BSUserDefaultStorage

+ (void)setObject:(id)object forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)objectForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void)removeObjectForKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
