//
//  NSMutableArray+NSMutableArrayx.h
//  MemoLite
//
//  Created by czh0766 on 11-10-29.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (x)

-(BOOL) writeToFile:(NSString *)path forKey:(NSString*)key;

-(BOOL) isEmpty;

-(id) firstObject;

-(BOOL) containsObjectWithBlock:(BOOL (^)(id))block;

-(NSArray*) subarrayWithBlock:(BOOL (^)(id))block;

-(NSArray*) arrayGenWithBlock:(id (^)(id))block;

@end

@interface NSMutableArray (x)

-(void) removeObjectsWithCondition:(BOOL (^)(id))condition;

-(void) removeFirstObject;

+(id) arrayWithContentsOfFile:(NSString *)path forKey:(NSString*)key;

@end
