//
//  ELORankingBusiness.m
//  BadmintonShow
//
//  Created by LZH on 15/12/1.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import "ELORankingBusiness.h"

@implementation ELORankingBusiness

+ (NSArray *)ELOArrayWithARankScore:(NSInteger)Ra bRankScore:(NSInteger)Rb  isAWin:(BOOL)isAWin 
{
    //   0. 1代表赢，0代表输,由比赛结果决定
    float Sa =  isAWin ? 1 : 0;
    float Sb = 1 - Sa ;
    
    //  2. 分差
    float Dab = Ra - Rb ;
    float Dba = Rb - Ra ;
    
    //  3.胜率の分母の指数
    float indexA = -Dab  /  400.00 ;
    float indexB = -Dba  /  400.00 ;
    
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

    //  7.四舍五入
    NSInteger RaFianlInt = (int)(RaFianl+0.5)>(int)RaFianl?(int)RaFianl+1:(int)RaFianl ;
    NSInteger RbFianlInt = (int)(RbFianl+0.5)>(int)RbFianl?(int)RbFianl+1:(int)RbFianl ;
 
    return @[@(RaFianlInt),@(RbFianlInt)];
}

@end
