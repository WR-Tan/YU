//
//  BSCircleBusiness.h
//  BadmintonShow
//
//  Created by lizhihua on 12/24/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BSCircleModel;

@interface BSCircleBusiness : NSObject

// 查询用户加入的圈子：公开圈+私密圈
+ (void)queryMyCirclesWithBlock:(BSArrayResultBlock)block;

+ (void)queryCircleWithType:(NSString *)typeString  block:(BSArrayResultBlock)block;

+ (NSDictionary *)circleCateogry;

//  查询对应名称的Circle是否存在
+ (void)queryIfCircleExistsWithName:(NSString *)name block:(BSBooleanResultBlock)block ;
    
+ (void)saveCircleWithName:(NSString *)name category:(NSString *)type desc:(NSString *)desc isOpen:(BOOL)isOpen avatar:(UIImage *)avatar block:(BSIdResultBlock)block ;

+ (void)saveCircleAvatarWithId:(NSString *)objectId image:(UIImage *)image block:(BSIdResultBlock)block;

+ (void)queryCircleWithCategory:(NSString *)category isOpen:(BOOL)isOpen limit:(NSInteger)limit skip:(NSInteger)skip block:(BSArrayResultBlock)block ;

//  获取Circle的User，和圈子的人数。
+ (void)fetchUserInBackgroundWithCircle:(BSCircleModel *)circle block:(BSIdResultBlock)block;

//  获取Circle详细信息
+ (void)updateCircleInBackgroundWithCircle:(BSCircleModel *)circle block:(BSIdResultBlock)block;


+ (void)fetchUser:(NSString *)objectId block:(BSIdResultBlock)block;

+ (void)queryPlayerCountWithCircleId:(NSString *)objectId block:(BSIdResultBlock)block;

+ (void)queryIfJionCertainCircle:(BSCircleModel *)circle block:(BSBooleanResultBlock)block;

//  eg: 查询是否加入某个“公司/学校”圈子
+ (void)queryIfJionCategoryCircle:(NSString *)category block:(BSBooleanResultBlock)block ;

+ (void)jionCircel:(BSCircleModel *)circle object:(BSBooleanResultBlock)block;

/// 查询圈子，使用circleId，或者name
+ (void)queryCircleWIthNameOrId:(NSString *)nameOrId block:(BSArrayResultBlock)block;
 
// 退出群（其他人创建的）
+ (void)quitCircle:(BSCircleModel *)circle block:(BSBooleanResultBlock)block;

//  添加成员（好友）入群
+ (void)addUser:(AVUser *)user toCircle:(BSCircleModel *)circle block:(BSBooleanResultBlock)block;

@end

