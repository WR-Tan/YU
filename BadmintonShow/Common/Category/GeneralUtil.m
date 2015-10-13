//
//  GeneralUtil.m
//  iThunder
//
//  Created by wihing on 12-9-24.
//  Copyright (c) 2012年 czh0766. All rights reserved.
//

#import "GeneralUtil.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation GeneralUtil

+ (NSString *)sizeStringOfSizeInBytes:(int64_t)sizeInBytes
{
    int64_t B = 1;
    int64_t KB = 1024;
    int64_t MB = 1024 * 1024;
    int64_t GB = 1024 * 1024 * 1024;
    int64_t TB = 1024 * 1024 * 1024 * (int64_t)1024;
    if (sizeInBytes >= TB)
        return [NSString stringWithFormat:@"%.2fTB", (double)sizeInBytes / TB];
    if (sizeInBytes >= GB)
        return [NSString stringWithFormat:@"%.2fGB", (double)sizeInBytes / GB];
    if (sizeInBytes >= MB)
        return [NSString stringWithFormat:@"%.2fMB", (double)sizeInBytes / MB];
    if (sizeInBytes >= KB)
        return [NSString stringWithFormat:@"%.2fKB", (double)sizeInBytes / KB];
    if (sizeInBytes >= B)
        return [NSString stringWithFormat:@"%.2fB", (double)sizeInBytes / B];
    if (sizeInBytes == 0)
        return @"0B";
    return @"";
}

+ (UInt64)freeDiskSpaceSize {
    float freeSpace = 0.0f;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
	
    if (dictionary)
	{
        NSNumber *fileSystemSizeInBytes = dictionary[NSFileSystemFreeSize];
        freeSpace = [fileSystemSizeInBytes floatValue];
    }
	return freeSpace;
}

+ (void)playSound:(NSString*)soundName {
       
//    NSURL* sound_url = [[NSBundle mainBundle] URLForResource:soundName withExtension:nil];
//    
//    CFURLRef        soundFileURLRef;
//    SystemSoundID   soundFileObject;
//    soundFileURLRef = (__bridge CFURLRef)sound_url;
//    AudioServicesCreateSystemSoundID (soundFileURLRef,
//                                      &soundFileObject);
//    AudioServicesPlaySystemSound (soundFileObject);
}

+ (CGFloat)screenHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}

+(NSString*) bundleVersion {
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"];
}

@end
