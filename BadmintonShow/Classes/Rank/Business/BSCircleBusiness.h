//
//  BSCircleBusiness.h
//  BadmintonShow
//
//  Created by lizhihua on 12/24/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BSCircelModel;

@interface BSCircleBusiness : NSObject


+ (void)queryRecommendedCircleWithBlock:(BSArrayResultBlock)block;

+ (void)queryCircleWithType:(NSString *)typeString  block:(BSArrayResultBlock)block;

+ (NSDictionary *)circleCateogry;

+ (void)saveCircleWithName:(NSString *)name category:(NSString *)category isOpen:(BOOL)isOpen block:(BSIdResultBlock)block ;

+ (void)queryCircleWithCategory:(NSString *)category isOpen:(BOOL)isOpen block:(BSArrayResultBlock)block ;

//  获取Circle的User，和圈子的人数。
+ (void)fetchUserInBackgroundWithCircle:(BSCircelModel *)circle block:(BSIdResultBlock)block;

+ (void)fetchUser:(NSString *)objectId block:(BSIdResultBlock)block;

+ (void)queryPlayerCountWithCircleId:(NSString *)objectId block:(BSIdResultBlock)block;

+ (void)queryIfJionCertainCircle:(BSCircelModel *)circle block:(BSBooleanResultBlock)block;

//  eg: 查询是否加入某个“公司/学校”圈子
+ (void)queryIfJionCategoryCircle:(NSString *)category block:(BSBooleanResultBlock)block ;

+ (void)jionCircel:(BSCircelModel *)circle object:(BSBooleanResultBlock)block;

@end

