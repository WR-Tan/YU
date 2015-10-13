//
//  UIAlertView+x.m
//  common
//
//  Created by czh0766 on 12-5-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIAlertView+x.h"

@implementation UIAlertView (x)

+(id)messageBox:(NSString *)msg buttonTitle:(NSString *)title {
    UIAlertView* dialog = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil 
                                           cancelButtonTitle:title otherButtonTitles:nil];
    [dialog show];
    return dialog;
}

+(id)messageBox:(NSString*)msg buttonTitles:(NSArray*)titles delegate:(id)delegate {
    UIAlertView* dialog = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:delegate
                                    cancelButtonTitle:[titles firstObject] otherButtonTitles:nil];
    for (int i = 1; i < titles.count; i++) {
        [dialog addButtonWithTitle:titles[i]];
    }
    [dialog show];
    return dialog;
}

@end
