//
//  BSMatchModel.h
//  BadmintonShow
//
//  Created by mac on 15/10/17.
//  Copyright © 2015年 LZH. All rights reserved.

//  1/3/5局组成一场比赛。一般是3局比赛为一场
//  暂时不用吧

#import <Foundation/Foundation.h>
#import "BSGameModel.h"

typedef NS_ENUM(NSUInteger,BSMatchType){ // 比赛类型
    eBSMatchTypeThreeSetsMatch  = 1, // 一局制
    eBSMatchTypeOneSetMatch = 3, // 三局两胜制
};


@interface BSMatchModel : NSObject

@property (nonatomic, copy) NSString *beginTime ;
@property (nonatomic, copy) NSString *endTime ;

// 几局比赛-1、3，(局点-game point)，赛点-match point
@property (nonatomic, assign) NSUInteger gameCount ;
@property (nonatomic, assign) BSMatchType matchType ; // 比赛赛制

@property (nonatomic, strong) BSGameModel  *game1 ;
@property (nonatomic, copy) NSString *game1_objectId ;



@property (nonatomic, copy) NSString *winnerObjectId ;
@property (nonatomic, copy) NSString *winnerTeamObjectId ;

@end

/**
 *  一局制
 */
@interface BSOneSetMatch : BSMatchModel

@end

/**
 *  三局制
 */
@interface BSThreeSetsMatch : BSMatchModel

@property (nonatomic, strong) BSGameModel  *game2 ;
@property (nonatomic, copy) NSString *game2_objectId ;

@property (nonatomic, strong) BSGameModel  *game3 ;
@property (nonatomic, copy) NSString *game3_objectId ;
@end




