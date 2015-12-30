//
//  BSCircleBusiness.m
//  BadmintonShow
//
//  Created by lizhihua on 12/24/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSCircleBusiness.h"
#import "AVQuery.h"
#import "AVRelation.h"
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

+ (void)queryCircleWithCategory:(NSString *)category isOpen:(BOOL)isOpen block:(BSArrayResultBlock)block {
    NSDictionary *dict = [self circleCateogry];
    NSString *categoryKey = dict[category] ? : nil;
    
    NSError *error = [[NSError alloc] initWithDomain:@"xxx" code:200 userInfo:@{@"userInfo":@"doesn't match any category"}];
    if (!categoryKey) {
        block(nil,error);
        return;
    }
    
    AVQuery *query = [AVQuery queryWithClassName:AVClassCircle];
    [query whereKey:AVPropertyType equalTo:categoryKey];
    [query whereKey:AVPropertyOpen equalTo:@(isOpen)];
//    [query includeKey:@"avatar"];
    query.limit = 20;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
       
        if (error) {
            block(nil,error);
            return ;
        }
        
        NSMutableArray *circleArrM = [NSMutableArray array];
        for (AVObject *circleObject in objects) {
            BSCircelModel *model = [BSCircelModel modelWithAVObject:circleObject];
            [circleArrM addObject:model];
        }
        block(circleArrM,nil);
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

+ (void)saveCircleWithName:(NSString *)name category:(NSString *)category isOpen:(BOOL)isOpen block:(BSIdResultBlock)block {
    AVObject *circle = [AVObject objectWithClassName:AVClassCircle];
    [circle setObject:name forKey:AVPropertyName];
    [circle setObject:category forKey:AVPropertyCategory];
    [circle setObject:@(isOpen) forKey:AVPropertyOpen];
    [circle saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        // generate a circleModel
        if (succeeded) {
            BSCircelModel *model = [BSCircelModel modelWithAVObject:circle];
            block(model, nil);
        } else {
            block(nil, error);
        }
    }];
}


+ (void)fetchUserInBackgroundWithCircle:(BSCircelModel *)circle block:(BSIdResultBlock)block{
    [BSCircleBusiness fetchUser:circle.creator.objectId block:^(id object, NSError *error) {
        
        if (error) {
            block(nil, error);
            return ;
        }
        circle.creator = (BSProfileUserModel *)object;
        
        [self queryPlayerCountWithCircleId:circle.objectId block:^(id number, NSError *err) {
            
            if (err) {
                block(nil, err);
                return ;
            }
            
            circle.peopleCount = [(NSNumber *)number integerValue];
            block(circle, nil);
        }];
        
        
    }];
}

+ (void)fetchUser:(NSString *)objectId block:(BSIdResultBlock)block {
    if (!objectId) return;
    AVUser *user = [AVUser user];
    user.objectId = objectId;
    [user fetchInBackgroundWithBlock:^(AVObject *object, NSError *error) {
       
        if (!error) {
            AVUser *userOjbect = (AVUser *)object;
            BSProfileUserModel *user = [BSProfileUserModel modelFromAVUser:userOjbect];
            block(user,nil);
            return ;
        }
        
        block(nil,error);
    }];
}

+ (void)queryPlayerCountWithCircleId:(NSString *)objectId block:(BSIdResultBlock)block{
    if (!objectId) return;
    

    AVRelation *relation = [[AVObject objectWithoutDataWithClassName:AVClassCircle objectId:objectId] relationforKey:@"players"] ;
    [[relation query]  countObjectsInBackgroundWithBlock:^(NSInteger number, NSError *error) {
        
        if (number == -1 || error) {
            block(nil,error);
            return;
        }
        block(@(number),nil);
    }];

}

+ (void)queryIfJionCertainCircle:(BSCircelModel *)circle block:(BSBooleanResultBlock)block {
    //  确定有没有在群中。
    AVRelation *relation = [[AVObject objectWithoutDataWithClassName:AVClassCircle objectId:circle.objectId] relationforKey:@"players"] ;
    AVQuery *playerQuery = [relation query];
    [playerQuery whereKey:AVPropertyObjectId equalTo:AppContext.user.objectId];
    [playerQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {  // 请求错误，没有找到
            block(NO,error);
        }
        if (objects.count) { // 请求成功，而且玩家已经在圈内了
            block(NO,nil);
            return ;
        }
        block(YES, nil); // 请求，并且玩家还没有加入圈内。
    }];
}


+ (void)queryIfJionCategoryCircle:(NSString *)category block:(BSBooleanResultBlock)block {
    if ([category isEqualToString:@"other"]) return;  // "其他"类型的公开圈支持同时多加
    AVRelation *relation = [[AVObject objectWithoutDataWithClassName:AVClassUser    objectId:AppContext.user.objectId] relationforKey:@"circles"] ;
    AVQuery *circleQuery = [relation query];
    [circleQuery whereKey:AVPropertyType equalTo:@"category"];
    [circleQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {  // 请求错误，没有找到
            block(NO,error);
        }
        if (objects.count) { // 请求成功，已经加入某个分类圈
            block(NO,nil);
            return ;
        }
        block(YES, nil); // 请求，并且玩家还没有加入对应的分类圈内。
    }];
}


+ (void)jionCircel:(BSCircelModel *)circle object:(BSBooleanResultBlock)block {
    
    AVRelation *relation = [[AVUser currentUser] relationforKey:@"circles"];
    AVObject *circleObj = [AVObject objectWithoutDataWithClassName:AVClassCircle objectId:circle.objectId];
    [relation addObject:circleObj];
    [[AVUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
       
        if (error) {
            block(NO, error);
        } else {
            block(YES, nil);
        }
    }];
}


@end
