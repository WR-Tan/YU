//
//  BSGameTipModel.h
//  BadmintonShow
//
//  Created by LZH on 15/12/7.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSGameTipModel : NSObject

@property (nonatomic, copy)  NSString *title ;
@property (nonatomic, strong) UIImage *image ;

+ (instancetype)gameTipModelWith:(NSString *)title image:(UIImage *)image;

@end
