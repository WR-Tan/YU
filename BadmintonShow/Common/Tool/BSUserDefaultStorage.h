//
//  BSUserDefaultStorage.h
//  BadmintonShow
//
//  Created by lizhihua on 12/17/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AVUser.h"

#ifndef UserObjectIdKey
#define UserObjectIdKey(key)  [NSString stringWithFormat:@"_User_%@",(key)]
#endif

#ifndef UserDefaultKeyWithUsertId
#define UserDefaultKeyWithUsertId(key)  [NSString stringWithFormat:@"_User_%@_%@",([AVUser currentUser].objectId),(key)]
#endif



@interface BSUserDefaultStorage : NSObject

+ (void)setObject:(id)object forKey:(NSString *)key;

+ (id)objectForKey:(NSString *)key;

+ (void)removeObjectForKey:(NSString *)key;

@end
