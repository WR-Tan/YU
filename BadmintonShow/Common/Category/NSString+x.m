//
//  NSString+NSStringx.m
//  iWeibo
//
//  Created by czh0766 on 12-2-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSData+x.h"
#import "NSNumber+x.h"
#import "UIKit+x.h"

#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (x)

+(NSString*) stringWithData:(NSData*)data {
    return [NSString stringWithData:data encoding:nil];
}

+(NSString*) stringWithData:(NSData*)data encoding:(NSString*)encoding {
    NSStringEncoding e;
    if (encoding == nil || [[encoding lowercaseString] isEqualToString:@"utf-8"]) {
        e = NSUTF8StringEncoding;
    } else {
        e = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingEUC_CN);
    }
    return [[NSString alloc] initWithData:data encoding:e];
}

+(NSString*) stringWithURLParams:(NSDictionary*)params {
    NSMutableString* mstr = [NSMutableString string];
    NSArray* keys = [params allKeys];
    for (int i = 0; i < keys.count; i++) {
        id key = keys[i];
        [mstr appendFormat:@"%@=%@", key, params[key]];
        if (i < keys.count - 1) {
            [mstr appendString:@"&"];
        }
    }
    return mstr;
}

+(NSString*) stringTimestamp {
    return [NSString stringWithFormat:@"%llu", (UInt64)[[NSDate date] timeIntervalSince1970]];
}

+(NSString*) stringRandom:(int)count {
    NSMutableString* mstr = [NSMutableString string];
    for (int i = 0; i < count; i++) {
        int a = 65 + 25 * RANDOM_0_1;
        [mstr appendFormat:@"%c", a];
    }
    return mstr;
}

+(NSString*) stringWithHMAC_SHA1:(NSString*)src key:(NSString*)key {
    unsigned char buf[CC_SHA1_DIGEST_LENGTH];
	CCHmac(kCCHmacAlgSHA1, [key UTF8String], [key length], [src UTF8String], [src length], buf);
	NSData* data = [NSData dataWithBytes:buf length:CC_SHA1_DIGEST_LENGTH];
    return [data base64EncodedString];
}

+(NSString*) stringWithHMAC_SHA1_2:(NSString*)src key:(NSString*)key {
    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [src cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSString *hash;
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", cHMAC[i]];
    hash = output;
    return hash;
}

+(NSString*) stringWithArray:(NSArray*)array separator:(NSString*)separator {
    NSMutableString* string = [NSMutableString string];
    for (int i = 0; i < array.count; i++) { 
        [string appendFormat:@"%@", array[i]];
        if (i != array.count - 1) {
            [string appendString:separator];
        }
    }
    return [NSString stringWithString:string];
}

+(NSString*) URLEncodedWtihDictionary:(NSDictionary*)dictionary {
    NSMutableString* string = [[NSMutableString alloc] init];
    NSArray* keys = dictionary.allKeys;
    for (int i = 0; i < keys.count; i++) {
        NSString* key = keys[i] ;
        NSString* value = dictionary[key];
        key = [key URLEncodedString];
        value = [value URLEncodedString];
        [string appendFormat:@"%@=%@", key, value];
        if (i < keys.count - 1) {
            [string appendString:@"&"];
        }
    }
    return [NSString stringWithString:string];
}

+(NSString*) stringWithFileSize:(UInt64)size {
    if (size < 1000) {
        return [NSString stringWithFormat:@"%lluB", size];
    } else if(size < 1000 * 1024){
        return [NSString stringWithFormat:@"%.2fKB", size / 1024.0];
    } else if(size < 1000 * 1024 * 1024){
        return [NSString stringWithFormat:@"%.2fMB", size / (1024.0 * 1024)];
    } else {
        return [NSString stringWithFormat:@"%.2fGB", size / (1024.0 * 1024 * 1024)];
    }
}

+(NSString *) stringFromArray:(NSArray *)array withDelimiter:(NSString *)delimiter {
    NSMutableString* str = [[NSMutableString alloc] init];
    for (int i = 0; i < array.count; i++) {
        NSString* s = array[i];
        [str appendString:s];
        if (i < array.count - 1) {
            [str appendString:delimiter];
        }
    }
    return str;
}

+(NSString*) stringWithUTF8ORGBKString:(const char *)cstring {
    NSString* str = @(cstring);
    if (!str) {
        str = [[NSString alloc] initWithBytes:cstring length:strlen(cstring)
                                                    encoding:NSGBKStringEncoding];
    }
    return str;
}

-(NSString*) stringWithRegex:(NSString*)regex rangeIndex:(int)index {
    NSRegularExpression* o_regex = [NSRegularExpression regularExpressionWithPattern:regex
                                                                             options:0 error:nil];
    NSTextCheckingResult* ret = [o_regex firstMatchInString:self options:0
                                                      range:NSMakeRange(0, self.length)];
    if (ret && ret.range.location != NSNotFound) {
        if (ret.numberOfRanges > 1) {
            return [self substringWithRange:[ret rangeAtIndex:index]];
        } else {
            return [self substringWithRange:ret.range];
        }
    }
    
    return nil;
}

-(NSString*) stringWithRegex:(NSString*)regex {
    return [self stringWithRegex:regex rangeIndex:1];
}

- (NSString *)URLEncodedString {
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(__bridge CFStringRef)self,NULL, CFSTR("%"), kCFStringEncodingUTF8));
	return result;
}

-(NSString*) URLDecodedString {
    
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,(__bridge CFStringRef)self,CFSTR("%"), kCFStringEncodingUTF8));
	return result;
    
//    char words[self.length+1];
//    int k = 0;
//    
//    for (int i = 0; i < self.length; i++, k++) {
//        unichar ch = [self characterAtIndex:i];
//        if (ch == '%') {
//            NSString* s = [self substringWithRange:NSMakeRange(i+1, 2)];
//            int n = [NSNumber numberWithHex:s].intValue;
//            if (n >= 128) {
//                n -= 256;
//            }
//            words[k] = n;
//            i += 2;
//        } else {
//            words[k] = ch;
//        }
//    }
//    
//    words[k] = 0;
//    
//    return [NSString stringWithUTF8String:words];
}

-(NSString*) substringFrom:(int)start to:(int)end {
    return [self substringWithRange:NSMakeRange(start, end - start)];
}

-(int) indexOf:(NSString*)str {
    NSRange range = [self rangeOfString:str];
    return range.location;
}

-(int) lastIndexOf:(NSString*)str {
    NSRange range = [self rangeOfString:str options:NSBackwardsSearch];
    return range.location;
}

-(int) wordsCount {
    int count = 0;
    bool ignored = NO;
    
    for (int i = 0; i < self.length; i++) {
        unichar ch = [self characterAtIndex:i];
        if((ch >= 65 && ch <= 90) || (ch >= 97 && ch <= 122) || (ch >= 48 && ch <= 57)) {
            if (!ignored) {
                count++;
                ignored = YES;
            }
        } else {
            count++;
            ignored = NO;
        }
    }
    return count;
}

-(NSString*) stringByReplacingHtmlEscape {
    
    NSMutableString* dst = [NSMutableString string];
    
    NSDictionary* escapes = @{@"&quot;": @"\"",
                             @"&amp;": @"&",
                             @"&lt;": @">",
                             @"&gt;": @"<"};
    
    for (int i = 0; i < self.length; i++) {
        NSString* ch = [self substringWithRange:NSMakeRange(i, 1)];
        
        BOOL meet_escape = NO;
        
        if ([ch isEqualToString:@"&"]) {
            
            for (NSString* escape in escapes.allKeys) {
                if (i + escape.length <= self.length && 
                    [[self substringWithRange:NSMakeRange(i, escape.length)] isEqualToString:escape]) {
                    [dst appendString:escapes[escape]];
                    i += escape.length - 1;
                    meet_escape = YES;
                    break;
                } 
            }
            
        }
        
        if (!meet_escape) {
            [dst appendString:ch];
        }
        
    }
    
    return dst;
}

-(NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

-(NSString*) extension {
    return [self stringWithRegex:@".+\\.(.+)"];
}

-(NSString*) filename {
    return [self stringWithRegex:@"(.*/)?(.+)" rangeIndex:2];
}

-(BOOL) hasPrefixCaseInsensitive:(NSString *)aString {
    NSRange prefixRange = [self rangeOfString:aString
                                            options:(NSAnchoredSearch | NSCaseInsensitiveSearch)];
    return prefixRange.location != NSNotFound;
}

-(BOOL) hasSuffixCaseInsensitive:(NSString *)aString {
    NSRange suffixRange = [self rangeOfString:aString
                                          options:(NSAnchoredSearch | NSCaseInsensitiveSearch | NSBackwardsSearch)];
    return suffixRange.location != NSNotFound;
}

@end
