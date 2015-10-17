//
//  UserDefaultManager.h
//  BadmintonShow
//
//  Created by mac on 15/10/17.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultManager : NSObject

+ (void)saveAvatarImage:(UIImage *)image;

+ (UIImage *)avatar;

@end
