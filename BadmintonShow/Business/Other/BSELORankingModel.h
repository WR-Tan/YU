//
//  BSELORankingModel.h
//  BadmintonShow
//
//  Created by LZH on 15/12/1.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSELORankingModel : NSObject


@property (nonatomic, assign) CGFloat aRankScore;  // a 的分数
@property (nonatomic, assign) CGFloat bRankScore;  // b 的分数


/*
 float Sa = 1;
 float Sb = 1 - Sa ;
 
 //  2. 分差
 float Dab = Ra - Rb ;
 float Dba = Rb - Ra ;
 
 //  3.胜率の分母の指数
 float indexA = -Dab  /  400.00 ;
 float indexB = -Dba  /  400.00 ;
 
 //  4.
 //  4.1 A对B的期望胜率
 float Ea = 1  / ( 1 + pow(10, indexA) );
 float Eb = 1  / ( 1 + pow(10, indexB) );
 
 //  5. A胜B，B胜A的概率
 float Pab = Ea ;
 float Pba = Eb ;
 
 //  6. 最终比分
 float Wa =  Sa ;
 float Wea = Pab ;
 
 float Wb =  Sb ;
 float Web = Pba ;
 
 float K = 30.0 ;
 float RaFianl = Ra + K * ( Wa - Wea ) ;
 float RbFianl = Rb + K * ( Wb - Web ) ;
 */

@end
