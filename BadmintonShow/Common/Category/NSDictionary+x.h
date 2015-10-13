//
//  NSDistionary+NSDistionaryx.h
//  MemoLite
//
//  Created by czh0766 on 12-1-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDictionary (x)

- (int)intForKey:(id)key;

- (int)floatForKey:(id)key;

- (int)boolForKey:(id)key;

- (id)objectForKey:(id)key defaults:(id)defValue;

- (int)intForKey:(id)key defaults:(int)defValue;

- (float)floatForKey:(id)key defaults:(float)defValue;

- (BOOL)boolForKey:(id)key defaults:(BOOL)defValue;

- (BOOL)containsKey:(id)key;

-(NSString*) toHttpQuery;

+ (id)dictionaryWithConfigString:(NSString*)config;

+ (id)dictionaryWithBundlePlist:(NSString*)plist;

@end

@interface NSMutableDictionary (NSMutableDictionaryx)

- (void)setInt:(int)value forKey:(id)aKey;

- (void)setFloat:(float)value forKey:(id)aKey;

- (void)setBool:(BOOL)value forKey:(id)aKey;

- (BOOL)writeToFile:(NSString *)path forKey:(NSString*)key;

+ (id)dictionaryWithContentsOfFile:(NSString *)path forKey:(NSString*)key;

+ (id)dictionaryWithString:(NSString*)str separator:(NSString*)sep;

@end
