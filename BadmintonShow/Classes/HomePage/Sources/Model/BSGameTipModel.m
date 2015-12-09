//
//  BSGameTipModel.m
//  BadmintonShow
//
//  Created by LZH on 15/12/7.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import "BSGameTipModel.h"

@implementation BSGameTipModel

+ (instancetype)gameTipModelWith:(NSString *)title image:(UIImage *)image{

    BSGameTipModel *gameTipModel = [[BSGameTipModel alloc] init];
    gameTipModel.title = title;
    gameTipModel.image = image ;
    
    return gameTipModel;
}

@end
