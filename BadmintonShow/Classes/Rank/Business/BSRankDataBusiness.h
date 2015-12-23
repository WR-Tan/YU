//
//  BSRankDataBusiness.h
//  BadmintonShow
//
//  Created by lizhihua on 12/21/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSRankDataBusiness : NSObject


#pragma mark - 好友排名

+ (void)queryFriendRankDataWithBlock:(BSArrayResultBlock)block;




#pragma mark - 羽秀天梯排名

+ (void)queryRankUserDataWithBlock:(BSArrayResultBlock)block;

+ (BOOL)saveRankUsers:(NSArray *)users;

+ (void)queryAllRankUserWithBlock:(BSArrayResultBlock)block ;

@end
