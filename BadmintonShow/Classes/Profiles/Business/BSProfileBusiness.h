//
//  BSProfileBusiness.h
//  BadmintonShow
//
//  Created by lizhihua on 12/16/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BSProfileUserModel;

@interface BSProfileBusiness : NSObject

+ (void)saveUserObjectArr:(NSArray *)objArr keys:(NSArray *)keyArr block:(void (^)(id result, NSError *err))block ;

+ (void)saveUserObject:(id)object key:(NSString *)key block:(void (^)(id result, NSError *err))block ;
    
+ (void)saveUserInBackgroundWithBlock:(void (^)(id object, NSError *err))block;

+ (void)getProflieMessageFromNet:(void (^)(BSProfileUserModel *profileUserMoel, NSError *err))block;

+ (BSProfileUserModel *)getUserProflieFromUserDefault;

/**
 *  @author lizhihua, 15-12-19 21:12:4
 *  @brief 上传用户头像
 *  @param image  被上传的图片
 *  @param result 返回上传结果
 */
+ (void)uploadAvatar:(UIImage *)image result:(void (^)(id object, NSError *err))result;

/**
 *  @author lizhihua, 15-12-19 21:12:18
 *  @brief 查询公司信息
 */
+ (void)queryCompanyInfoWithKey:(NSString *)key block:(void (^)(id object, NSError *err))block;

+ (void)logOutWithBlock:(void (^)(id object, NSError *err))block;


+ (void)uploadFeedback:(NSString *)feedback block:(AVBooleanResultBlock)block;



@end
