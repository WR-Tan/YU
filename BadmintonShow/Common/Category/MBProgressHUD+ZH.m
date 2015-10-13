//
//  MBProgressHUD+ZH.m
//  BadmintonShow
//
//  Created by lzh on 15/6/26.
//  Copyright (c) 2015年 LZH. All rights reserved.
//

#import "MBProgressHUD+ZH.h"

@implementation MBProgressHUD (ZH)

+ (void)showText:(NSString *)text atView:(UIView *)view animated:(BOOL)animated
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = text;
    HUD.margin = 10.f;
    HUD.removeFromSuperViewOnHide = YES;
    [HUD hide:YES afterDelay:2];
    
}

@end
