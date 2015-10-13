//
//  NSDistionary+NSDistionaryx.m
//  MemoLite
//
//  Created by czh0766 on 12-1-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSDictionary+x.h"
#import "NSFileManager+x.h"
#import "NSString+x.h"

@implementation NSDictionary (x)

- (int)intForKey:(id)key {
    return [self[key] intValue];
}

- (int)floatForKey:(id)key {
    return [self[key] floatValue];
}

- (int)boolForKey:(id)key {
    return [self[key] boolValue];
}

- (id)objectForKey:(id)key defaults:(id)defValue {
    id obj = self[key];
    return obj ? obj : defValue;
}

- (int)intForKey:(id)key defaults:(int)defValue {
    id obj = self[key];
    return obj ? [obj intValue] : defValue;
}

- (float)floatForKey:(id)key defaults:(float)defValue {
    id obj = self[key];
    return obj ? [obj floatValue] : defValue;
}

- (BOOL)boolForKey:(id)key defaults:(BOOL)defValue {
    id obj = self[key];
    return obj ? [obj boolValue] : defValue;
}

- (BOOL)containsKey:(id)key {
    return [self.allKeys containsObject:key];
}

-(NSString*) toHttpQuery {
    NSArray* keys = [self allKeys];
    
    if (keys.count <= 0) {
        return nil;
    }
    
    NSMutableString* query_s = [NSMutableString string];
    for (int i = 0; i < keys.count; i++) {
        id key = keys[i];
        id value = self[key];
        if ([value isKindOfClass:[NSString class]]) {
            NSString* s_value = (NSString*)value;
            value = [s_value URLEncodedString];
        }
        [query_s appendFormat:@"%@=%@", key, value];
        if (i != keys.count - 1) {
            [query_s appendString:@"&"];
        }
    }
    
    return query_s;
}

+(id)dictionaryWithConfigString:(NSString *)config {
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    NSArray* pairs = [config componentsSeparatedByString:@"\n"];
    for (NSString* pair in pairs) {
        NSArray* tuples = [pair componentsSeparatedByString:@":"];
        if (tuples.count == 2) {
            NSString* key = [tuples[0] trim];
            NSString* value = [tuples[1] trim];
            dict[key] = value;
        }
    }
    return dict;
}

+ (id)dictionaryWithBundlePlist:(NSString*)plist {
    NSString* filepath = [[NSBundle mainBundle] pathForResource:plist ofType:@"plist"];
    return [self dictionaryWithContentsOfFile:filepath];
}

@end

@implementation NSMutableDictionary (NSMutableDictionaryx)

- (void)setInt:(int)value forKey:(id)aKey {
    self[aKey] = @(value);
}

- (void)setFloat:(float)value forKey:(id)aKey {
    self[aKey] = @(value);
}

- (void)setBool:(BOOL)value forKey:(id)aKey {
    self[aKey] = @(value);
}

- (BOOL)writeToFile:(NSString *)path forKey:(NSString*)key {
    NSMutableData* data = [NSMutableData data]; 
    NSKeyedArchiver* archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self forKey:key];
    [archiver finishEncoding];
    //NSString* path2 = [NSFileManager pathInDocuments:path];
    return [data writeToFile:path atomically:YES];
}

+ (id)dictionaryWithContentsOfFile:(NSString *)path forKey:(NSString*)key {
    //NSString* path2 = [NSFileManager pathInDocuments:path];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    id dictionary = [unarchiver decodeObjectForKey:key];
    [unarchiver finishDecoding];
    return dictionary ? dictionary : [NSMutableDictionary dictionary];
}

+ (id)dictionaryWithString:(NSString*)str separator:(NSString*)sep {
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    NSArray* pairs = [str componentsSeparatedByString:sep];
    for (NSString* pair in pairs) {
        NSArray* tuples = [pair componentsSeparatedByString:@"="];
        if (tuples.count == 2) {
            NSString* key = tuples[0];
            NSString* value = tuples[1];
            dict[key] = value;
        }
    }
    return dict;
}

@end






