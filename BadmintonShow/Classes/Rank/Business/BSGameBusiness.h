//
//  BSGameBusiness.h
//  BadmintonShow
//
//  Created by LZH on 15/11/18.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AVObject ;
@class BSGameModel ;

@interface BSGameBusiness : NSObject

+ (AVObject *)AVObjectWithGameModel:(BSGameModel *)game;

+ (NSInteger)BMTGameTypeFromUserDefault;

+ (void)setBMTGameTypeToUserDefault:(NSInteger)gameType;

+ (void)queryGameFromNetWithBlock:(BSArrayResultBlock)block;

+ (void)queryGameFromDBWithBlock:(BSArrayResultBlock)block;

@end
