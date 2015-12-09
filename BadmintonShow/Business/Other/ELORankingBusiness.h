//
//  ELORankingBusiness.h
//  BadmintonShow
//
//  Created by LZH on 15/12/1.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELORankingBusiness : NSObject



/*  输入a排名分数，b排名分数
 *  @param Ra      : a的Rank分
 *  @param Rb      : b的Rank分
 *  @param isAWin  : a赢 ？
 */
+ (NSArray *)ELOArrayWithARankScore:(NSInteger)Ra bRankScore:(NSInteger)Rb  isAWin:(BOOL)isAWin ;

@end
