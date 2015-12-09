//
//  BSGameModel.h
//  BadmintonShow
//
//  Created by mac on 15/10/17.
//  Copyright © 2015年 LZH. All rights reserved.


/**
 *   11/15/21分是一局比赛
 *   暂时还是要先做一场比赛的就行了。3场比赛中，如果赢一局输一局，然后第三局定胜负；
 *   其实也就是第三局定的胜负，算是打破比赛的常规吧。
 */


#import <Foundation/Foundation.h>



typedef NS_ENUM(NSUInteger,BSGameType){ // 比赛类型
    eBSGameTypeManSingle , //男单
    eBSGameTypeWomanSingle ,// 女单
    eBSGameTypeMenDouble , // 男双
    eBSGameTypeWomenDouble, //女双
    eBSGameTypeMixDouble // 混双
};



/**
 *  比赛模型,基类
 */
@interface BSGameModel : NSObject

//  默认A是赢者 ，OK  2015.10.18

@property (nonatomic, copy) NSString *playerA_score ;  //  玩家A的得分
@property (nonatomic, copy) NSString *playerB_score ;  //  玩家B的得分

@property (nonatomic, copy) NSString *playerA_platformScore ;  //  玩家A的平台分数
@property (nonatomic, copy) NSString *playerB_platformScore ;  //  玩家B的平台分数

@property (nonatomic, copy) NSString *aRankScore ;  //  玩家A的排名分数
@property (nonatomic, copy) NSString *bRankScore ;  //  玩家B的排名分数

@property (nonatomic, copy) NSString *playerA_avatar ;  //  玩家A的队头像
@property (nonatomic, copy) NSString *playerB_avatar ;  //  玩家B的队头像


@property (nonatomic, copy) NSString *objectId ; // 模型对应的AVOSCloud的objectId
@property (nonatomic, copy) NSString *gameId ; // 自己产生的比赛模型id （暂未实现）
@property (nonatomic, assign) BSGameType gameType ;  // 比赛的类型

@property (nonatomic, copy) NSString *playerA_name ; // 玩家A
@property (nonatomic, copy) NSString *playerB_name ; // 玩家B
@property (nonatomic, copy) NSString *playerA_objectId ;  //  玩家A的id
@property (nonatomic, copy) NSString *playerB_objectId ;  //  玩家B的id

@property (nonatomic, copy) NSString *winner_objectId ;
@property (nonatomic, assign) BOOL isAWin ;   // 是a赢了吗


@property (nonatomic, copy) NSString *startTime ; // 结束时间
@property (nonatomic, copy) NSString *endTime ;   // 开始时间

@property (nonatomic, assign) BOOL isConfirmed ;   // 已经确认

@property (nonatomic, strong) UIImage * aAVatar ;   // a的头像
@property (nonatomic, strong) UIImage * bAVatar ;   // b的头像

@end


#pragma mark - 单打

/**
 *  单打比赛模型
 */
@interface BSSingleGameModel : BSGameModel

@end


/**
 *  男单，比赛模型
 */
@interface BSManSingleGameModel : BSSingleGameModel

@end


/**
 *  女单，比赛模型
 */
@interface BSWomanSingleGameModel : BSSingleGameModel

@end

#pragma mark - 双打

/**
 *  双打比赛模型
 */
@interface BSDoubleGameModel : BSGameModel


@property (nonatomic, copy) NSString *teamA_score ;  //  A队的得分
@property (nonatomic, copy) NSString *teamB_score ;  //  B队的得分

@property (nonatomic, copy) NSString *playerC_avatar ;  //  玩家A的队头像
@property (nonatomic, copy) NSString *playerD_avatar ;  //  玩家B的队头像

@property (nonatomic, copy) NSString *teamA_avatar ;  //  玩家A的队头像
@property (nonatomic, copy) NSString *teamB_avatar ;  //  玩家A的队头像

@property (nonatomic, copy) NSString *winnerTeam_objectId ;
@property (nonatomic, copy) NSString *winnerTeamName ;

@property (nonatomic, copy) NSString *teamA_objectId ;
@property (nonatomic, copy) NSString *teamB_objectId ;

@property (nonatomic, copy) NSString *playerC_name ; // 玩家C
@property (nonatomic, copy) NSString *playerC_objectId ;  //  玩家C的id

@property (nonatomic, copy) NSString *playerD_name ; // 玩家D
@property (nonatomic, copy) NSString *playerD_objectId ;  //  玩家D的id

@end


/**
 *  男双，比赛模型
 */
@interface BSMenDoubleGameModel : BSDoubleGameModel

@end


/**
 *  男双，比赛模型
 */
@interface BSWomenDoubleGameModel : BSDoubleGameModel

@end




@interface BSGameModel()
@end


