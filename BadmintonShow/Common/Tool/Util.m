//
//  Util.m
//  BookKeeping
//
//  Created by wihing on 12-6-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Util.h"
//#import "SettingHelper.h"
//#import <AudioToolbox/AudioToolbox.h>

@implementation Util

+ (NSString *)formatDoubleToString:(double)number
{
    NSString *result = [NSString stringWithFormat:@"%.2f", number];
    const char *doubleChars = [result UTF8String];
    NSUInteger length = [result length];
    NSUInteger zeroLength = 0;
    for (int i = length - 1; i >= 0; i--) {
        if (doubleChars[i] == '0') {
            zeroLength++;
        } else {
            if (doubleChars[i] == '.')
                zeroLength++;
            break;
        }
    }
    result = [result substringToIndex:length-zeroLength];
    return result;
}

+ (CGFloat)degreesToRadians:(CGFloat)degrees 
{
    return degrees * M_PI / 180;
}

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
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        freeSpace = [fileSystemSizeInBytes floatValue];
    }
	return freeSpace;
}

+ (CGFloat)screenHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}

+ (NSString*)bundleVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}


+ (void)playSound:(NSString *)soundName withExtension:(NSString *)extension
{/*
    NSURL *tapSound;
    tapSound = [[NSBundle mainBundle] URLForResource: soundName
                                       withExtension: extension];
    
    CFURLRef        soundFileURLRef;
    SystemSoundID   soundFileObject;
    // Store the URL as a CFURLRef instance
    soundFileURLRef = (__bridge CFURLRef)tapSound;
    
    // Create a system sound object representing the sound file.
    AudioServicesCreateSystemSoundID (soundFileURLRef,
                                      &soundFileObject);
    AudioServicesPlaySystemSound (soundFileObject);*/
}

+ (void)playSlashSound
{/*
    if ([SettingHelper sharedSettingHelper].extraSound)
        [Util playSound:@"toybrick" withExtension:@"wav"];*/
}

+ (void)playClickSound
{/*
    if ([SettingHelper sharedSettingHelper].extraSound)
        [Util playSound:@"toybrick" withExtension:@"wav"];*/
}

+ (void)playPushSound
{/*
    if ([SettingHelper sharedSettingHelper].enableSound)
        [Util playSound:@"lock" withExtension:@"caf"];*/
}

+ (void)playPopSound
{/*
    if ([SettingHelper sharedSettingHelper].enableSound)
        [Util playSound:@"unlock" withExtension:@"caf"];*/
}

+ (NSString *)GUIDString
{
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return CFBridgingRelease(string);
}

+ (BOOL)iPhone
{
    return UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad;
}

@end
