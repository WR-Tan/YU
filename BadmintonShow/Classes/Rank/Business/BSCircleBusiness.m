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





@end
