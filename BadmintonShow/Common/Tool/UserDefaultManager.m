//
//  UserDefaultManager.m
//  BadmintonShow
//
//  Created by mac on 15/10/17.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import "UserDefaultManager.h"

@implementation UserDefaultManager

+ (void)saveAvatarImage:(UIImage *)image
{
    NSData *data = UIImagePNGRepresentation(image);
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"avatar"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    ;
}

+ (UIImage *)avatar{
    
    NSData *data  = [[NSUserDefaults standardUserDefaults] objectForKey:@"avatar"];
    UIImage *avatar = [[UIImage  alloc ] initWithData:data ];
    return avatar;
}




@end
