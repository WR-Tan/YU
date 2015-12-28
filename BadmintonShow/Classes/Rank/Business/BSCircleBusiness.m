//
//  BSCircleBusiness.m
//  BadmintonShow
//
//  Created by lizhihua on 12/24/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSCircleBusiness.h"
#import "AVQuery.h"
#import "BSCircelModel.h"

@implementation BSCircleBusiness

+ (void)queryRecommendedCircleWithBlock:(BSArrayResultBlock)block {
    
    // query _User realtions to School
    
}

+ (void)queryCircleWithType:(NSString *)typeString block:(BSArrayResultBlock)block {
 
    static NSDictionary *dict;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dict = @{@"学校":@"school",
                 @"公司":@"company",
                 @"城市":@"city",
                 @"区域":@"disctrict",
                 @"小区":@"court",
                 @"球会":@"club",
                 @"其他":@"other" };
    });
    
    NSString *type = dict[typeString];
    
    AVQuery *query = [AVQuery queryWithClassName:AVClassCircle];
    [query whereKey:@"type" equalTo:type];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (error) {
            block(nil, error);
            return ;
        }
        
        NSMutableArray *arrM = [NSMutableArray array];
        for (AVObject *circle in objects) {
            BSCircelModel *model = [BSCircelModel modelWithAVObject:circle];
            [arrM addObject:model];
        }
        block(arrM, nil);
    }];
}



+ (NSDictionary *)circleCateogry {
    static NSDictionary *dict = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dict = @{@"公司":@"company",
                 @"学校":@"school",
                 @"城市":@"city",
                 @"区域":@"district",
                 @"小区":@"court",
                 @"球会":@"club",
                 @"其他":@"other"};
    });
    return dict;
}

+ (void)saveCircleWithName:(NSString *)name category:(NSString *)category isOpen:(BOOL)isOpen block:(BSBooleanResultBlock)block {
    AVObject *circle = [AVObject objectWithClassName:AVClassCircle];
    [circle setObject:name forKey:AVPropertyName];
    [circle setObject:category forKey:AVPropertyCategory];
    [circle setObject:@(isOpen) forKey:AVPropertyOpen];
    [circle saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
    }];
}



@end
