//
//  Toast.h
//  ColorScaner
//
//  Created by wihing on 12-10-21.
//  Copyright (c) 2012年 wihing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Toast : UIView

+ (void)toastWithMessage:(NSString *)message duration:(NSTimeInterval)interval;

@end
