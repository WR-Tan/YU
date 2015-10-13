//
//  NSString+NSStringx.h
//  iWeibo
//
//  Created by czh0766 on 12-2-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (x)

+(NSString*) stringWithData:(NSData*)data;

+(NSString*) stringWithData:(NSData*)data encoding:(NSString*)encoding;

+(NSString*) stringWithURLParams:(NSDictionary*)params;

+(NSString*) stringTimestamp;

+(NSString*) stringRandom:(int)count;

+(NSString*) stringWithHMAC_SHA1:(NSString*)src key:(NSString*)key;

+(NSString*) stringWithHMAC_SHA1_2:(NSString*)src key:(NSString*)key;

+(NSString*) stringWithArray:(NSArray*)array separator:(NSString*)separator;

+(NSString*) URLEncodedWtihDictionary:(NSDictionary*)dictionary;

+(NSString*) stringWithFileSize:(UInt64)size;

+(NSString*) stringFromArray:(NSArray *)array withDelimiter:(NSString *)delimiter;

+(NSString*) stringWithUTF8ORGBKString:(const char *)cstring;

-(NSString*) stringWithRegex:(NSString*)regex;

-(NSString*) stringWithRegex:(NSString*)regex rangeIndex:(int)index;

-(NSString*) URLEncodedString;

-(NSString*) URLDecodedString;

-(NSString*) substringFrom:(int)start to:(int)end;

-(int) indexOf:(NSString*)str;

-(int) lastIndexOf:(NSString*)str;

-(int) wordsCount;

-(NSString*) stringByReplacingHtmlEscape;

-(NSString*) trim;

-(NSString*) extension;

-(NSString*) filename;

-(BOOL) hasPrefixCaseInsensitive:(NSString *)aString;

-(BOOL) hasSuffixCaseInsensitive:(NSString *)aString;

@end
