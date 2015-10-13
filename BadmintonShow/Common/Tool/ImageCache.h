//
//  ImageCache.h
//  WriteNote
//
//  Created by wihing on 13-2-27.
//  Copyright (c) 2013年 wihing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageCache : NSObject

+ (ImageCache *)sharedImageCache;

- (UIImage *)imageWithContentsOfFile:(NSString *)imagePath cache:(BOOL)cache;
- (void)clearCache;

@end
