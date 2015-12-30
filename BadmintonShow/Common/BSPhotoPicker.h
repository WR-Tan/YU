//
//  BSCommonBusiness.h
//  BadmintonShow
//
//  Created by lizhihua on 12/30/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSPhotoPicker : NSObject

+ (instancetype)shareInstance ;

+ (void)viewController:(UIViewController *)VC pickImageWithBlock:(BSIdResultBlock)block;

@end
