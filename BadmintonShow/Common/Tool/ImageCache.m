//
//  ImageCache.m
//  WriteNote
//
//  Created by wihing on 13-2-27.
//  Copyright (c) 2013年 wihing. All rights reserved.
//

#import "ImageCache.h"
#import "UIKit+x.h"

@interface ImageCache ()

@property (strong, nonatomic) NSMutableDictionary *cacheTable;

@end

@implementation ImageCache

+ (ImageCache *)sharedImageCache
{
    static ImageCache *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [ImageCache new];
    });
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        _cacheTable = [NSMutableDictionary new];
    }
    return self;
}

- (UIImage *)imageWithContentsOfFile:(NSString *)imagePath cache:(BOOL)cache
{
    UIImage *image = [_cacheTable objectForKey:imagePath];
    if (image == nil || cache == NO) {
        image = [UIImage imageWithContentsOfFile:imagePath];
        [_cacheTable setObject:image forKey:imagePath];
    }
    return image;
}

- (void)clearCache
{
    [self.cacheTable removeAllObjects];
}

@end
