//
//  NSFileManager+NSFileManagerx.m
//  MemoLite
//
//  Created by czh0766 on 12-1-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSFileManager+x.h"

@implementation NSFileManager (x)

+(NSString*) pathInDocuments:(NSString*)path {
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDirectory, YES);
    NSString* path0 = paths[0];
    return path ? [path0 stringByAppendingPathComponent:path] : path0;  
}

+(NSString *)pathInLibrary:(NSString *)path {
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDirectory, YES);
    NSString* path0 = paths[0];
    return path ? [path0 stringByAppendingPathComponent:path] : path0;  
}

+(NSString *)pathInLibraryCaches:(NSString *)path {
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDirectory, YES);
    NSString* path0 = paths[0];
    return path ? [path0 stringByAppendingPathComponent:path] : path0;
}

-(NSArray *)subpathsInDocuments:(NSString *)directory {
    NSArray* subfiles = [self subpathsAtPath:[NSFileManager pathInDocuments:directory]];
    NSMutableArray* subpaths = [NSMutableArray array];
    for (NSString* file in subfiles) {
        if (directory) {
            [subpaths addObject:[NSFileManager pathInDocuments:
                                 [NSString stringWithFormat:@"%@/%@", directory, file]]];
        } else {
            [subpaths addObject:[NSFileManager pathInDocuments:file]];
        }
        
    }
    return subpaths;
}

-(NSArray *)subpathsInLibrary:(NSString *)directory {
    NSArray* subfiles = [self subpathsAtPath:[NSFileManager pathInLibrary:directory]];
    NSMutableArray* subpaths = [NSMutableArray array];
    for (NSString* file in subfiles) {
        if (directory) {
            [subpaths addObject:[NSFileManager pathInLibrary:
                                 [NSString stringWithFormat:@"%@/%@", directory, file]]];
        } else {
            [subpaths addObject:[NSFileManager pathInLibrary:file]];
        }
    }
    return subpaths;
}

-(BOOL) deleteFileAtPath:(NSString*)path {
    return [self removeItemAtPath:path error:nil];
}

@end
